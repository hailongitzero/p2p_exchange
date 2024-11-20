import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:p2p_exchange/app/models/product.dart';

class ProductController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var product = Rxn<Product>();
  var products = <Product>[].obs;
  RxString searchString = ''.obs;
  RxBool onLoad = false.obs;
  RxBool isLoading = false.obs;
  RxBool hasMore = true.obs;
  DocumentSnapshot? lastDocument;
  int currentPage = 1;
  static const int pageSize = 6;
  var sortOrder = 'Giá tăng dần'.obs; // RxString for sort order

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  // Load product details if updating
  Future<void> loadProduct(String productId) async {
    var snapshot = await _firestore.collection('products').doc(productId).get();
    if (snapshot.exists) {
      product.value = Product.fromJson(snapshot.data()!);
    }
  }

  String? getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  void updateSearchParams() {
    lastDocument = null;
    products.value = [];
    hasMore.value = true;
    fetchProducts();
  }

  void fetchProducts() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;

    try {
      Query query = _firestore
          .collection('products')
          .where('status', isEqualTo: 'Stock')
          // .where('name', arrayContains: setSearchParameters(searchString.value))
          .where('name', isGreaterThanOrEqualTo: searchString.value)
          .where('name', isLessThanOrEqualTo: '${searchString.value}\uf8ff')
          .orderBy('name')
          .limit(pageSize);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument!);
      }

      final querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;

        final newProducts = querySnapshot.docs
            .map((doc) => Product.fromDocumentSnapshot(doc))
            .toList();

        products.addAll(newProducts);

        if (newProducts.length < pageSize) {
          hasMore.value = false; // No more products
        }
      } else {
        hasMore.value = false; // No products in query
      }
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  setSearchParameters(String name) {
    List<String> searchOptions = [];
    String temp = "";
    for (int i = 0; i < name.length; i++) {
      temp = temp + name[i];
      searchOptions.add(temp);
    }
    return searchOptions;
  }

  void loadMoreProducts(String query) {
    if (hasMore.value) {
      fetchProducts();
    }
  }

  void searchProducts(String query) {
    fetchProducts();
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
