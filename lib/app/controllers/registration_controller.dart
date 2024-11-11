import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:p2p_exchange/app/screens/login/login.dart';

class RegistrationController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  var isPasswordVisible = false.obs;
  var isAccepted = false.obs;
  var errorMessage = ''.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleAcceptance(bool? value) {
    isAccepted.value = value!;
  }

  String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email cannot be empty';
    }
    String pattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  Future<void> register(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    final emailError = validateEmail(email);
    final passwordError = validatePassword(password);

    if (emailError != null || passwordError != null) {
      errorMessage.value = emailError ?? passwordError!;
      return;
    }

    if (password != confirmPassword) {
      errorMessage.value = 'Passwords do not match';
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Retrieve the user after registration
      User? user = userCredential.user;
      if (user != null) {
        await saveUserToFirestore(user);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false, // Remove all previous routes
        );
      }

      // Registration successful
    } on FirebaseAuthException catch (e) {
      errorMessage.value = e.message ?? 'An error occurred';
    }
  }

  Future<void> saveUserToFirestore(User user) async {
    try {
      // Save user information to Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'displayName': user.displayName ?? '',
        'photoURL': user.photoURL ?? '',
        'createdAt': DateTime.now(),
      });
    } catch (e) {
      errorMessage.value = 'Failed to save user data: ${e.toString()}';
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // If new Google user, save to Firestore
      if (userCredential.additionalUserInfo?.isNewUser == true) {
        await saveUserToFirestore(userCredential.user!);
      }
      // Google sign-in successful
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken.tokenString);

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        // If new Facebook user, save to Firestore
        if (userCredential.additionalUserInfo?.isNewUser == true) {
          await saveUserToFirestore(userCredential.user!);
        }
        // Facebook sign-in successful
      } else {
        // Facebook sign-in fail
        return;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }
}
