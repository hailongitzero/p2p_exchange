import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/controllers/product_controller.dart';
import 'package:p2p_exchange/app/screens/shop/shop_home.dart';

class ShopHomePage extends StatelessWidget {
  static const title = 'Home';
  static const icon = Icon(
    CupertinoIcons.home,
    size: 25,
  );

  ShopHomePage({super.key});

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back action
            },
          ),
          title: TextField(
            decoration: InputDecoration(
              hintText: 'Tìm kiếm khẩu trang',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.filter_alt),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer(); // Open filter drawer
                },
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Row(
              children: [
                const Expanded(
                  child: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(text: 'Đang bán'),
                      Tab(text: 'Mới nhất'),
                      Tab(text: 'Yêu thích'),
                      Tab(text: 'Giá'),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.sort),
                  onPressed: () {
                    // Open sorting modal
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SortOptionsModal(
                          productController: productController,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ProductGridView(),
            const Center(child: Text('Mới nhất')),
            const Center(child: Text('Bán chạy')),
            PriceSortView(),
          ],
        ),
        endDrawer: FilterDrawer(), // Right-side filter panel
      ),
    );
  }
}

class FilterDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
            child: Text(
              'Bộ lọc',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.filter_list),
            title: const Text('Filter Option 1'),
            onTap: () {
              // Handle filter option
            },
          ),
          ListTile(
            leading: const Icon(Icons.filter_list),
            title: const Text('Filter Option 2'),
            onTap: () {
              // Handle filter option
            },
          ),
          // Add more filter options here
        ],
      ),
    );
  }
}

class SortOptionsModal extends StatelessWidget {
  final ProductController productController;
  const SortOptionsModal({required this.productController});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: const Text('Giá tăng dần'),
          onTap: () {
            productController.sortOrder.value = 'Giá tăng dần';
            productController.sortProducts();
            Navigator.pop(context); // Close modal
          },
        ),
        ListTile(
          title: const Text('Giá giảm dần'),
          onTap: () {
            productController.sortOrder.value = 'Giá giảm dần';
            productController.sortProducts();
            Navigator.pop(context); // Close modal
          },
        ),
      ],
    );
  }
}
