import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:spot/core/constants.dart';
import 'package:spot/infrastructure/fire_auth_service.dart';
import 'package:spot/presentation/addSpotScreen/widget/smallAppbar_widget.dart';
import 'package:spot/presentation/addSpotScreen/widget/standard%20TextFieldMini.dart';
import 'package:spot/presentation/addSpotScreen/widget/standard_font.dart';
import 'package:spot/presentation/addSpotScreen/widget/standard_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  bool isemailverified = false;

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context);
    final emailTextController = TextEditingController();
    final passwordTextController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            child: SmallAppbarWidget(), preferredSize: Size.fromHeight(120)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StandardFont(title: 'Email'),
                  TextfieldMini(
                      maxlines: 1,
                      hintfont: 'Type valid E-mail address',
                      textcontroller: emailTextController),
                  StandardFont(title: 'Password'),
                  TextfieldMini(
                    maxlines: 1,
                    hintfont: 'Type a valid password',
                    textcontroller: passwordTextController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                          onPressed: () async {
                            emailTextController.text.isEmpty ||
                                    passwordTextController.text.isEmpty
                                ? ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('One of the Field is empty')))
                                : await authservice.signInWthEmailPassword(
                                    emailTextController.text,
                                    passwordTextController.text,
                                    context);
                            // Navigator.pushNamed(context, 'verifyEmail').then(
                            //     (value) => ScaffoldMessenger.of(context)
                            //         .showSnackBar(SnackBar(
                            //             content:
                            //                 Text('Verify email to sign in'))));
                          },
                          icon: Icon(Icons.login),
                          label: Text('Sign in')),
                      Kwidth,
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'reset');
                          },
                          child: Text('Forgot password?'))
                    ],
                  ),
                  kheight,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StandardFont(
                        title: "    If you haven't acount sign up below"),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, 'SignUp');
                        },
                        icon: Icon(Icons.create),
                        label: Text('Sign up')),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
