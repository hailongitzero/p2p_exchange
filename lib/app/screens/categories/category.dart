import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/controllers/categories_controller.dart';

class CategoryScreen extends StatelessWidget {
  static const title = 'Category';
  static const icon = Icon(
    CupertinoIcons.list_bullet_below_rectangle,
    size: 25,
  );
  CategoryScreen({
    super.key,
  });

  final CategoryController controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopeeFood Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Add action for filters if needed
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                controller.filterCategories(value);
              },
            ),
          ),
          Expanded(
            child: Obx(() {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 1, // Adjust as needed
                ),
                itemCount: controller.filteredCategories.length,
                itemBuilder: (context, index) {
                  final category = controller.filteredCategories[index];
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          category.image,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8),
                        Text(category.title, textAlign: TextAlign.center),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void _openFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CheckboxListTile(
                title: const Text('Option 1'),
                value: false,
                onChanged: (bool? value) {},
              ),
              CheckboxListTile(
                title: const Text('Option 2'),
                value: false,
                onChanged: (bool? value) {},
              ),
              // Add more filter options as needed
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Implement filter logic here
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }
}
