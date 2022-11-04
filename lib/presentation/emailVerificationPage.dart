// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter/src/widgets/framework.dart';
// import 'package:provider/provider.dart';
// import 'package:spot/infrastructure/fire_auth_service.dart';
// import 'package:spot/presentation/addSpotScreen/widget/standard%20TextFieldMini.dart';

// class EmailVerificationpage extends StatelessWidget {
//   EmailVerificationpage({super.key});

//   final emailverificationcontroller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final authservice = Provider.of<AuthService>(context);
//     final timer = Timer(Duration(seconds: 5), () {
//       authservice.checkemailisverified(
//           emailverificationcontroller.text, context);
//     });

//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextfieldMini(
//               hintfont: 'Enter Valid Emailaddress',
//               textcontroller: emailverificationcontroller,
//               maxlines: 1),
//           ElevatedButton.icon(
//               onPressed: () async {
//                 emailverificationcontroller.text.contains('@gmail.com')
//                     ? await authservice
//                         .sendEmailVerification(
//                             emailverificationcontroller.text, context)
//                         .then((value) => ScaffoldMessenger.of(context)
//                             .showSnackBar(SnackBar(
//                                 content: Text(
//                                     'verification link has sent to ${emailverificationcontroller.text}'))))
//                     : ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text(' Enter valid Email address')));

//                 // Navigator.of(context).pushReplacementNamed('login');
//                 // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 //     content: Text('Please verify email before sign in')));
//               },
//               icon: Icon(Icons.email),
//               label: Text('Send verification mail'))
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:spot/core/constants.dart';
import 'package:spot/infrastructure/fire_auth_service.dart';
import 'package:spot/presentation/addSpotScreen/widget/standard_font.dart';
import 'package:spot/presentation/registerPage.dart';
import 'package:spot/presentation/signInpage.dart';

class VerifyEMailpage extends StatelessWidget {
  VerifyEMailpage({super.key});

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context);
    ValueNotifier<bool> isemailverifiednotifier = ValueNotifier(false);

    final timer = Timer.periodic(Duration(seconds: 5), (timer) {
      final verify =
          authservice.checkemailisverified(emailTextController.text, context);

      Future.delayed(Duration(seconds: 30), () {
        timer.cancel();
      });
    });
    final checkemail =
        authservice.checkemailisverified(emailTextController.text, context);

    return SafeArea(
      child: Scaffold(
          body: ValueListenableBuilder(
        valueListenable: isemailverifiednotifier,
        builder: (context, bool newvalue, _) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StandardFont(
                  title:
                      'Verification link has been sent to \n\n${emailTextController.text} \n\nwaiting to verify..',
                ),
                kheight,
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'login');
                    },
                    child: Text('go to login'))
              ],
            ),
          );
        },
      )),
    );
  }
}
