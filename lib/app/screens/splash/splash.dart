import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:p2p_exchange/app/screens/home/home.dart';
import 'package:p2p_exchange/app/screens/login/login.dart';
import 'package:p2p_exchange/app/utils/auth/auth_check.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Loading...',
        home: AnimatedSplashScreen(
            duration: 3000,
            centered: true,
            splash: const Wrap(
              alignment: WrapAlignment.center,
              children: [
                Image(
                  image: AssetImage('lib/assets/images/logo.png'),
                  width: 150,
                  height: 150,
                ),
                Text(
                  'Peer 2 Peer Exchange',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            nextScreen: AuthCheck(
              homeScreen: const HomePage(),
              loginScreen: const LoginPage(),
            ),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.fade,
            backgroundColor: Colors.blue));
  }

  isLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }
}
