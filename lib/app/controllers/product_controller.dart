// controllers/product_controller.dart
import 'dart:io';
import 'package:path/path.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p2p_exchange/app/models/category.dart';
import 'package:p2p_exchange/app/models/product.dart';

class ProductController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  var categories = <Category>[].obs;
  var product = Rxn<Product>();
  var products = <Product>[].obs;
  var mainImageUrl = ''.obs; // To hold the main image URL
  var imageSlidesUrls = <String>[].obs; // To hold image slides URLs
  var sortOrder = 'Giá tăng dần'.obs; // RxString for sort order

  final ImagePicker _picker = ImagePicker();

  // Load categories from Firebase
  Future<void> loadCategories() async {
    var snapshot = await _firestore.collection('categories').get();
    categories.value =
        snapshot.docs.map((doc) => Category.fromMap(doc.data())).toList();
  }

  // Pick and upload the main image
  Future<void> pickAndUploadMainImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      String downloadUrl =
          await _uploadImage(File(pickedFile.path), 'main_images');
      mainImageUrl.value = downloadUrl;
    }
  }

  // Pick and upload multiple slide images
  Future<void> pickAndUploadSlideImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      for (var file in pickedFiles) {
        String downloadUrl =
            await _uploadImage(File(file.path), 'slide_images');
        imageSlidesUrls.add(downloadUrl);
      }
    }
  }

  // Upload image to Firebase Storage
  Future<String> _uploadImage(File file, String folder) async {
    String fileName = basename(file.path);
    Reference storageRef = _storage.ref().child('$folder/$fileName');
    await storageRef.putFile(file);
    return await storageRef.getDownloadURL();
  }

  // Insert or update a product
  Future<void> saveProduct(Product product) async {
    await _firestore.collection('products').doc(product.productId).set({
      'name': product.name,
      'description': product.description,
      'price': product.price,
      'categoryId': product.categoryId,
      'mainImage': product.mainImage,
      'imageSlides': product.imageSlides,
      'createdAt': product.createdAt,
      'userId': product.userId,
      'comments': product.comments,
      'tradeList': product.tradeList,
    });
  }

  // Load product details if updating
  Future<void> loadProduct(String productId) async {
    var snapshot = await _firestore.collection('products').doc(productId).get();
    if (snapshot.exists) {
      product.value = Product.fromMap(snapshot.data()!);
    }
  }

  // Load product details if updating
  Future<void> loadProducts(String productId) async {
    var snapshot = await _firestore.collection('products').doc(productId).get();
    if (snapshot.exists) {
      product.value = Product.fromMap(snapshot.data()!);
    }
  }

  // Method to sort products based on sort order
  void sortProducts() {
    if (sortOrder.value == 'Giá tăng dần') {
      products.sort((a, b) => a.price.compareTo(b.price));
    } else {
      products.sort((a, b) => b.price.compareTo(a.price));
    }
  }
}
