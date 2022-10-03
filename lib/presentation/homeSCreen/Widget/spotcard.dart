import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spot/core/constants.dart';
import 'package:spot/core/icons.dart';

class spotcard extends StatelessWidget {
  const spotcard({super.key});

  final String imageurl =
      'https://vowels.ae/wp-content/uploads/2020/12/expo2020-dubai-scaled.jpg';

  @override
  Widget build(BuildContext context) {
    final _screenheight = MediaQuery.of(context).size.height;
    return Card(
      elevation: 30,
      margin: EdgeInsets.all(10),
      shadowColor: Colors.green,
      child: Container(
          height: 170,
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
                        image: NetworkImage(imageurl), fit: BoxFit.cover)),
                width: double.infinity,
                height: _screenheight * .15,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey),
                  child: Row(
                    children: [
                      Spacer(),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.info_outline)),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.favorite_outline)),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.share_outlined)),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.comment_outlined))
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
