import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spot/core/constants.dart';

class SmallAppbarWidget extends StatelessWidget {
  const SmallAppbarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppBar(
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
            child: CircleAvatar(
              radius: 50,
              foregroundColor: kwhite,
            ),
          )
        ],
      ),
    );
  }
}
