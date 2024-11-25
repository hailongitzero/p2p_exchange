// user_controller.dart
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:p2p_exchange/app/models/user.dart';
import 'dart:io';

class UserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Rx<UserModel> userModel = UserModel(
    userSettings: UserSettings(),
    favorites: [],
    location: Location(latitude: 0.0, longitude: 0.0),
    address: Address(street: "", city: "", state: "", zipCode: ""),
  ).obs;

  Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  Future<bool> login(
    String email,
    String password,
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> fetchUserData() async {
    String uid = _auth.currentUser?.uid ?? "";
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    userModel.value = UserModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  Future<void> updateUserData() async {
    String uid = _auth.currentUser?.uid ?? "";
    if (selectedImage.value != null) {
      String imageUrl = await uploadImage(selectedImage.value!);
      userModel.value.profileImage = imageUrl;
    }
    await _firestore
        .collection('users')
        .doc(uid)
        .update(userModel.value.toJson());
  }

  Future<bool> addUserFavorious(String productId) async {
    try {
      String uid = _auth.currentUser?.uid ?? "";

      // Update Firestore by appending the new comment to the comments array
      await _firestore.collection('users').doc(uid).update({
        'favorites': FieldValue.arrayUnion([productId]),
      });
      return true;
    } catch (e) {
      return false;
      // print("Failed to add comment: $e");
    }
  }

  Future<String> uploadImage(File image) async {
    Reference ref = _storage.ref().child('avatars/${_auth.currentUser?.uid}');
    await ref.putFile(image);
    return await ref.getDownloadURL();
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  // Field update methods
  void setUsername(String username) => userModel.value.username = username;
  void setBio(String bio) => userModel.value.bio = bio;
  void setNotificationPreferences(bool value) =>
      userModel.value.userSettings?.notificationPreferences = value;
  void setTheme(String? theme) =>
      userModel.value.userSettings?.theme = theme ?? 'light';
  void setLanguage(String language) =>
      userModel.value.userSettings?.language = language;
  void setLatitude(double latitude) =>
      userModel.value.location?.latitude = latitude;
  void setLongitude(double longitude) =>
      userModel.value.location?.longitude = longitude;
  void setStreet(String street) => userModel.value.address?.street = street;
  void setCity(String city) => userModel.value.address?.city = city;
  void setState(String state) => userModel.value.address?.state = state;
  void setZipCode(String zipCode) => userModel.value.address?.zipCode = zipCode;
}
