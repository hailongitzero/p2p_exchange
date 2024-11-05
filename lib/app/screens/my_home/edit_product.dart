import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/controllers/categories_controller.dart';
import 'package:p2p_exchange/app/controllers/product_controller.dart';
import 'package:p2p_exchange/app/models/category.dart';
import 'package:p2p_exchange/app/models/product.dart';

class ProductForm extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  final CategoryController categoryController = Get.put(CategoryController());

  ProductForm({super.key}) {
    // Check if product is null; if so, initialize it as a new Product instance
    productController.product.value ??=
        Product(name: '', description: '', userId: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(productController.product.value?.id == null
              ? 'Add Product'
              : 'Update Product')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: productController.product.value?.name,
              decoration: const InputDecoration(labelText: 'Product Name'),
              onChanged: (value) => productController.product.update((prod) {
                prod?.name = value;
              }),
            ),
            TextFormField(
              initialValue: productController.product.value?.description,
              decoration: const InputDecoration(labelText: 'Description'),
              onChanged: (value) => productController.product.update((prod) {
                prod?.description = value;
              }),
            ),
            TextFormField(
              initialValue: productController.product.value?.price?.toString(),
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              onChanged: (value) => productController.product.update((prod) {
                prod?.price = double.tryParse(value) ?? 0;
              }),
            ),

            // Full-width Dropdown for Categories
            SizedBox(
              width: double.infinity,
              child: Obx(() => DropdownButtonFormField<String>(
                    value: productController.product.value?.categoryId,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                    ),
                    isExpanded: true, // Ensures dropdown takes full width
                    items:
                        categoryController.categories.map((Category category) {
                      return DropdownMenuItem<String>(
                        value: category.id,
                        child: Text(category.title),
                      );
                    }).toList(),
                    onChanged: (value) =>
                        productController.product.update((prod) {
                      prod?.categoryId = value!;
                    }),
                  )),
            ),

            // Button to pick main image
            ElevatedButton(
              onPressed: () async {
                await productController.pickAndUploadMainImage();
              },
              child: const Text('Pick Main Image'),
            ),
            Obx(() => productController.mainImageUrl.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.network(
                      productController.mainImageUrl.value,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container()),

            // Button to pick slide images
            ElevatedButton(
              onPressed: () async {
                await productController.pickAndUploadSlideImages();
              },
              child: const Text('Pick Slide Images'),
            ),
            Obx(() => Wrap(
                  spacing: 8.0,
                  children: productController.imageSlidesUrls
                      .map((url) => Image.network(url, width: 100, height: 100))
                      .toList(),
                )),

            // Submit button
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  productController
                      .saveProduct(productController.product.value!);
                },
                child: Text(productController.product.value?.id == null
                    ? 'Save Product'
                    : 'Update Product'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
