import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/controllers/categories_controller.dart';
import 'package:p2p_exchange/app/models/category.dart';
import 'category_form.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());

  void _openCategoryForm(BuildContext context, [Category? category]) {
    showDialog(
      context: context,
      builder: (context) => CategoryForm(category: category),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: Obx(() {
        if (categoryController.categories.isEmpty) {
          return Center(child: Text('No categories available.'));
        }
        return ListView.builder(
          itemCount: categoryController.categories.length,
          itemBuilder: (context, index) {
            var category = categoryController.categories[index];
            return ListTile(
              leading: category.image.isNotEmpty
                  ? Image.network(category.image, width: 50, height: 50)
                  : Icon(Icons.category),
              title: Text(category.title),
              subtitle: Text(category.description),
              onTap: () => _openCategoryForm(context, category),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openCategoryForm(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
