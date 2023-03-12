import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mapbox_turn_by_turn/core/globals.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ValueListenableBuilder<bool>(
            valueListenable: deviceLocationPermission,
            builder: (context, isEnabled, child) {
              return Column(
                children: [
                  ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    tileColor: Colors.grey[200],
                    title: const Text("Location Permission:"),
                    subtitle: Text(isEnabled
                        ? 'This device has location permission.'
                        : "Unable display current location because this device denied to access location. Provide location access by going in settings > App permissions then restart the app."),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        {
                          FirebaseAuth.instance.signOut();

                          GoogleSignIn().signOut();

                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        }
                      },
                      child: const Text('Sign out'))
                ],
              );
            }),
      ),
    );
  }
}
