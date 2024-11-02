import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const title = 'Home';
  static const icon = Icon(
    CupertinoIcons.home,
    size: 25,
  );
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeKey = GlobalKey();
  final List<Map<String, String>> imgList = [
    {'image': 'https://placehold.co/400', 'title': 'Featured Product 1'},
    {'image': 'https://placehold.co/400', 'title': 'Featured Product 2'},
    {'image': 'https://placehold.co/400', 'title': 'Featured Product 3'},
  ];

  Widget _buildBody() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search for products',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  _openFilterDialog(context);
                },
                child: const Icon(Icons.filter_list),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(16),
                ),
              ),
            ],
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 250,
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          items: imgList
              .map((item) => Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.network(
                          item['image']!,
                          fit: BoxFit.cover,
                          width: 1000,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              color: Colors.black54,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                item['title']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                // Implement navigation or action
                              },
                              child: const Text('Shop Now'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Products',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 2 / 3,
            ),
            itemCount: 10, // Replace with your actual product count
            itemBuilder: (context, index) {
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
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15.0)),
                        child: Image.network(
                          'https://placehold.co/150', // Replace with your actual product image URL
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Product Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          const Text('\$19.99'),
                          const SizedBox(height: 10.0),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                // Implement navigation or action
                              },
                              child: const Text('Add to Cart'),
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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      key: homeKey,
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
