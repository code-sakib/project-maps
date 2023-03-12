import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mapbox_turn_by_turn/core/authentication/utilis/email_widget.dart';
import 'package:mapbox_turn_by_turn/core/authentication/utilis/password_widget.dart';
import 'package:mapbox_turn_by_turn/core/snack_bar.dart';
import 'package:mapbox_turn_by_turn/main.dart';

class GoogleSignInProvider {
  final _googleSignIn = GoogleSignIn();

  static GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future<void> googleLogin(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser?.email == null) {
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
    _user = googleUser;

    final googleAuth = await googleUser!.authentication;

    

    final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    await FirebaseAuth.instance.signInWithCredential(credential);

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future<void> googleSignUp(EmailWidget emailWidget,
      PasswordWidget passwordWidget, BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    await GoogleSignIn().signOut();
    GoogleSignInAccount? googleUser =
        await _googleSignIn.signIn().catchError((err) {
      return Utilis.showSnackBar(err);
    });

    if (googleUser == null) {
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: googleUser!.email, password: googleUser.id);
    } on FirebaseAuthException catch (e) {
      Utilis.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
