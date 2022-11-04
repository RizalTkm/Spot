import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:spot/domain/userModel.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  UserModel? _userfromfirebase(auth.User? user) {
    if (user == null) {
      return null;
    }

    return UserModel(user.uid, user.email);
  }

  Stream<UserModel?>? get user {
    return _firebaseAuth.authStateChanges().map(_userfromfirebase);
  }

  Future<UserModel?> signInWthEmailPassword(
      String emailid, String password, context) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: emailid, password: password);
      Navigator.of(context).pushReplacementNamed('/');

      return _userfromfirebase(credential.user);
      Navigator.of(context).pushNamed('/');
    } catch (e) {
      error(context, e);
    }
  }

  Future<UserModel?> createUserwithEmailPassword(
      String emailid, String password, context) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailid, password: password);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: const Text('Successfully registered')));

      return _userfromfirebase(credential.user);
    } catch (e) {
      error(context, e);
    }
  }

  Future<void> Signout(context) async {
    try {
      return await _firebaseAuth
          .signOut()
          .then((value) => Navigator.popAndPushNamed(context, 'login'));
    } catch (e) {
      error(context, e);
    }
  }

  Future<void> resetpassword(String email, context) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email).then((value) =>
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Password reset link has been sent'))));
    } catch (e) {
      error(context, e);
    }
  }

  Future<void> sendEmailVerification(String email, context) async {
    try {
      await _firebaseAuth.currentUser!.sendEmailVerification();
    } catch (e) {
      error(context, e);
    }
  }

  checkemailisverified(String email, context) async {
    final _user = await _firebaseAuth.currentUser!;

    _user.reload();
    return _user.emailVerified;
  }
}

error(context, e) async {
  final error = e.toString().split('] ')[1];
  print(error);
  return await ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(error)));
}
