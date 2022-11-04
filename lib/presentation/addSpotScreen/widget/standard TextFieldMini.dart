import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextfieldMini extends StatelessWidget {
  final String hintfont;
  final int maxlines;
  final textcontroller;
  TextfieldMini(
      {Key? key,
      required this.hintfont,
      required this.textcontroller,
      required this.maxlines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenwidth * .04),
      child: TextFormField(
        maxLines: maxlines,
        maxLength: 200,
        inputFormatters: [FilteringTextInputFormatter.deny("  ")],
        controller: textcontroller,
        enabled: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'type something';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
            hintText: hintfont,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.blueGrey, style: BorderStyle.solid)),
            border: OutlineInputBorder()),
      ),
    );
  }
}
