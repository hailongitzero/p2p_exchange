import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopItemScreen extends StatelessWidget {
  static const title = 'Home';
  static const icon = Icon(
    CupertinoIcons.home,
    size: 25,
  );
  ShopItemScreen({
    super.key,
  });

  final List<Map<String, dynamic>> products = [
    {
      'name': 'Welcare Mask Black Edition',
      'price': 65,
      'original_price': 70,
      'rating': 4.9,
      'sold': '30.3k',
      'image': 'https://placehold.co/150'
    },
    {
      'name': '3D Mask',
      'price': 44,
      'original_price': 119,
      'rating': 4.9,
      'sold': '117.2k',
      'image': 'https://placehold.co/150'
    },
    {
      'name': 'Omedo Earloop Face Mask',
      'price': 14,
      'original_price': 32,
      'rating': 4.9,
      'sold': '14.4k',
      'image': 'https://placehold.co/150'
    },
    {
      'name': 'Next Health Face Mask',
      'price': 14,
      'original_price': 32,
      'rating': 4.9,
      'sold': '14.4k',
      'image': 'https://placehold.co/150'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Items'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 3 / 4,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.network(
                        product['image'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['name'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '฿${product['price']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (product['original_price'] != null) ...[
                          Text(
                            '฿${product['original_price']}',
                            style: TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                        SizedBox(height: 4.0),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 16),
                            SizedBox(width: 4.0),
                            Text(
                              '${product['rating']}',
                              style: TextStyle(fontSize: 12),
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              '| Sold ${product['sold']}',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
