import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/controllers/product_controller.dart';
import 'package:p2p_exchange/app/screens/my_home/edit_product.dart';

class MyHomePage extends StatelessWidget {
  static const title = 'My Page';
  static const icon = Icon(
    CupertinoIcons.collections,
    size: 25,
  );

  MyHomePage({super.key});

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
                  // Open the right-side filter drawer
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Đang bán'),
              Tab(text: 'Mới nhất'),
              Tab(text: 'Yêu thích'),
              Tab(text: 'Giá'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ProductGridView(),
            const Center(child: Text('Mới nhất')),
            const Center(child: Text('Bán chạy')),
            PriceSortView(), // Updated Price tab with GetX sorting
          ],
        ),
        endDrawer: FilterDrawer(), // Right-side filter panel
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50.0), // Move up by 20 pixels
          child: FloatingActionButton(
            onPressed: () {
              ProductForm();
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.orange,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

// Widget for displaying products
class ProductGridView extends StatelessWidget {
  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.7, // Adjust to fit image and text nicely
        ),
        itemCount: productController.products.length,
        itemBuilder: (context, index) {
          final product = productController.products[index];
          return ProductCard(product: product);
        },
      );
    });
  }
}

// Widget for sorting products by price
class PriceSortView extends StatelessWidget {
  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            return DropdownButton<String>(
              value: productController.sortOrder.value,
              onChanged: (String? newValue) {
                productController.sortOrder.value = newValue!;
                productController.sortProducts(); // Call sorting method
              },
              items: <String>['Giá tăng dần', 'Giá giảm dần']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            );
          }),
        ),
        Expanded(
          child: Obx(() {
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.7, // Adjust aspect ratio
              ),
              itemCount: productController.products.length,
              itemBuilder: (context, index) {
                final product = productController.products[index];
                return ProductCard(product: product);
              },
            );
          }),
        ),
      ],
    );
  }
}

// Widget for displaying a product card
class ProductCard extends StatelessWidget {
  final product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              product['image']!,
              fit: BoxFit.cover, // Ensures image fills container
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product['title']!,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis, // Ensures no overflow
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  "${product['price']}đ",
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5.0),
                Text(
                  "${product['old_price']}đ",
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    product['discount']!,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product['sold']!,
              style: const TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

// Right-side filter panel (end drawer)
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
