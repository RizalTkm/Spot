import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StandardTextField extends StatelessWidget {
  final String hintfont;
  final textcontroller;
  StandardTextField(
      {Key? key, required this.hintfont, required this.textcontroller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenwidth * .04),
      child: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter('  ', allow: false),
          FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
        ],
        controller: textcontroller,
        enabled: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return ('Please enter any value');
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
