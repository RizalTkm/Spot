import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:spot/infrastructure/fire_auth_service.dart';
import 'package:spot/presentation/addSpotScreen/widget/standard%20TextFieldMini.dart';
import 'package:spot/presentation/addSpotScreen/widget/standard_font.dart';

class Resetpasswordpage extends StatelessWidget {
  Resetpasswordpage({super.key});

  final resetfieldtextcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StandardFont(
                    title:
                        'Enter registered Email and press Send to send password reset link'),
                TextfieldMini(
                    hintfont: 'Enter registered Email',
                    textcontroller: resetfieldtextcontroller,
                    maxlines: 1),
                ElevatedButton(
                    onPressed: () {
                      AuthService().resetpassword(
                          resetfieldtextcontroller.text, context);
                      resetfieldtextcontroller.clear();
                    },
                    child: Text('Send')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
