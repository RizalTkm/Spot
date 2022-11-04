import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:spot/core/constants.dart';
import 'package:spot/infrastructure/fire_auth_service.dart';
import 'package:spot/presentation/addSpotScreen/widget/smallAppbar_widget.dart';
import 'package:spot/presentation/addSpotScreen/widget/standard%20TextFieldMini.dart';
import 'package:spot/presentation/addSpotScreen/widget/standard_font.dart';
import 'package:spot/presentation/addSpotScreen/widget/standard_textfield.dart';

final emailTextController = TextEditingController();

class SingUpScreen extends StatelessWidget {
  const SingUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context);

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
                    hintfont: 'type a valid Email',
                    textcontroller: emailTextController,
                  ),
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
                                : await authservice.createUserwithEmailPassword(
                                    emailTextController.text,
                                    passwordTextController.text,
                                    context);

                            FirebaseAuth.instance.currentUser!.emailVerified ==
                                    false
                                ? Navigator.pushReplacementNamed(
                                        context, 'verifyEmail')
                                    .then((value) => ScaffoldMessenger.of(
                                            context)
                                        .showSnackBar(const SnackBar(
                                            content: Text(
                                                'Verify email brefore sign in'))))
                                : 'email is empty';
                          },
                          icon: const Icon(Icons.app_registration),
                          label: const Text('Sign up')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
