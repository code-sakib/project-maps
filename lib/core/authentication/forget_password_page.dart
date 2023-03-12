import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_turn_by_turn/core/authentication/utilis/email_widget.dart';
import 'package:mapbox_turn_by_turn/core/snack_bar.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final emailWid = EmailWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Reset Password'),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          width: 250,
          child: Column(
            children: [
              //1
              emailWid,
              //2
              const SizedBox(
                height: 10,
              ),
              //3
              resetButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget resetButton() {
    return ElevatedButton.icon(
        onPressed: () => resetPassword(),
        icon: const Icon(Icons.lock_reset_rounded),
        label: const Text('Reset Password'));
  }

  resetPassword() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: ((context) => const Center(child: CircularProgressIndicator())),
    );
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailWid.text);

      Utilis.showSnackBar('Check your email to reset the password');

      // ignore: use_build_context_synchronously
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      Utilis.showSnackBar(e.message);
      Navigator.pop(context);
    }
  }
}
