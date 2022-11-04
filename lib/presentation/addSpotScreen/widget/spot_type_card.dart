import 'package:flutter/material.dart';
import 'package:spot/core/constants.dart';

class SpotTypeCard extends StatelessWidget {
  final String spotType;
  const SpotTypeCard({
    Key? key,
    required this.spotType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Card(
        shadowColor: Colors.green,
        elevation: 10,
        color: kblack,
        child: Container(
          height: screenwidth * .07,
          width: screenwidth * .3,
          child: Center(
            child: Text(
              spotType,
              style: TextStyle(color: kwhite),
            ),
          ),
        ),
      ),
    );
  }
}
