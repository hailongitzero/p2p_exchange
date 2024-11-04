import 'package:get/get.dart';
import 'package:p2p_exchange/app/models/category.dart';
import 'package:p2p_exchange/app/services/category.dart';

class CategoryController extends GetxController {
  final CategoryService service = CategoryService();
  var categories = <Category>[].obs;
  var filteredCategories = <Category>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    // categories = service.fetchCategories() as RxList<Category>;
    categories = await service.fetchCategories();
  }

  Future<void> addCategory(Category category) async {
    await service.addCategory(category);
  }

  Future<void> updateCategory(Category category) async {
    await service.updateCategory(category);
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
