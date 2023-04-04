import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/auth_services.dart';
import 'child.dart';

class User {
  static CollectionReference<Map<String, dynamic>> get userColRef =>
      FirebaseFirestore.instance.collection('Users');

  static Future<String> getID() async {
    return await AuthServices().getCurrentUID();
  }

  static Future<String> getActiveChildID() async {
    String userID = await User.getID();
    late String activeChildID;
    await userColRef
        .doc(userID)
        .get()
        .then((value) => activeChildID = value.data()!['activeChildID']);
    return activeChildID;
  }

  static Future<void> updateActiveChildID(String childID) async {
    String userID = await User.getID();
    await userColRef.doc(userID).update({'activeChildID': childID});
  }
}
