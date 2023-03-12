import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mapbox_turn_by_turn/core/authentication/stateMng/google_sign_in_provider.dart';
import 'package:mapbox_turn_by_turn/core/authentication/utilis/email_widget.dart';
import 'package:mapbox_turn_by_turn/core/authentication/utilis/password_widget.dart';
import 'package:mapbox_turn_by_turn/core/snack_bar.dart';
import 'package:mapbox_turn_by_turn/main.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool toSignIn = true;
  void toggle() => setState(() {
        toSignIn = !toSignIn;
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: toSignIn
          ? SignInWidget(onClickedSignUp: toggle)
          : SignUpWidget(
              onClickedSignUp: toggle,
            ),
    );
  }
}

class SignInWidget extends StatefulWidget {
  const SignInWidget({key, required this.onClickedSignUp}) : super(key: key);
  final VoidCallback onClickedSignUp;

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  final emailWid = EmailWidget();
  final passWidget = PasswordWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SizedBox(
          width: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //1
              emailWid,
              //2
              const SizedBox(
                height: 10,
              ),
              passWidget,

              //3
              const SizedBox(
                height: 10,
              ),
              signInButton(),
              //5
              const SizedBox(
                height: 10,
              ),
              googleSignInButton(),
              //4
              const SizedBox(
                height: 10,
              ),
              richText(),
              //5
              const SizedBox(
                height: 5,
              ),
              forgetPasswordButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget googleSignInButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        await GoogleSignInProvider().googleLogin(context);
      },
      icon: FaIcon(
        FontAwesomeIcons.google,
        color: Colors.red[300],
      ),
      label: const Text('Sign In with Google'),
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size(200, 10))),
    );
  }

  Widget forgetPasswordButton() {
    return TextButton(
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent)),
      onPressed: () => Navigator.of(context).pushNamed('/forget_pass_page'),
      child: const Text(
        'Forgot Password?',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

  Widget richText() {
    return RichText(
        text: TextSpan(
            text: 'New User?',
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
          TextSpan(
            text: '  Create account',
            style: const TextStyle(
              color: Colors.blue,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                widget.onClickedSignUp();
              },
          )
        ]));
  }

  Widget signInButton() {
    return ElevatedButton.icon(
        onPressed: () => signIn(),
        icon: const Icon(Icons.login_rounded),
        label: const Text('Sign in'));
  }

  Future<void> signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailWid.text, password: passWidget.text);
    } on FirebaseAuthException catch (e) {
      Utilis.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({key, required this.onClickedSignUp}) : super(key: key);
  final VoidCallback onClickedSignUp;

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final emailWid = EmailWidget(
    toValidate: true,
  );
  final passWidget = PasswordWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SizedBox(
          width: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //1
              emailWid,
              //2
              const SizedBox(
                height: 10,
              ),
              passWidget,

              //3
              const SizedBox(
                height: 10,
              ),
              signUpButton(),
              //5
              const SizedBox(
                height: 10,
              ),
              googleSignUpButton(),
              //4
              const SizedBox(
                height: 10,
              ),
              richText(),
              //5
            ],
          ),
        ),
      ),
    );
  }

  Widget googleSignUpButton() {
    return ElevatedButton.icon(
      onPressed: () async {
        passWidget.isValid
            ? await GoogleSignInProvider()
                .googleSignUp(emailWid, passWidget, context)
            : Utilis.showSnackBar(
                "Enter password for email which you'll select ");
      },
      icon: FaIcon(
        FontAwesomeIcons.google,
        color: Colors.red[300],
      ),
      label: const Text('Sign up with Google'),
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(const Size(220, 10))),
    );
  }

  Widget richText() {
    return RichText(
        text: TextSpan(
            text: 'Already a user?',
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
          TextSpan(
            text: '  Sign In',
            style: const TextStyle(
              color: Colors.blue,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                widget.onClickedSignUp();
              },
          )
        ]));
  }

  Widget signUpButton() {
    return ElevatedButton.icon(
        onPressed: () {
          signUp();
        },
        icon: const Icon(Icons.person_add_alt_1_outlined),
        label: const Text('Sign up'));
  }

  Future<void> signUp() async {
    if (!emailWid.isValid) {
      Utilis.showSnackBar('Enter valid details');
      return;
    }

    if (passWidget.text.length < 6) {
      Utilis.showSnackBar('Password must be atleast 6 characters long');
      return;
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailWid.text, password: passWidget.text);
    } on FirebaseAuthException catch (e) {
      Utilis.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
