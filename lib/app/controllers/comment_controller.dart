// controllers/product_controller.dart
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:p2p_exchange/app/models/comment.dart';
import 'package:path/path.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p2p_exchange/app/models/product.dart';

class CommentController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  var product = Rxn<Product>();
  var comment = Rxn<Comment>();
  var imagesUrls = <String>[].obs; // To hold image slides URLs
  var isImagesUploading = false.obs;

  final ImagePicker _picker = ImagePicker();

  // Pick and upload multiple slide images
  Future<void> pickAndUploadImages() async {
    try {
      final pickedFiles = await _picker.pickMultiImage();
      isImagesUploading.value = true;
      if (pickedFiles.isNotEmpty) {
        for (var file in pickedFiles) {
          String downloadUrl =
              await _uploadImage(File(file.path), 'comment_images');
          imagesUrls.add(downloadUrl);
        }
      }
      isImagesUploading.value = false;
    } catch (e) {
      isImagesUploading.value = false;
    }
  }

  // Upload image to Firebase Storage
  Future<String> _uploadImage(File file, String folder) async {
    String fileName = basename(file.path);
    Reference storageRef = _storage.ref().child('$folder/$fileName');
    await storageRef.putFile(file);
    return await storageRef.getDownloadURL();
  }

  Future<void> updateProductComments(
      String productId, Comment addComment) async {
    try {
      // If there are images uploaded, add them to the comment
      if (imagesUrls.isNotEmpty) {
        addComment.images = imagesUrls.value;
      }

      // Get the current product data
      var productDoc =
          await _firestore.collection('products').doc(productId).get();

      if (productDoc.exists) {
        // Get the existing comments
        var productData = productDoc.data();

        List<Comment> comments = (productData?['comments'] as List<dynamic>?)
                ?.map((item) => Comment.fromMap(item as Map<String, dynamic>))
                .toList() ??
            [];

        // Add the new comment
        addComment.userId = getCurrentUserId() ?? '';
        addComment.createdAt = DateTime.now();
        addComment.likes = 0;
        comments.add(addComment);

        // Convert comments list to a list of maps to update Firestore
        List<Map<String, dynamic>> commentsData =
            comments.map((comment) => comment.toJson()).toList();

        // Update the product document with the new comments list
        await _firestore.collection('products').doc(productId).update({
          'comments': commentsData,
        });

        // Clear the image URLs
        imagesUrls.clear();

        // Optionally, update the product in the controller's local cache
        if (product.value != null && product.value!.productId == productId) {
          product.update((prod) {
            prod?.comments = comments;
          });
        }
      }
    } catch (e) {
      print("Failed to update comments: $e");
    }
  }

  // Insert or update a product
  Future<void> addComment(Comment comment) async {
    if (imagesUrls.isNotEmpty) {
      comment.images = imagesUrls;
    }

    await _firestore.collection('comments').doc().set({
      'userId': getCurrentUserId(),
      'productId': comment.productId,
      'content': comment.content,
      'images': comment.images,
      'createdAt': DateTime.now(),
      'likes': comment.likes,
    });
    imagesUrls.value = [];
  }

  String? getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }
}
