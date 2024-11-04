import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  static const title = 'Home';
  static const icon = Icon(
    CupertinoIcons.home,
    size: 25,
  );
  const ProductsPage({
    super.key,
  });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final productsKey = GlobalKey();
  final List<Map<String, String>> allProducts = [
    {
      'name': 'Product 1',
      'description': 'This is the description for product 1.',
      'price': '19.99',
      'image': 'https://placehold.co/150'
    },
    {
      'name': 'Product 2',
      'description': 'This is the description for product 2.',
      'price': '29.99',
      'image': 'https://placehold.co/150'
    },
    {
      'name': 'Product 3',
      'description': 'This is the description for product 3.',
      'price': '39.99',
      'image': 'https://placehold.co/150'
    },
    {
      'name': 'Product 1',
      'description': 'This is the description for product 1.',
      'price': '19.99',
      'image': 'https://placehold.co/150'
    },
    {
      'name': 'Product 2',
      'description': 'This is the description for product 2.',
      'price': '29.99',
      'image': 'https://placehold.co/150'
    },
    {
      'name': 'Product 3',
      'description': 'This is the description for product 3.',
      'price': '39.99',
      'image': 'https://placehold.co/150'
    },
  ];

  List<Map<String, String>> filteredProducts = [];
  String selectedFilter = 'All';
  String selectedSort = 'None';

  Widget _buildBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                'Products',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: _openFilterDialog,
              ),
              IconButton(
                icon: Icon(Icons.sort),
                onPressed: _openSortDialog,
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(16.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 3 / 4,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 2.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15.0)),
                        child: Image.network(
                          product['image']!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Text('Error loading image');
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name']!,
                            style: TextStyle(
                              fontSize: 18, // Make the product title smaller
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text('\$${product['price']}'),
                          SizedBox(height: 10.0),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                // Implement add to cart or other action
                              },
                              child: Text('Add to Cart'),
                            ),
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
      ],
    );
  }

  void _filterProducts(String filter) {
    setState(() {
      if (filter == 'Below 30') {
        filteredProducts = allProducts
            .where((product) => double.parse(product['price']!) < 30)
            .toList();
      } else if (filter == '30 and above') {
        filteredProducts = allProducts
            .where((product) => double.parse(product['price']!) >= 30)
            .toList();
      } else {
        filteredProducts = allProducts;
      }
      selectedFilter = filter;
      _sortProducts(selectedSort); // Re-apply sorting after filtering
    });
  }

  void _sortProducts(String sort) {
    setState(() {
      if (sort == 'Price: Low to High') {
        filteredProducts.sort((a, b) =>
            double.parse(a['price']!).compareTo(double.parse(b['price']!)));
      } else if (sort == 'Price: High to Low') {
        filteredProducts.sort((a, b) =>
            double.parse(b['price']!).compareTo(double.parse(a['price']!)));
      }
      selectedSort = sort;
    });
  }

  void _openFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                secondary: Icon(Icons.filter_alt),
                title: Text('All'),
                value: 'All',
                groupValue: selectedFilter,
                onChanged: (String? value) {
                  _filterProducts(value!);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                secondary: Icon(Icons.filter_list),
                title: Text('Below 30'),
                value: 'Below 30',
                groupValue: selectedFilter,
                onChanged: (String? value) {
                  _filterProducts(value!);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                secondary: Icon(Icons.filter_list_alt),
                title: Text('30 and above'),
                value: '30 and above',
                groupValue: selectedFilter,
                onChanged: (String? value) {
                  _filterProducts(value!);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _openSortDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sort Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                secondary: Icon(Icons.sort),
                title: Text('None'),
                value: 'None',
                groupValue: selectedSort,
                onChanged: (String? value) {
                  _sortProducts(value!);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                secondary: Icon(Icons.arrow_upward),
                title: Text('Price: Low to High'),
                value: 'Price: Low to High',
                groupValue: selectedSort,
                onChanged: (String? value) {
                  _sortProducts(value!);
                  Navigator.of(context).pop();
                },
              ),
              RadioListTile<String>(
                secondary: Icon(Icons.arrow_downward),
                title: Text('Price: High to Low'),
                value: 'Price: High to Low',
                groupValue: selectedSort,
                onChanged: (String? value) {
                  _sortProducts(value!);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      key: productsKey,
      navigationBar: CupertinoNavigationBar(
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.gear,
              size: 20,
            )),
        middle: const Text(''),
        trailing: IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.person_solid, size: 20)),
        previousPageTitle: '',
      ),
      child: SafeArea(child: _buildBody()),
    );
  }
}
