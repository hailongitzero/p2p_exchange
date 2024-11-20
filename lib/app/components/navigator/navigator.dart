import 'package:flutter/cupertino.dart';
import 'package:p2p_exchange/app/screens/home/home.dart';
import 'package:p2p_exchange/app/screens/my_home/my_home.dart';
import 'package:p2p_exchange/app/screens/products/products.dart';

class NavigatorBuilder extends StatefulWidget {
  const NavigatorBuilder({super.key, this.username});
  static const title = 'Home';
  final String? username;

  @override
  State<NavigatorBuilder> createState() => _NavigatorBuilderState();
}

class _NavigatorBuilderState extends State<NavigatorBuilder> {
  final homeKey = GlobalKey();
  final receiptKey = GlobalKey();
  final productKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final CupertinoTabController tabController = CupertinoTabController();
    return CupertinoTabScaffold(
      controller: tabController,
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            // label: HomePage.title,
            icon: HomePage.icon,
          ),
          BottomNavigationBarItem(
            // label: HomePage.title,
            icon: ProductsScreen.icon,
          ),
          BottomNavigationBarItem(
            // label: HomePage.title,
            icon: MyHomePage.icon,
          ),
        ],
      ),
      tabBuilder: (context, index) {
        assert(index <= 2 && index >= 0, 'Unexpected tab index: $index');
        return switch (index) {
          0 => CupertinoTabView(
              // defaultTitle: HomePage.title,
              builder: (context) =>
                  HomePage(key: homeKey, tabController: tabController),
            ),
          1 => CupertinoTabView(
              defaultTitle: ProductsScreen.title,
              builder: (context) =>
                  ProductsScreen(key: receiptKey, tabController: tabController),
            ),
          2 => CupertinoTabView(
              defaultTitle: MyHomePage.title,
              builder: (context) =>
                  MyHomePage(key: productKey, tabController: tabController),
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
