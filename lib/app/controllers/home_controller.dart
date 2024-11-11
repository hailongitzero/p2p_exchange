// controllers/product_controller.dart
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:p2p_exchange/app/models/category.dart';
import 'package:p2p_exchange/app/models/product.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var categories = <Category>[].obs;
  var product = Rxn<Product>();
  var products = <Product>[].obs;
  var slides = <Product>[].obs;
  var sortOrder = 'Giá tăng dần'.obs; // RxString for sort order

  // Load categories from Firebase
  Future<void> loadCategories() async {
    var snapshot = await _firestore.collection('categories').get();
    categories.value =
        snapshot.docs.map((doc) => Category.fromMap(doc.data())).toList();
  }

  // Load product details if updating
  Future<void> loadProduct(String productId) async {
    var snapshot = await _firestore.collection('products').doc(productId).get();
    if (snapshot.exists) {
      product.value = Product.fromJson(snapshot.data()!);
    }
  }

  Future<void> loadSlideProducts() async {
    try {
      var snapshot = await _firestore
          .collection('products')
          .where('status', isEqualTo: 'Stock')
          .orderBy('createAt', descending: true)
          .limit(5)
          .get();

      slides.value = snapshot.docs
          .map((doc) => Product.fromDocumentSnapshot(doc))
          .toList();
    } catch (e) {
      return;
    }
  }

  // Load product details if updating
  Future<void> loadProducts() async {
    try {
      // Query Firestore for products with the specified userId
      var snapshot = await _firestore
          .collection('products')
          .where('status', isEqualTo: 'Stock')
          .get();

      // Map the documents to Product objects and add to myProducts
      products.value = snapshot.docs
          .map((doc) => Product.fromDocumentSnapshot(doc))
          .toList();
    } catch (e) {
      // Handle errors here, like logging or showing an error message
    }
  }
}
