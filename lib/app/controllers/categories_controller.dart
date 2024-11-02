import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/models/category.dart';

class CategoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var categories = <Category>[].obs;
  var filteredCategories = <Category>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories() {
    _firestore.collection('categories').snapshots().listen((snapshot) {
      categories.value = snapshot.docs
          .map((doc) => Category.fromDocumentSnapshot(doc))
          .toList();
    });
  }

  Future<void> addCategory(Category category) async {
    await _firestore.collection('categories').add(category.toMap());
  }

  Future<void> updateCategory(Category category) async {
    await _firestore
        .collection('categories')
        .doc(category.id)
        .update(category.toMap());
  }

  void filterCategories(String query) {
    if (query.isEmpty) {
      filteredCategories.value = categories;
    } else {
      filteredCategories.value = categories
          .where((category) =>
              category.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
