import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:spot/core/constants.dart';
import 'package:spot/presentation/addSpotScreen/addSpot.dart';

import 'package:spot/presentation/homeSCreen/Widget/appbar_widget.dart';
import 'package:spot/presentation/homeSCreen/Widget/bottomNavigationWidget.dart';
import 'package:spot/presentation/homeSCreen/Widget/spotcard.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenheight * .15),
            child: const AppbarWidget(),
          ),
          body: Container(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => spotcard(),
              separatorBuilder: (context, index) => kheight,
              itemCount: 20,
            ),
          )),
    );
  }
}
