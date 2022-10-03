import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spot/core/constants.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _screenheight = MediaQuery.of(context).size.height;
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
        bottom: PreferredSize(
            child: CupertinoSearchTextField(
              itemColor: kblack,
              backgroundColor: Colors.white.withOpacity(.1),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              // padding: EdgeInsets.all(20),
            ),
            preferredSize: Size.fromHeight(_screenheight)),
      ),
    );
  }
}
