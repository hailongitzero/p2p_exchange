import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProductController extends GetxController {
  var sortOrder = 'Giá tăng dần'.obs; // RxString for sort order
  var products = <Map<String, dynamic>>[].obs; // RxList to hold products

  @override
  void onInit() {
    // Initialize with some products
    products.value = [
      {
        "image": "https://placehold.co/150",
        "title": "Khẩu trang Welcare",
        "price": 65000,
        "old_price": 70000,
        "discount": "7%",
        "sold": "Đã bán 30.3k",
      },
      {
        "image": "https://placehold.co/150",
        "title": "JN95 MASK",
        "price": 44000,
        "old_price": 119000,
        "discount": "72%",
        "sold": "Đã bán 117.2k",
      },
      {
        "image": "https://placehold.co/150",
        "title": "Khẩu trang y tế Omedo",
        "price": 89000,
        "old_price": 99000,
        "discount": "10%",
        "sold": "Đã bán 20.5k",
      },
    ];
    super.onInit();
  }

  // Method to sort products based on sort order
  void sortProducts() {
    if (sortOrder.value == 'Giá tăng dần') {
      products.sort((a, b) => a['price'].compareTo(b['price']));
    } else {
      products.sort((a, b) => b['price'].compareTo(a['price']));
    }
  }
}
