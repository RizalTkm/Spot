import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDbModel {
  final String? spotname;

  final String? spotlocation;

  FirebaseDbModel({required this.spotname, required this.spotlocation});

  factory FirebaseDbModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return FirebaseDbModel(
      spotname: data?['name'],
      spotlocation: data?['Location'],
    );
  }
}
