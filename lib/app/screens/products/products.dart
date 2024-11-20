import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/controllers/product_controller.dart';
import 'package:p2p_exchange/app/screens/home/product_card.dart';

class ProductsScreen extends StatefulWidget {
  static const title = 'Category';
  static const icon = Icon(
    CupertinoIcons.list_bullet_below_rectangle,
    size: 25,
  );
  final CupertinoTabController tabController;

  const ProductsScreen({super.key, required this.tabController});

  @override
  State<ProductsScreen> createState() => _ProductsScreen();
}

class _ProductsScreen extends State<ProductsScreen> {
  final ProductController productController = Get.put(ProductController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Add a listener to the ScrollController
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !productController.isLoading.value) {
        productController.fetchProducts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.gear, size: 20),
        ),
        middle: const Text(''),
        trailing: IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.person_solid, size: 20),
        ),
      ),
      child: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final textTheme = Theme.of(context).textTheme;
    var searchText =
        TextEditingController(text: productController.searchString.value);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchText,
                  decoration: InputDecoration(
                    hintText: 'Search for products',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (value) =>
                      {productController.searchString.value = value},
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  productController.updateSearchParams();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Icon(Icons.search),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Products',
              style: textTheme.titleLarge!.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // GridView displaying products
        Expanded(
          child: Obx(() {
            if (productController.products.isEmpty) {
              return Center(
                child: Text(
                  'No products found.',
                  style: textTheme.titleLarge!.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else {
              return NotificationListener<ScrollEndNotification>(
                onNotification: (scrollEnd) {
                  if (_scrollController.position.extentAfter == 0 &&
                      !productController.isLoading.value) {
                    productController.fetchProducts();
                  }
                  return false;
                },
                child: GridView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 16.0,
                    childAspectRatio: 2 / 3,
                  ),
                  itemCount: productController.products.length +
                      (productController.isLoading.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < productController.products.length) {
                      final product = productController.products[index];
                      return ProductCard(
                        product: product,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              );
            }
          }),
        ),
      ],
    );
  }
}
