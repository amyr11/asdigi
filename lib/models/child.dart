import 'dart:io';

import 'package:asdigi/helpers/auth_services.dart';
import 'package:asdigi/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../helpers/storage_services.dart';

class Child {
  static CollectionReference<Map<String, dynamic>> get childrenColRef =>
      FirebaseFirestore.instance.collection('Children');

  int get ageInMonths {
    return DateTime.now().difference(birthDate).inDays ~/ 30;
  }

  String? childID;
  String? imageURL;
  List<String>? pinnedResourcesID;
  String name;
  DateTime birthDate;

  Child({
    this.childID,
    this.imageURL,
    this.pinnedResourcesID,
    required this.name,
    required this.birthDate,
  });

  factory Child.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Child(
      childID: snapshot.id,
      imageURL: snapshot.data()!['imageURL'],
      name: snapshot.data()!['name'],
      birthDate: snapshot.data()!['birthDate'].toDate(),
      pinnedResourcesID: snapshot.data()!['pinnedResourcesID'] == null
          ? null
          : List<String>.from(snapshot.data()!['pinnedResourcesID']),
    );
  }

  static String getAgeString(int ageInMonths) {
    String word = '';
    bool isYear = ageInMonths % 12 == 0;
    if (isYear) {
      ageInMonths = ageInMonths ~/ 12;
      word = ageInMonths > 1 ? 'years' : 'year';
    } else {
      word = ageInMonths > 1 ? 'months' : 'month';
    }
    return '$ageInMonths $word old';
  }

  static String getAgeStringInYears(int ageInMonths) {
    String word = '';
    bool isYear = ageInMonths >= 12;
    if (isYear) {
      ageInMonths = ageInMonths ~/ 12;
      word = ageInMonths > 1 ? 'years' : 'year';
    } else {
      word = ageInMonths > 1 ? 'months' : 'month';
    }
    return '$ageInMonths $word old';
  }

  Map<String, dynamic> toFirestore() {
    return {
      'imageURL': imageURL,
      'name': name,
      'birthDate': Timestamp.fromDate(birthDate),
    };
  }

  static Future<List<Child>> getAllFromFirestore() async {
    List<Child> data = [];
    await childrenColRef
        .where(
          'userID',
          isEqualTo: await CustomUser.getID(),
        )
        .get()
        .then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          data.add(Child.fromFirestore(docSnapshot));
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return data;
  }

  static Future<Child?> getActiveChild() async {
    String? activeChildID = await CustomUser.getActiveChildID();
    if (activeChildID == null) {
      return null;
    } else {
      DocumentSnapshot<Map<String, dynamic>> activeChildDoc =
          await childrenColRef.doc(activeChildID).get();
      return Child.fromFirestore(activeChildDoc);
    }
  }

  static Future<DocumentReference<Map<String, dynamic>>> uploadToFirestore({
    required name,
    required birthDate,
    File? image,
  }) async {
    // return await Child.childrenColRef.add(child.toFirestore());
    final userID = await CustomUser.getID();

    // Upload the child first to Firestore
    final childDocRef = await Child.childrenColRef.add({
      'userID': userID,
      'name': name,
      'birthDate': Timestamp.fromDate(birthDate),
    });
    final childID = childDocRef.id;

    // Then, if image is not null, upload it to Storage and update imageURL field in Firestore
    if (image != null) {
      final imagePath =
          'users/$userID/children/$childID.${image.path.split('.').last}';
      final Reference? storageRef =
          await StorageServices().uploadImage(image, imagePath);
      await childDocRef.update({
        'imageURL': await storageRef!.getDownloadURL(),
        'imagePath': storageRef.fullPath
      });

      print('Added Child w/ image');
    } else {
      print('Added Child w/o image');
    }
    return childDocRef;
  }

  static int getNearestAge({
    required int age,
    required List<int> availableAges,
  }) {
    availableAges.sort();
    if (age > availableAges.last) {
      return availableAges.last;
    }

    int nearestAge = availableAges[0];
    for (int availableAge in availableAges) {
      if ((age - availableAge).abs() < (age - nearestAge).abs()) {
        nearestAge = availableAge;
      }
    }
    return nearestAge;
  }

  static Future<void> updatePinnedResourceID(Child child) async {
    await childrenColRef.doc(child.childID).update({
      'pinnedResourcesID': child.pinnedResourcesID,
    });
  }

  static Future<void> deleteFromFirestore(Child child) async {
    CollectionReference<Map<String, dynamic>> checklistColRef =
        FirebaseFirestore.instance
            .collection('Children')
            .doc(child.childID)
            .collection('MilestoneChecklist');
    // Delete all documents in the collection one by one
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await checklistColRef.get();
    // delete pictures from cloud storage
    childrenColRef.doc(child.childID).get().then((value) async {
      if (value.data()!['imagePath'] != null) {
        await StorageServices().deleteImage(value.data()!['imagePath']);
      }
    });

    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      await documentSnapshot.reference.delete();
    }

    await childrenColRef.doc(child.childID).delete();
  }
}
