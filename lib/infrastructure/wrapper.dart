import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:spot/domain/userModel.dart';
import 'package:spot/infrastructure/fire_auth_service.dart';
import 'package:spot/presentation/homeSCreen/Widget/mainpage.dart';
import 'package:spot/presentation/homeSCreen/homescreen.dart';
import 'package:spot/presentation/signInpage.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authservice = Provider.of<AuthService>(context);

    return StreamBuilder<UserModel?>(
      stream: authservice.user,
      builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final UserModel? user = snapshot.data;

          return user == null ? LoginScreen() : mainpage();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
