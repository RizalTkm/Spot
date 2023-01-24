import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:spot/core/constants.dart';
import 'package:spot/infrastructure/fire_auth_service.dart';
import 'package:spot/infrastructure/wrapper.dart';
import 'package:spot/presentation/emailVerificationPage.dart';

import 'package:spot/presentation/registerPage.dart';
import 'package:spot/presentation/resetPasswordPage.dart';

import 'package:spot/presentation/signInpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spot/presentation/splash_screen/splash_screen.dart';

@pragma('vm:entry-poingt')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.setAutoInitEnabled(true);

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const Spot());
}

class Spot extends StatelessWidget {
  const Spot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [Provider<AuthService>(create: (_) => AuthService())],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
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
        initialRoute: 'splash',
        routes: {
          '/': (context) => const Wrapper(),
          'login': (context) => LoginScreen(),
          'SignUp': (context) => const SingUpScreen(),
          'reset': (context) => Resetpasswordpage(),
          'verifyEmail': (context) => VerifyEMailpage(),
          'splash': (context) => const SplashScreen()
        },
      ),
    );
  }
}
