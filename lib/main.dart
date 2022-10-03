import 'package:flutter/material.dart';
import 'package:spot/core/constants.dart';
import 'package:spot/presentation/homeSCreen/Widget/mainpage.dart';
import 'package:spot/presentation/homeSCreen/homescreen.dart';

void main() {
  runApp(const Spot());
}

class Spot extends StatelessWidget {
  const Spot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: kwhite,
        buttonTheme: ButtonThemeData(buttonColor: kblack),
        iconTheme: IconThemeData(color: kblack),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.withOpacity(.7),
        ),
      ),
      title: 'Spot',
      home: mainpage(),
    );
  }
}
