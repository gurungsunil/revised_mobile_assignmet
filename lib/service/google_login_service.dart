import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginService {
  static final _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  static Future<void> handleSignIn(BuildContext context) async {
    try {
      final res = await _googleSignIn.signIn();
      if (res != null) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Google Sign in success"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        "You have successfully sign in  as ${res.displayName}"),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 240,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          _googleSignIn.signOut();
                          Navigator.pop(context);
                        },
                        child: const Text("Logout"),
                      ),
                    )
                  ],
                ),
              );
            });
      }
    } catch (error) {
      log(error.toString());
    }
  }
}
