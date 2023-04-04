import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageServices {
  Future<String?> uploadImage(File image, String path) async {
    String? imageURL;
    final storageRef = FirebaseStorage.instance.ref();
    final childImagesRef = storageRef.child(path);
    try {
      await childImagesRef.putFile(image);
      await storageRef
          .child(path)
          .getDownloadURL()
          .then((value) => imageURL = value);
    } on FirebaseException catch (e) {
      print(e);
    }
    return imageURL;
  }
}
