import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:spot/core/OverallRatingSlider.dart';
import 'package:spot/core/constants.dart';

import 'package:spot/domain/Firestore_functions/firebaseHelperFuntions.dart';
import 'package:spot/presentation/updateScreen/updatepage.dart';

class spotcard extends StatelessWidget {
  final String spotname;
  final String spotLocation;
  final String spotDescription;
  final String imageurl;
  final List<dynamic> imageurlList;
  final int index;
  final QueryDocumentSnapshot document;

  const spotcard(
      {super.key,
      required this.document,
      required this.spotname,
      required this.spotLocation,
      required this.imageurl,
      required this.imageurlList,
      required this.spotDescription,
      required this.index});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> spotListDocs = FirebaseFirestore.instance
        .collection('Spot List')
        .orderBy('time_stamp', descending: true)
        .snapshots();

    Future<void> gotoupdatepage() async {
      await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UpdateScreen(
              spotname: spotname,
              spotlocation: spotLocation,
              spotdescription: spotDescription,
              imageurls: imageurlList)));
    }

    final _screenheight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onDoubleTap: gotoupdatepage,
      child: StreamBuilder<QuerySnapshot>(
          stream: spotListDocs,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return Slidable(
              startActionPane: ActionPane(motion: ScrollMotion(), children: [
                SlidableAction(
                  onPressed: ((context) {
                    document.reference.delete();
                    // FirestoreHelperFunctions()
                    //     .deleteDocFromFirebase(index, snapshot);
                  }),
                  icon: Icons.delete,
                )
              ]),
              endActionPane: ActionPane(motion: DrawerMotion(), children: [
                SlidableAction(
                  onPressed: ((context) {}),
                  icon: Icons.archive,
                )
              ]),
              child: Card(
                elevation: 30,
                margin: const EdgeInsets.all(10),
                shadowColor: Colors.green,
                child: Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.5),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.7),
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: NetworkImage(imageurl),
                                  fit: BoxFit.cover)),
                          width: double.infinity,
                          height: 200,
                        ),
                        Container(
                          decoration: BoxDecoration(color: Colors.grey),
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              width: double.infinity,
                              height: 200,
                              child: Column(
                                children: [
                                  kheight10,
                                  Row(
                                    children: [
                                      Icon(Icons.handshake),
                                      Container(
                                        child: Expanded(
                                          child: Text(
                                            spotname,
                                            softWrap: false,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  kheight10,
                                  Row(
                                    children: [
                                      Icon(Icons.location_on),
                                      Container(
                                        child: Expanded(
                                          child: Text(
                                            spotLocation,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      FixedSlider(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.info_outline)),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.favorite_outline)),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.share_outlined)),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.comment_outlined))
                                    ],
                                  )
                                ],
                              )),
                        )
                      ],
                    )),
              ),
            );
          }),
    );
  }
}
