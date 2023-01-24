import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:spot/core/demoslider.dart';
import 'package:spot/core/worthvisitslider.dart';
import 'package:spot/infrastructure/fire_auth_service.dart';
import 'package:spot/presentation/signInpage.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 80,
            child: ElevatedButton(
                onPressed: () {
                  AuthService().Signout(context).then((value) =>
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Successfully signed out'))));
                },
                child: const Text('Sign out')),
          ),
        ],
      ),
    );
  }
}
