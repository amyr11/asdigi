import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/auth_services.dart';
import 'child.dart';

class CustomUser {
  static CollectionReference<Map<String, dynamic>> get userColRef =>
      FirebaseFirestore.instance.collection('Users');

  static Future<String> getID() async {
    return await AuthServices().getCurrentUID();
  }

  static Future<void> addUserID(String userID) async {
    await userColRef.doc(userID).set({'activeChildID': null});
  }

  static Future<String?> getActiveChildID() async {
    String userID = await CustomUser.getID();
    String? activeChildID;
    await userColRef
        .doc(userID)
        .get()
        .then((value) => activeChildID = value.data()!['activeChildID']);
    return activeChildID;
  }

  static Future<void> updateActiveChildID(String? childID) async {
    String userID = await CustomUser.getID();
    await userColRef.doc(userID).update({'activeChildID': childID});
  }

  static Future<void> setActiveChildID(String? childID) async {
    String userID = await CustomUser.getID();
    await userColRef.doc(userID).set({'activeChildID': childID});
  }
}
