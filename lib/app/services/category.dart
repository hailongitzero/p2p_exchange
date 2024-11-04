import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/models/category.dart';

class CategoryService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var categories = <Category>[].obs;

  CategoryService();

  Future<RxList<Category>> fetchCategories() async {
    try {
      firestore.collection('categories').snapshots().listen((snapshot) {
        categories.value = snapshot.docs
            .map((doc) => Category.fromDocumentSnapshot(doc))
            .toList();
      });
      return categories;
    } catch (e) {
      throw Exception('Failed to get categories: $e');
    }
  }

  Future<void> addCategory(Category category) async {
    try {
      await firestore.collection('categories').add(category.toMap());
    } catch (e) {
      throw Exception('Failed to add category: $e');
    }
  }

  Future<void> updateCategory(Category category) async {
    try {
      await firestore
          .collection('categories')
          .doc(category.id)
          .update(category.toMap());
    } catch (e) {
      throw Exception('Failed to update category: $e');
    }
  }
}
