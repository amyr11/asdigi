import 'package:cloud_firestore/cloud_firestore.dart';

class MilestoneChecklistItem {
  final String imageURL;
  final String title;
  int status = -1;

  MilestoneChecklistItem({
    required this.imageURL,
    required this.title,
  });
}

class MilestoneOverviewItem {
  static const int social = 0;
  static const int language = 1;
  static const int cognitive = 2;
  static const int movement = 3;

  static CollectionReference<Map<String, dynamic>>
      get milestoneOverviewColRef =>
          FirebaseFirestore.instance.collection('Milestones');
  final String title;
  final String imageURL;
  final int age;
  final int milestoneCategory;

  MilestoneOverviewItem({
    required this.title,
    required this.imageURL,
    required this.age,
    required this.milestoneCategory,
  });

  factory MilestoneOverviewItem.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    return MilestoneOverviewItem(
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
}
