import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/controllers/product_controller.dart';
import 'package:p2p_exchange/app/screens/my_home/edit_product.dart';
import 'package:p2p_exchange/app/screens/my_home/my_products.dart';
import 'package:p2p_exchange/app/screens/my_home/on_sale_products.dart';

class MyHomePage extends StatefulWidget {
  static const title = 'My Page';
  static const icon = Icon(
    CupertinoIcons.collections,
    size: 25,
  );

  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final ProductController productController = Get.put(ProductController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Listen to tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        onTabChanged(_tabController.index);
      }
    });
  }

  void onTabChanged(int index) {
    switch (index) {
      case 0:
        productController.loadMySaleProducts();
        break;
      case 1:
        productController.loadMyProducts();
        break;
      case 2:
        break;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back action
            },
          ),
          title: TextField(
            decoration: InputDecoration(
              hintText: 'Tìm kiếm',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          actions: [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.filter_alt),
                onPressed: () {
                  // Open the right-side filter drawer
                  Scaffold.of(context).openEndDrawer();
                },
              ),
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(text: 'Đang bán'),
              Tab(text: 'Tất cả'),
              Tab(text: 'Yêu thích'),
              // Tab(text: 'Giá'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            OnSaleProducts(),
            MyProducts(),
            const Center(child: Text('Bán chạy')),
            // PriceSortView(),
          ],
        ),
        endDrawer: const FilterDrawer(),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const EditProduct();
                },
              );
            },
            backgroundColor: Colors.orange,
            child: const Icon(Icons.add),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
            child: Text(
              'Bộ lọc',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.filter_list),
            title: const Text('Filter Option 1'),
            onTap: () {
              // Handle filter option
            },
          ),
          ListTile(
            leading: const Icon(Icons.filter_list),
            title: const Text('Filter Option 2'),
            onTap: () {
              // Handle filter option
            },
          ),
          // Add more filter options here
        ],
      ),
    );
  }
}
