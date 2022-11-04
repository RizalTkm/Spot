import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot/core/constants.dart';
import 'package:spot/infrastructure/fire_auth_service.dart';
import 'package:spot/infrastructure/wrapper.dart';
import 'package:spot/presentation/emailVerificationPage.dart';
import 'package:spot/presentation/homeSCreen/Widget/mainpage.dart';
import 'package:spot/presentation/homeSCreen/homescreen.dart';
import 'package:spot/presentation/registerPage.dart';
import 'package:spot/presentation/resetPasswordPage.dart';

import 'package:spot/presentation/signInpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spot/presentation/updateScreen/editPage.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Spot());
}

class Spot extends StatelessWidget {
  const Spot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider<AuthService>(create: (_) => AuthService())],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          scaffoldBackgroundColor: kwhite,
          buttonTheme: ButtonThemeData(buttonColor: kblack),
          iconTheme: IconThemeData(color: kblack),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey.withOpacity(.7),
          ),
        ),
        title: 'Spot',
        initialRoute: '/',
        routes: {
          '/': (context) => const Wrapper(),
          'login': (context) => LoginScreen(),
          'SignUp': (context) => const SingUpScreen(),
          'reset': (context) => Resetpasswordpage(),
          'verifyEmail': (context) => VerifyEMailpage(),
        },
      ),
    );
  }
}
