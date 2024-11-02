import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future register(String fullName, String email, String password) async {
    try {
      isLoading(true); // Show loading indicator
      errorMessage(''); // Clear previous errors

      // Firebase registration with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update the display name with the full name
      await userCredential.user!.updateDisplayName(fullName);
      await userCredential.user!.reload();

      // Success - redirect to another page or show success message
      Get.snackbar('Success', 'Registration complete');
    } on FirebaseAuthException catch (e) {
      // Handle Firebase specific errors
      if (e.code == 'weak-password') {
        errorMessage('The password is too weak.');
      } else if (e.code == 'email-already-in-use') {
        errorMessage('The email is already in use.');
      } else {
        errorMessage(e.message ?? 'An unknown error occurred.');
      }
    } catch (e) {
      // Handle any other errors
      errorMessage('An error occurred. Please try again.');
    } finally {
      isLoading(false); // Hide loading indicator
    }
  }
}
