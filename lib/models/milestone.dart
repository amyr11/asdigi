import 'package:asdigi/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MilestoneChecklistItem {
  static Future<CollectionReference<Map<String, dynamic>>>
      getMilestoneChecklistColRef() async {
    String activeChildID = await User.getActiveChildID();
    return FirebaseFirestore.instance
        .collection('Children')
        .doc(activeChildID)
        .collection('MilestoneChecklist');
  }

  final String? checklistItemID;
  final String? milestoneID;
  final String imageURL;
  final String title;
  final int milestoneCategory;
  int status;

  MilestoneChecklistItem({
    this.checklistItemID,
    this.milestoneID,
    this.status = -1,
    required this.imageURL,
    required this.title,
    required this.milestoneCategory,
  });

  static Future<MilestoneChecklistItem> fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) async {
    MilestoneOverviewItem milestoneOverview =
        await MilestoneOverviewItem.getDataFromFirestore(
            snapshot.data()!['milestoneID']);

    return MilestoneChecklistItem(
      checklistItemID: snapshot.id,
      imageURL: milestoneOverview.imageURL,
      title: milestoneOverview.title,
      milestoneCategory: milestoneOverview.milestoneCategory,
      status: snapshot.data()!['status'],
    );
  }

  static Future<List<MilestoneChecklistItem>> getAllFromFirestore() async {
    List<MilestoneChecklistItem> data = [];
    CollectionReference<Map<String, dynamic>> milestoneChecklistColRef =
        await getMilestoneChecklistColRef();
    await milestoneChecklistColRef.get().then(
      (querySnapshot) async {
        print("Successfully completed checklist");
        for (var docSnapshot in querySnapshot.docs) {
          data.add(await MilestoneChecklistItem.fromFirestore(docSnapshot));
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return data;
  }

  static void updateChecklist(List<MilestoneChecklistItem> checklist) async {
    CollectionReference<Map<String, dynamic>> milestoneChecklistColRef =
        await getMilestoneChecklistColRef();
    for (MilestoneChecklistItem item in checklist) {
      await milestoneChecklistColRef.doc(item.checklistItemID).update({
        'status': item.status,
      });
    }
  }

  static Future<List<MilestoneChecklistItem>> getChecklistForAge(
      int age) async {
    List<MilestoneOverviewItem> milestones =
        await MilestoneOverviewItem.getMilestonesForAge(age);
    List<MilestoneChecklistItem> checklist = [];
    for (MilestoneOverviewItem milestone in milestones) {
      checklist.add(MilestoneChecklistItem(
        milestoneID: milestone.milestoneID,
        imageURL: milestone.imageURL,
        title: milestone.title,
        milestoneCategory: milestone.milestoneCategory,
        status: -1,
      ));
    }
    return checklist;
  }

  static uploadToFireStore(
      {required String childID,
      required List<MilestoneChecklistItem> checklist}) async {
    CollectionReference<Map<String, dynamic>> colRef = FirebaseFirestore
        .instance
        .collection('Children')
        .doc(childID)
        .collection('MilestoneChecklist');
    // Delete all existing checklist items
    await colRef.get().then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        docSnapshot.reference.delete();
      }
    });
    // Upload new checklist items
    for (MilestoneChecklistItem item in checklist) {
      await colRef.add({
        'milestoneID': item.milestoneID,
        'status': item.status,
      });
    }
  }
}

class MilestoneOverviewItem {
  static const int social = 0;
  static const int language = 1;
  static const int cognitive = 2;
  static const int movement = 3;

  static CollectionReference<Map<String, dynamic>>
      get milestoneOverviewColRef =>
          FirebaseFirestore.instance.collection('Milestones');
  final String? milestoneID;
  final String title;
  final String imageURL;
  final int age;
  final int milestoneCategory;

  MilestoneOverviewItem({
    this.milestoneID,
    required this.title,
    required this.imageURL,
    required this.age,
    required this.milestoneCategory,
  });

  factory MilestoneOverviewItem.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    return MilestoneOverviewItem(
      milestoneID: snapshot.id,
      title: snapshot.data()!['title'],
      imageURL: snapshot.data()!['imageURL'],
      age: snapshot.data()!['age'],
      milestoneCategory: snapshot.data()!['milestoneCategory'],
    );
  }

  static Future<List<MilestoneOverviewItem>> getAllFromFirestore() async {
    List<MilestoneOverviewItem> data = [];
    await milestoneOverviewColRef.get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          data.add(MilestoneOverviewItem.fromFirestore(docSnapshot));
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return data;
  }

  static Future<MilestoneOverviewItem> getDataFromFirestore(
      String milestoneID) async {
    late MilestoneOverviewItem data;
    await milestoneOverviewColRef.doc(milestoneID).get().then(
      (querySnapshot) {
        print("Successfully completed");
        data = MilestoneOverviewItem.fromFirestore(querySnapshot);
        print('${querySnapshot.id} => ${querySnapshot.data()}');
      },
      onError: (e) => print("Error completing: $e"),
    );
    return data;
  }

  static Future<List<MilestoneOverviewItem>> getMilestonesForAge(
      int age) async {
    List<MilestoneOverviewItem> data = [];
    await milestoneOverviewColRef.where('age', isEqualTo: age).get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          data.add(MilestoneOverviewItem.fromFirestore(docSnapshot));
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return data;
  }

  static Future<List<int>> getUniqueAges() async {
    List<MilestoneOverviewItem> allMilestones =
        await MilestoneOverviewItem.getAllFromFirestore();

    // get the unique ages from milestones
    return <int>{
      ...allMilestones.map((e) => e.age),
    }.toList();
  }
}
