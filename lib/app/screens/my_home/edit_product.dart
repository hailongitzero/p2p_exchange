import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/controllers/categories_controller.dart';
import 'package:p2p_exchange/app/controllers/product_condition_controller.dart';
import 'package:p2p_exchange/app/controllers/product_controller.dart';
import 'package:p2p_exchange/app/models/category.dart';
import 'package:p2p_exchange/app/models/product.dart';
import 'package:p2p_exchange/app/models/product_condition.dart';

class EditProduct extends StatefulWidget {
  final Product? product;

  const EditProduct({super.key, this.product});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final ProductController productController = Get.put(ProductController());
  final CategoryController categoryController = Get.put(CategoryController());
  final ProductConditionController conditionController =
      Get.put(ProductConditionController());

  @override
  void dispose() {
    // Clean up any resources here, e.g., timers, streams, etc.
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initialize product if it's null, otherwise set the provided product
    productController.product.value =
        widget.product ?? Product(name: '', description: '', userId: '');
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
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Description'),
              onChanged: (value) => productController.product.update((prod) {
                prod?.description = value;
              }),
            ),
            TextFormField(
              initialValue: productController.product.value?.wishes,
              maxLines: 5,
              decoration: const InputDecoration(labelText: 'Wishes'),
              onChanged: (value) => productController.product.update((prod) {
                prod?.wishes = value;
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
            TextFormField(
              initialValue:
                  productController.product.value?.quantity?.toString(),
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
              onChanged: (value) => productController.product.update((prod) {
                prod?.quantity = int.parse(value);
              }),
            ),
            SizedBox(
              width: double.infinity,
              child: Obx(() {
                String? selectedCondition =
                    productController.product.value?.condition;
                if (!conditionController.conditions
                    .map((condition) => condition.id)
                    .contains(selectedCondition)) {
                  selectedCondition = null;
                }

                return DropdownButtonFormField<String>(
                  value: selectedCondition,
                  decoration: const InputDecoration(
                    labelText: 'Product Condition',
                  ),
                  isExpanded: true,
                  items: conditionController.conditions
                      .map((ProductCondition condition) {
                    return DropdownMenuItem<String>(
                      value: condition.id,
                      child: Text(condition.meaning),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      productController.product.update((prod) {
                    prod?.condition = value!;
                  }),
                );
              }),
            ),
            SizedBox(
              width: double.infinity,
              child: Obx(() {
                String? selectedCategory =
                    productController.product.value?.categoryId;
                if (!categoryController.categories
                    .map((category) => category.id)
                    .contains(selectedCategory)) {
                  selectedCategory = null;
                }

                return DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                  ),
                  isExpanded: true,
                  items: categoryController.categories.map((Category category) {
                    return DropdownMenuItem<String>(
                      value: category.id,
                      child: Text(category.title),
                    );
                  }).toList(),
                  onChanged: (value) =>
                      productController.product.update((prod) {
                    prod?.categoryId = value!;
                  }),
                );
              }),
            ),
            Obx(() => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (productController.isMainImageUploading.value)
                      const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: CircularProgressIndicator(),
                      )
                    else if (productController.mainImageUrl.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Image.network(
                          productController.mainImageUrl.value,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                    else if (productController.product.value?.image != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Image.network(
                          productController.product.value!.image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Container(),
                    ElevatedButton(
                      onPressed: productController.isMainImageUploading.value
                          ? null
                          : () async {
                              await productController.pickAndUploadMainImage();
                            },
                      child: const Text('Pick Main Image'),
                    ),
                  ],
                )),
            Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (productController.isImageSlidesUploading.value)
                      const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: CircularProgressIndicator(),
                      )
                    else if (productController.imageSlidesUrls.isNotEmpty)
                      Wrap(
                        spacing: 8.0,
                        children: productController.imageSlidesUrls
                            .map((url) =>
                                Image.network(url, width: 100, height: 100))
                            .toList(),
                      )
                    else if (!(productController
                            .product.value?.imageSlides?.isEmpty ??
                        true))
                      Wrap(
                        spacing: 8.0,
                        children: productController.product.value!.imageSlides!
                            .map((url) =>
                                Image.network(url, width: 100, height: 100))
                            .toList(),
                      )
                    else
                      Container(),
                    ElevatedButton(
                      onPressed: productController.isImageSlidesUploading.value
                          ? null
                          : () async {
                              await productController
                                  .pickAndUploadSlideImages();
                            },
                      child: const Text('Pick Slide Images'),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ElevatedButton(
                onPressed: productController.isMainImageUploading.value ||
                        productController.isImageSlidesUploading.value
                    ? null
                    : () async {
                        await productController
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
