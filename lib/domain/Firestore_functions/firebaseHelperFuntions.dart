import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spot/domain/Firestore_functions/firestoreImageFunctions.dart';

class FirestoreHelperFunctions {
  // adding spot to firebasefields

  Future<void> addingSpotTofirebase(
      TextEditingController spotnameText,
      String spotLocationText,
      TextEditingController spotdescriptiontext,
      List<File> imageList) async {
    final listofimage = await Firestorefunctions().uploadfiles(imageList);

    final multiImagefirebaseDocMap =
        FirebaseFirestore.instance.collection('Spot List');
    await multiImagefirebaseDocMap.add(<String, dynamic>{
      'spot_name': spotnameText.text.trim(),
      'spot_location': spotLocationText.trim(),
      'list_of_imageUrl': listofimage,
      'url_of_first_image': listofimage[0],
      'spot_description': spotdescriptiontext.text.trim(),
      'time_stamp': DateTime.now().microsecondsSinceEpoch
    });
    spotnameText.clear();

    spotdescriptiontext.clear();
  }

  Future<void> addingSpotToFirebaseWithSingleimage(
      TextEditingController spotnameText,
      String spotLocationText,
      TextEditingController spotdescriptiontext,
      File? image) async {
    final singleimageUrl =
        await Firestorefunctions().writeimagetofirebase(image!);
    final singleImagefirebaseDocMap =
        FirebaseFirestore.instance.collection('Spot List');
    singleImagefirebaseDocMap.add(<String, dynamic>{
      'spot_name': spotnameText.text.trim(),
      'spot_location': spotLocationText.trim(),
      'spot_description': spotdescriptiontext.text.trim(),
      'url_of_first_image': singleimageUrl,
      'list_of_imageUrl': [singleimageUrl],
      'time_stamp': DateTime.now().microsecondsSinceEpoch
    });
    spotnameText.clear();

    spotdescriptiontext.clear();
  }

  void updateDocOfFirebase(
      int index,
      AsyncSnapshot<QuerySnapshot> snapshot,
      TextEditingController spotnameText,
      TextEditingController spotLocationText,
      TextEditingController spotdescriptiontext,
      List<File> imageList) async {
    final Documentref = await FirebaseFirestore.instance
        .runTransaction((Transaction mytransaction) async {
      final listofimage = await Firestorefunctions().uploadfiles(imageList);

      mytransaction.update(snapshot.data!.docs[index].reference, {
        'spot_name': spotnameText.text.trim(),
        'spot_location': spotLocationText.text.trim(),
        'spot_description': spotdescriptiontext.text.trim(),
        'url_of_first_image': listofimage,
        'list_of_imageUrl': listofimage[0],
        'time_stamp': DateTime.now().microsecondsSinceEpoch
      });
    });
  }

  Future<void> deleteDocFromFirebase(
      int index, AsyncSnapshot<QuerySnapshot> snapshot) async {
    final deletedoc = await FirebaseFirestore.instance
        .runTransaction((Transaction mytransaction) async {
      mytransaction.delete(snapshot.data!.docs[index].reference);
    });

    return deletedoc;
  }
}
