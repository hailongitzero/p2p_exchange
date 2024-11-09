import 'package:get/get.dart';
import 'package:p2p_exchange/app/models/product_condition.dart';
import 'package:p2p_exchange/app/services/product_condition.dart';

class ProductConditionController extends GetxController {
  final ProductConditionService service = ProductConditionService();
  var conditions = <ProductCondition>[].obs;
  var filteredConditions = <ProductCondition>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    conditions = await service.fetchConditions();
  }

  Future<void> addCategory(ProductCondition condition) async {
    await service.addCondition(condition);
  }

  Future<void> updateCategory(ProductCondition condition) async {
    await service.updateCondition(condition);
  }

  void filterCategories(String query) {
    if (query.isEmpty) {
      filteredConditions.value = conditions;
    } else {
      filteredConditions.value = conditions
          .where((category) =>
              category.meaning.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
