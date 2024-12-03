import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/controllers/my_home_controller.dart';
import 'package:p2p_exchange/app/screens/my_home/product_card.dart';
import 'package:p2p_exchange/app/screens/product_detail/product_detail.dart';

class MyTrades extends StatelessWidget {
  final MyHomeController myHomeController = Get.put(MyHomeController());

  MyTrades({super.key});

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
        itemCount: myHomeController.myTrades.length,
        itemBuilder: (context, index) {
          final product = myHomeController.myTrades[index];
          return GestureDetector(
            onTap: () {
              // Handle item click here
              // For example, navigate to a detail page or show a dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ProductDetail(product: product);
                },
              );
            },
            child: ProductCard(product: product),
          );
        },
      );
    });
  }
}
