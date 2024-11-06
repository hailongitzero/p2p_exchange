import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/models/product_condition.dart';

class ProductConditionService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var conditions = <ProductCondition>[].obs;

  ProductConditionService();

  Future<RxList<ProductCondition>> fetchConditions() async {
    try {
      firestore.collection('productCondition').snapshots().listen((snapshot) {
        conditions.value = snapshot.docs
            .map((doc) => ProductCondition.fromDocumentSnapshot(doc))
            .toList();
      });
      return conditions;
    } catch (e) {
      throw Exception('Failed to get Product Condition: $e');
    }
  }

  Future<void> addCondition(ProductCondition condition) async {
    try {
      await firestore.collection('productCondition').add(condition.toMap());
    } catch (e) {
      throw Exception('Failed to add Product Condition: $e');
    }
  }

  Future<void> updateCondition(ProductCondition condition) async {
    try {
      await firestore
          .collection('productCondition')
          .doc(condition.id)
          .update(condition.toMap());
    } catch (e) {
      throw Exception('Failed to update Product Condition: $e');
    }
  }
}
