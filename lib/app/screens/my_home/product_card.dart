import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p2p_exchange/app/models/product.dart';
import 'package:p2p_exchange/app/screens/my_home/edit_product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final formatCurrency = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
  ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child:
                ImageSlider(images: product.imageSlides!), // Image slider here
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
                  "${formatCurrency.format(product.price)}",
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5.0),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: product.condition?.toLowerCase() == 'new'
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.red, // Background color for "Hot Deal"
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: const Text(
                          'Hot Deal',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Text(
                        product.condition!,
                        style:
                            const TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Add other widgets here if needed
                const Spacer(), // This pushes the button to the right
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(40, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {},
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      // Handle edit button click
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return EditProduct(product: product);
                        },
                      );
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageSlider extends StatelessWidget {
  final List<String> images;
  const ImageSlider({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Image.network(
          images[index],
          fit: BoxFit.cover,
          width: double.infinity,
        );
      },
    );
  }
}
