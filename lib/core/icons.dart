import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';

class Kiconbutton extends StatelessWidget {
  final String? label;
  final IconData icon;
  const Kiconbutton({super.key, required this.icon, this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(icon),
        ),
        Text(label ?? 'null'),
      ],
    );
  }
}
