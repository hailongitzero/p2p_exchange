import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/controllers/product_controller.dart';
import 'package:p2p_exchange/app/screens/my_home/product_card.dart';
import 'package:p2p_exchange/app/screens/product_detail/product_detail.dart';

class OnSaleProducts extends StatefulWidget {
  const OnSaleProducts({super.key});

  @override
  State<OnSaleProducts> createState() => _OnSaleProducts();
}

class _OnSaleProducts extends State<OnSaleProducts> {
  final ProductController productController = Get.put(ProductController());
  final ScrollController _scrollController = ScrollController();

  // Flag to prevent multiple load triggers when already loading
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    productController.loadMySaleProducts();

    // Add listener to the scroll controller to detect when the user reaches the bottom
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Only load more if not already loading
        if (!isLoadingMore) {
          setState(() {
            isLoadingMore = true;
          });
          productController.loadMoreSaleProducts().then((_) {
            setState(() {
              isLoadingMore = false;
            });
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose(); // Don't forget to dispose of the controller
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Expanded(
            child: GridView.builder(
              controller: _scrollController, // Attach the scroll controller
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7,
              ),
              itemCount: productController.saleProducts.length,
              itemBuilder: (context, index) {
                final product = productController.saleProducts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductDetail(product: product)));
                  },
                  child: ProductCard(product: product),
                );
              },
            ),
          ),
          // Show loading indicator if we're in the process of loading more products
          if (isLoadingMore)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      );
    });
  }
}
