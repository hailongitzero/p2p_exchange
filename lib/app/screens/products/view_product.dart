// controllers/product_controller.dart
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:p2p_exchange/app/models/category.dart';
import 'package:p2p_exchange/app/models/product.dart';

class ProductController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var categories = <Category>[].obs;
  var product = Rxn<Product>();

  // Load categories from Firebase
  Future<void> loadCategories() async {
    var snapshot = await _firestore.collection('categories').get();
    categories.value =
        snapshot.docs.map((doc) => Category.fromMap(doc.data())).toList();
  }

  // Insert or update a product
  Future<void> saveProduct(Product product) async {
    await _firestore.collection('products').doc(product.id).set({
      'name': product.name,
      'description': product.description,
      'price': product.price,
      'categoryId': product.categoryId,
      'mainImage': product.image,
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
}
