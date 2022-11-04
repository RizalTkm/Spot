import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

ValueNotifier _textvaluenotifier = ValueNotifier(false);

class EditableTextWidget extends StatelessWidget {
  EditableTextWidget({super.key, required this.spotText});

  TextEditingController _textEditingController = TextEditingController();
  String spotText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
    );

    // EditableText(
    //   obscureText: true,
    //   obscuringCharacter: 'd',
    //   controller: _textEditingController,
    //   focusNode: FocusNode(),
    //   style: TextStyle(),
    //   cursorColor: Colors.blueGrey,
    //   backgroundCursorColor: Colors.grey,
    // );
  }
}
