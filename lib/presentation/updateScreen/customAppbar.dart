import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spot/core/constants.dart';
import 'package:spot/presentation/updateScreen/updatepage.dart';

class CustomAppbarwidget extends StatelessWidget {
  final String spotname;
  final String spotlocation;
  final String spotdescription;
  final List<dynamic> imageurls;
  CustomAppbarwidget(
      {Key? key,
      required this.spotname,
      required this.spotlocation,
      required this.spotdescription,
      required this.imageurls})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadowColor: Colors.green,
        elevation: 10,
        actionsIconTheme: const IconThemeData(color: kblack),
        iconTheme: const IconThemeData(color: kblack),
        titleTextStyle: const TextStyle(
            color: kblack, fontSize: 20, fontWeight: FontWeight.bold),
        title: Row(
          children: const [
            Icon(Icons.handshake),
            Kwidth,
            Text('Spot'),
          ],
        ),
        actions: const [
          Padding(
            padding: const EdgeInsets.only(top: 10),
          )
        ],
      ),
    );
  }
}
