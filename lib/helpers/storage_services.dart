import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageServices {
  Future<Reference?> uploadImage(File image, String path) async {
    final storageRef = FirebaseStorage.instance.ref();
    final childImagesRef = storageRef.child(path);
    try {
      await childImagesRef.putFile(image);
    } on FirebaseException catch (e) {
      print(e);
    }
    return storageRef.child(path);
  }

  Future<void> deleteImage(String path) async {
    final storageRef = FirebaseStorage.instance.ref();
    final childImagesRef = storageRef.child(path);
    try {
      await childImagesRef.delete();
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
