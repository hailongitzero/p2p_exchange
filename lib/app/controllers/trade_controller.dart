// controllers/product_controller.dart
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:p2p_exchange/app/models/Trade.dart';
import 'package:p2p_exchange/app/models/TradeComment.dart';
import 'package:p2p_exchange/app/models/comment.dart';
import 'package:path/path.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p2p_exchange/app/models/product.dart';

class TradeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  var product = Rxn<Product>();
  var tradeList = <Trade>[].obs;
  var trade = Rxn<Trade>();
  var comments = <TradeComment>[].obs;
  var comment = Rxn<TradeComment>();
  var imagesUrls =
      <String>[].obs; // Correct initialization of imagesUrls as RxList<String>
  var isImagesUploading = false.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> getProductComments(String productId) async {
    var snapshot = await _firestore.collection('products').doc(productId).get();
    if (snapshot.exists) {
      var data = Product.fromJson(snapshot.data()!);
      tradeList.value = data.tradeList ?? [];
    }
  }

  void setTradeComments(List<TradeComment>? tradeComments) {
    if (tradeComments != null) {
      comments.assignAll(
          tradeComments); // Use assignAll to update the observable list
    } else {
      comments.clear(); // Clear if null
    }
  }

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

  Future<void> addProductTrade(String productId, Trade newTrade) async {
    try {
      // If there are images uploaded, add them to the new comment
      if (imagesUrls.isNotEmpty) {
        newTrade.images = imagesUrls.value;
      }

      // Set additional comment fields
      newTrade.userId = getCurrentUserId() ?? '';
      newTrade.createdAt = DateTime.now();
      newTrade.status = 'New';

      // Convert the new comment to a map
      Map<String, dynamic> newTradeData = newTrade.toJson();

      var snapshot =
          await _firestore.collection('products').doc(productId).get();
      if (snapshot.exists) {
        var data = Product.fromJson(snapshot.data()!);
        var existTrade =
            data.tradeList?.any((item) => item.userId == getCurrentUserId());
        if (!existTrade!) {
          await _firestore.collection('products').doc(productId).update({
            'tradeList': FieldValue.arrayUnion([newTradeData]),
          });
          await _firestore.collection('users').doc(getCurrentUserId()).update({
            'tradeList': FieldValue.arrayUnion([productId])
          });
        }
      } else {
        await _firestore.collection('products').doc(productId).update({
          'tradeList': FieldValue.arrayUnion([newTradeData]),
        });
        await _firestore.collection('users').doc(getCurrentUserId()).update({
          'tradeList': FieldValue.arrayUnion([productId])
        });
      }
      // Update Firestore by appending the new comment to the comments array

      // Clear the image URLs
      imagesUrls.clear();
    } catch (e) {
      // print("Failed to add comment: $e");
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
