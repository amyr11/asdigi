import 'package:cloud_firestore/cloud_firestore.dart';

import 'child.dart';

class DevelopmentalResourceOverview {
  static CollectionReference<Map<String, dynamic>>
      get developmentalResourceOverviewsColRef =>
          FirebaseFirestore.instance.collection('resourceOverviews');

  static const int activityCategory = 0;
  static const int tipsCategory = 1;

  final String? resourceID;
  final String title;
  final String description;
  final String imageURL;
  final int milestoneCategory;
  final int resourceCategory;

  DevelopmentalResourceOverview({
    this.resourceID,
    required this.title,
    required this.description,
    required this.imageURL,
    required this.milestoneCategory,
    required this.resourceCategory,
  });

  factory DevelopmentalResourceOverview.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    return DevelopmentalResourceOverview(
      resourceID: snapshot.id,
      title: snapshot.data()!['title'],
      description: snapshot.data()!['description'],
      imageURL: snapshot.data()!['imageURL'],
      milestoneCategory: snapshot.data()!['milestoneCategory'],
      resourceCategory: snapshot.data()!['resourceCategory'],
    );
  }

  static String getResourceCategoryString(int resourceCategory) {
    switch (resourceCategory) {
      case DevelopmentalResourceOverview.activityCategory:
        return "Activity";
      case DevelopmentalResourceOverview.tipsCategory:
        return "Tips";
      default:
        return "Unknown";
    }
  }

  static Future<List<DevelopmentalResourceOverview>>
      getAllFromFirestore() async {
    List<DevelopmentalResourceOverview> data = [];
    await developmentalResourceOverviewsColRef.get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          data.add(DevelopmentalResourceOverview.fromFirestore(docSnapshot));
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return data;
  }

  static bool isResourcePinned({required Child child, required resourceID}) {
    if (child.pinnedResourcesID == null) {
      return false;
    } else {
      return child.pinnedResourcesID!.contains(resourceID);
    }
  }
}

class DevelopmentalResourceContent {
  static CollectionReference<Map<String, dynamic>>
      get developmentalResourceContentsColRef =>
          FirebaseFirestore.instance.collection('resourceContents');
  final String resourceID;
  final String content;

  DevelopmentalResourceContent({
    required this.resourceID,
    required this.content,
  });

  factory DevelopmentalResourceContent.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    return DevelopmentalResourceContent(
      resourceID: snapshot.data()!['resourceID'],
      content: snapshot.data()!['content'],
    );
  }

  static Future<DevelopmentalResourceContent> getDataFromFirestore(
      String resourceID) async {
    DevelopmentalResourceContent data = DevelopmentalResourceContent(
      resourceID: "",
      content: "",
    );
    await developmentalResourceContentsColRef
        .where(
          'resourceID',
          isEqualTo: resourceID,
        )
        .get()
        .then(
      (querySnapshot) {
        print("Successfully completed");
        data = DevelopmentalResourceContent.fromFirestore(
            querySnapshot.docs.first);
        print(
            '${querySnapshot.docs.first.id} => ${querySnapshot.docs.first.data()}');
      },
      onError: (e) => print("Error completing: $e"),
    );
    return data;
  }
}
