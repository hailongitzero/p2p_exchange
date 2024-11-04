// views/product_form.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/controllers/product_controller.dart';
import 'package:p2p_exchange/app/models/category.dart';

class ProductForm extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

  ProductForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add/Update Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Product Name'),
              onChanged: (value) => controller.product.value?.name = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              onChanged: (value) =>
                  controller.product.value?.description = value,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              onChanged: (value) =>
                  controller.product.value?.price = double.tryParse(value) ?? 0,
            ),
            // Dropdown for Categories
            Obx(() => DropdownButton<String>(
                  value: controller.product.value?.categoryId,
                  items: controller.categories.map((Category category) {
                    return DropdownMenuItem<String>(
                      value: category.id,
                      child: Text(category.title),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      controller.product.value?.categoryId = value!,
                )),
            // Button to pick main image
            ElevatedButton(
              onPressed: () async {
                await controller.pickAndUploadMainImage();
              },
              child: Text('Pick Main Image'),
            ),
            Obx(() => controller.mainImageUrl.isNotEmpty
                ? Image.network(controller.mainImageUrl.value)
                : Container()),

            // Button to pick slide images
            ElevatedButton(
              onPressed: () async {
                await controller.pickAndUploadSlideImages();
              },
              child: Text('Pick Slide Images'),
            ),
            Obx(() => Wrap(
                  spacing: 8.0,
                  children: controller.imageSlidesUrls
                      .map((url) => Image.network(url, width: 100, height: 100))
                      .toList(),
                )),

            // Submit button
            ElevatedButton(
              onPressed: () {
                controller.saveProduct(controller.product.value!);
              },
              child: Text('Save Product'),
            ),
          ],
        ),
      ),
    );
  }
}
