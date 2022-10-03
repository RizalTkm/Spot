import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:spot/presentation/addSpotScreen/addSpot.dart';
import 'package:spot/presentation/homeSCreen/Widget/bottomNavigationWidget.dart';
import 'package:spot/presentation/homeSCreen/homescreen.dart';

class mainpage extends StatelessWidget {
  mainpage({super.key});

  final List PageList = [Homescreen(), AddSpotscreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: navigationChangingNotifier,
        builder: (context, int index, child) => pageList[index],
      ),
      bottomNavigationBar: BottomNavigationWidget(),
    );
  }
}
