import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthCheck extends StatelessWidget {
  final Widget homeScreen;
  final Widget loginScreen;

  AuthCheck({required this.homeScreen, required this.loginScreen});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show a loading indicator while waiting for auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        // Redirect based on login state
        if (snapshot.hasData) {
          return homeScreen; // User is logged in, show home screen
        } else {
          return loginScreen; // User is not logged in, show login screen
        }
      },
    );
  }
}
