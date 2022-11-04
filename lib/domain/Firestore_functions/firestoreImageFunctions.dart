import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';

class Firestorefunctions {
  Future<List<String>> uploadfiles(List<File> imagefiles) async {
    final imageurl = await Future.wait(
        imagefiles.map((imagefile) => writeimagetofirebase(imagefile)));

    print(imageurl);
    return imageurl;
  }

  Future<String> writeimagetofirebase(File imagefile) async {
    final firestorageref = FirebaseStorage.instance
        .ref()
        .child("spot_images")
        .child('posts/${DateTime.now().microsecondsSinceEpoch}');

    await firestorageref.putFile(
      imagefile,
    );

    final imageurlfromcamera = await firestorageref.getDownloadURL();

    return imageurlfromcamera;
  }
}
