import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:p2p_exchange/app/controllers/my_home_controller.dart';
import 'package:p2p_exchange/app/screens/my_home/edit_product.dart';
import 'package:p2p_exchange/app/screens/my_home/filter_drawer.dart';
import 'package:p2p_exchange/app/screens/my_home/my_products.dart';
import 'package:p2p_exchange/app/screens/my_home/on_sale_products.dart';

class MyHomePage extends StatefulWidget {
  static const title = 'My Page';
  static const icon = Icon(
    CupertinoIcons.collections,
    size: 25,
  );
  final CupertinoTabController tabController;

  const MyHomePage({super.key, required this.tabController});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final MyHomeController myHomeController = Get.put(MyHomeController());
  late TabController _tabController;
  final myHomeKey = GlobalKey();

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
        myHomeController.loadMySaleProducts();
        break;
      case 1:
        myHomeController.loadMyProducts();
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
    return CupertinoPageScaffold(
      key: myHomeKey,
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

  Widget _buildBody() {
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
            const OnSaleProducts(),
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
