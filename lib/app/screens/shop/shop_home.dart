import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/controllers/my_home_controller.dart';
import 'package:p2p_exchange/app/models/product.dart';

class ShopHomePage extends StatelessWidget {
  final MyHomeController myHomeController = Get.put(MyHomeController());

  ShopHomePage({super.key});

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
            IconButton(
              icon: const Icon(Icons.filter_alt),
              onPressed: () {
                // Handle filter action
              },
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Liên quan'),
              Tab(text: 'Mới nhất'),
              Tab(text: 'Bán chạy'),
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
      ),
    );
  }
}

// Widget for displaying products
class ProductGridView extends StatelessWidget {
  final MyHomeController myHomeController = Get.find();

  ProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.7,
        ),
        itemCount: myHomeController.products.length,
        itemBuilder: (context, index) {
          final product = myHomeController.products[index];
          return ProductCard(product: product);
        },
      );
    });
  }
}

// Widget for sorting products by price
class PriceSortView extends StatelessWidget {
  final MyHomeController myHomeController = Get.find();

  PriceSortView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() {
            return DropdownButton<String>(
              value: myHomeController.sortOrder.value,
              onChanged: (String? newValue) {
                myHomeController.sortOrder.value = newValue!;
                myHomeController.sortProducts(); // Call sorting method
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
                childAspectRatio: 0.7,
              ),
              itemCount: myHomeController.products.length,
              itemBuilder: (context, index) {
                final product = myHomeController.products[index];
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
  final Product product;

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
              product.image!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Text(
                  "${product.price}đ",
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5.0),
                // Text(
                //   "${product['old_price']}đ",
                //   style: TextStyle(
                //     fontSize: 12.0,
                //     color: Colors.grey,
                //     decoration: TextDecoration.lineThrough,
                //   ),
                // ),
                // Spacer(),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                //   decoration: BoxDecoration(
                //     color: Colors.yellow,
                //     borderRadius: BorderRadius.circular(4.0),
                //   ),
                //   child: Text(
                //     product['discount']!,
                //     style: TextStyle(
                //       fontSize: 12.0,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     product['sold']!,
          //     style: TextStyle(fontSize: 12.0, color: Colors.grey),
          //   ),
          // ),
        ],
      ),
    );
  }
}
