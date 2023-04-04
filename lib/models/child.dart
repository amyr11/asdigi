import 'dart:io';

import 'package:asdigi/helpers/auth_services.dart';
import 'package:asdigi/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/storage_services.dart';

class Child {
  static CollectionReference<Map<String, dynamic>> get childrenColRef =>
      FirebaseFirestore.instance.collection('Children');

  int get ageInMonths {
    return DateTime.now().difference(birthDate).inDays ~/ 30;
  }

  String? imageURL;
  String name;
  DateTime birthDate;

  Child({
    this.imageURL,
    required this.name,
    required this.birthDate,
  });

  factory Child.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Child(
      imageURL: snapshot.data()!['imageURL'],
      name: snapshot.data()!['name'],
      birthDate: snapshot.data()!['birthDate'].toDate(),
    );
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
          isEqualTo: await User.getID(),
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

  static Future<Child> getActiveChild() async {
    final activeChildID = await User.getActiveChildID();
    final activeChildDoc = await childrenColRef.doc(activeChildID).get();
    return Child.fromFirestore(activeChildDoc);
  }

  static Future<DocumentReference<Map<String, dynamic>>> uploadToFirestore({
    required name,
    required birthDate,
    File? image,
  }) async {
    // return await Child.childrenColRef.add(child.toFirestore());
    final userID = await User.getID();

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
      final imageURL = await StorageServices().uploadImage(image, imagePath);
      await childDocRef.update({'imageURL': imageURL});
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
    print('age: $age, nearestAge: $nearestAge');
    return nearestAge;
  }
}
