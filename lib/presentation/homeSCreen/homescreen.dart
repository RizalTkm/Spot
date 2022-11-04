import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:spot/core/constants.dart';
import 'package:spot/presentation/addSpotScreen/addSpotScreen.dart';

import 'package:spot/presentation/homeSCreen/Widget/appbar_widget.dart';
import 'package:spot/presentation/homeSCreen/Widget/bottomNavigationWidget.dart';
import 'package:spot/presentation/homeSCreen/Widget/spotcard.dart';

class Homescreen extends StatelessWidget {
  final Stream<QuerySnapshot> spotListDocs = FirebaseFirestore.instance
      .collection('Spot List')
      .orderBy('time_stamp', descending: true)
      .snapshots();
  Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final screenheight = MediaQuery.of(context).size.height;
    // final screenwidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusNode currentfocus = FocusScope.of(context);

          if (!currentfocus.hasPrimaryFocus) {
            currentfocus.unfocus();
          }
        },
        child: Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(120),
              child: AppbarWidget(),
            ),
            body: StreamBuilder<QuerySnapshot>(
                stream: spotListDocs,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot,
                ) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(strokeWidth: 1.5));
                  }
                  final data = snapshot.requireData;
                  // final url = FirebaseFirestore.instance.collection('Spot List').where('url', whereIn: )

                  return ListView.separated(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => spotcard(
                      index: index,
                      document: data.docs[index],
                      spotname: data.docs[index]['spot_name'],
                      spotLocation: data.docs[index]['spot_location'],
                      spotDescription: data.docs[index]['spot_description'],
                      imageurl: data.docs[index]['url_of_first_image'],
                      imageurlList: data.docs[index]['list_of_imageUrl'],
                    ),
                    separatorBuilder: (context, index) => kheight,
                    itemCount: data.size,
                  );
                })),
      ),
    );
  }
}
