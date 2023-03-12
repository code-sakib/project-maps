import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_turn_by_turn/core/snack_bar.dart';
import 'package:mapbox_turn_by_turn/ui/pages/home_page.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  bool isEmailVerified = false;
  bool shouldResend = false;
  Timer? timer;

  Future<void> verificationProcessBegins() async {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      await sendVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerification());
    }
  }

  Future<void> sendVerificationEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();

      setState(() => shouldResend = false);
      Timer.periodic(const Duration(seconds: 5), (_) {});
      setState(() => shouldResend = true);
    } catch (e) {
      Utilis.showSnackBar(e.toString());
    }
  }

  Future<void> checkEmailVerification() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    isEmailVerified ? timer!.cancel() : null;
  }

  @override
  void initState() {
    super.initState();

    verificationProcessBegins();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? const HomePage()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Verification Page'),
              centerTitle: true,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'A verification email has been sent to this email',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton.icon(
                        onPressed: () =>
                            shouldResend ? sendVerificationEmail() : null,
                        icon: const Icon(Icons.attach_email),
                        label: const Text("Resend Email")),
                    const SizedBox(
                      height: 5,
                    ),
                    TextButton(
                        onPressed: () => FirebaseAuth.instance.signOut(),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                        ))
                  ],
                ),
              ),
            ),
          );
  }
}
