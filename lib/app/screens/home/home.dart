import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:p2p_exchange/app/controllers/home_controller.dart';
import 'package:p2p_exchange/app/controllers/product_controller.dart';
import 'package:p2p_exchange/app/controllers/slide_controller.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/screens/home/product_card.dart';
import 'package:p2p_exchange/app/screens/home/slide_item.dart';
import 'package:p2p_exchange/app/screens/setting/setting.dart';

class HomePage extends StatefulWidget {
  static const title = 'Home';
  static const icon = Icon(
    CupertinoIcons.home,
    size: 25,
  );
  final CupertinoTabController tabController;
  const HomePage({super.key, required this.tabController});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeKey = GlobalKey();
  final SlideController slideController = Get.put(SlideController());
  final HomeController homeController = Get.put(HomeController());
  final ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    super.initState();
    slideController.loadSlideProducts();
    homeController.loadProducts();
  }

  Widget _buildBody() {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'search'.tr,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (value) =>
                      {productController.searchString.value = value},
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  widget.tabController.index = 1;
                  productController.updateSearchParams();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(16),
                ),
                child: const Icon(Icons.search),
              ),
            ],
          ),
        ),

        // Wrap with Obx to update the UI when productSlides changes
        Obx(() {
          if (slideController.productSlides.isEmpty) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show loading if data is empty
          } else {
            // Product slide
            return SlideItem(
              productSlides: slideController.productSlides,
            );
          }
        }),

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'products'.tr,
              style: textTheme
                  .copyWith(
                      titleLarge: textTheme.titleLarge!.copyWith(
                          color: Colors.red, fontWeight: FontWeight.bold))
                  .titleLarge,
            ),
          ),
        ),

        // GridView displaying products
        Obx(() {
          if (homeController.products.isEmpty) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show loading if products are empty
          } else {
            return Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: homeController.products.length,
                itemBuilder: (context, index) {
                  final product = homeController.products[index];
                  return ProductCard(
                    product: product,
                  );
                },
              ),
            );
          }
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      key: homeKey,
      navigationBar: CupertinoNavigationBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsPage()));
            },
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
