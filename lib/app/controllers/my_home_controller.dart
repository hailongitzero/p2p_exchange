// controllers/product_controller.dart
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p2p_exchange/app/models/category.dart';
import 'package:p2p_exchange/app/models/product.dart';

class MyHomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  var categories = <Category>[].obs;
  var product = Rxn<Product>();
  var products = <Product>[].obs;
  var myProducts = <Product>[].obs;
  var saleProducts = <Product>[].obs;
  var imageSlidesUrls = <String>[].obs; // To hold image slides URLs
  var isImageSlidesUploading = false.obs;
  var mainImageUrl = ''.obs; // To hold the main image URL
  var isMainImageUploading = false.obs;
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
    try {
      isMainImageUploading.value = true;
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        String downloadUrl =
            await _uploadImage(File(pickedFile.path), 'images/products');
        mainImageUrl.value = downloadUrl;
      }
      isMainImageUploading.value = false;
    } catch (e) {
      isMainImageUploading.value = false;
    }
  }

  // Pick and upload multiple slide images
  Future<void> pickAndUploadSlideImages() async {
    try {
      final pickedFiles = await _picker.pickMultiImage();
      isImageSlidesUploading.value = true;
      if (pickedFiles.isNotEmpty) {
        for (var file in pickedFiles) {
          String downloadUrl =
              await _uploadImage(File(file.path), 'slide_images');
          imageSlidesUrls.add(downloadUrl);
        }
      }
      isImageSlidesUploading.value = false;
    } catch (e) {
      isImageSlidesUploading.value = false;
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
  Future<void> saveProduct(Product editProduct) async {
    if (imageSlidesUrls.isNotEmpty) {
      editProduct.imageSlides = imageSlidesUrls;
    }
    if (mainImageUrl.value.isNotEmpty) {
      editProduct.image = mainImageUrl.value;
    }

    await _firestore.collection('products').doc(editProduct.productId).set({
      'name': editProduct.name,
      'description': editProduct.description,
      'price': editProduct.price,
      'quantity': editProduct.quantity,
      'categoryId': editProduct.categoryId,
      'image': editProduct.image,
      'imageSlides': editProduct.imageSlides,
      'status': 'Stock',
      'condition': editProduct.condition,
      'createdAt': DateTime.now(),
      'userId': getCurrentUserId(),
      'comments': editProduct.comments,
      'tradeList': editProduct.tradeList,
    });
    imageSlidesUrls.value = [];
    mainImageUrl.value = '';
    product.value = null;
  }

  // Load product details if updating
  Future<void> loadProduct(String productId) async {
    var snapshot = await _firestore.collection('products').doc(productId).get();
    if (snapshot.exists) {
      product.value = Product.fromJson(snapshot.data()!);
    }
  }

  // Load product details if updating
  Future<void> loadProducts(String productId) async {
    var snapshot = await _firestore.collection('products').doc(productId).get();
    if (snapshot.exists) {
      product.value = Product.fromJson(snapshot.data()!);
    }
  }

  // Load product details if updating
  Future<void> loadMyProducts() async {
    try {
      // Query Firestore for products with the specified userId
      var snapshot = await _firestore
          .collection('products')
          .where('userId', isEqualTo: getCurrentUserId())
          .get();

      // Map the documents to Product objects and add to myProducts
      myProducts.value = snapshot.docs
          .map((doc) => Product.fromDocumentSnapshot(doc))
          .toList();
    } catch (e) {
      // Handle errors here, like logging or showing an error message
      myProducts.value = [];
    }
  }

  Future<void> loadMySaleProducts() async {
    try {
      // Query Firestore for products with the specified userId
      var snapshot = await _firestore
          .collection('products')
          .where('userId', isEqualTo: getCurrentUserId())
          .where('status', isEqualTo: 'Stock')
          .get();

      saleProducts.value = snapshot.docs
          .map((doc) => Product.fromDocumentSnapshot(doc))
          .toList();
      // Map the documents to Product objects and add to myProducts
      // saleProducts.value =
      //     snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList();
    } catch (e) {
      // Handle errors here, like logging or showing an error message
      saleProducts.value = [];
    }
  }

  Future<void> loadMoreSaleProducts() async {
    try {
      // Query Firestore for products with the specified userId
      var snapshot = await _firestore
          .collection('products')
          .where('userId', isEqualTo: getCurrentUserId())
          .where('status', isEqualTo: 'Stock')
          .get();

      // Map the documents to Product objects and add to myProducts
      saleProducts.value =
          snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList();
    } catch (e) {
      // Handle errors here, like logging or showing an error message
      saleProducts.value = [];
    }
  }

  String? getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  // Method to sort products based on sort order
  void sortProducts() {
    if (sortOrder.value == 'Giá tăng dần') {
      products.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
    } else {
      products.sort((a, b) => (a.price ?? 0).compareTo(a.price ?? 0));
    }
  }
}
