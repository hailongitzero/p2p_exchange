import 'package:flutter/cupertino.dart';
import 'package:p2p_exchange/app/screens/categories/categories.dart';
import 'package:p2p_exchange/app/screens/home/home.dart';
import 'package:p2p_exchange/app/screens/products/product1.dart';
import 'package:p2p_exchange/app/screens/products/product_filter.dart';
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
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
            // label: HomePage.title,
            icon: HomePage.icon,
          ),
          BottomNavigationBarItem(
            // label: HomePage.title,
            icon: ShopItemScreen.icon,
          ),
          BottomNavigationBarItem(
            // label: HomePage.title,
            icon: ShopHomePage.icon,
          ),
        ],
      ),
      tabBuilder: (context, index) {
        assert(index <= 2 && index >= 0, 'Unexpected tab index: $index');
        return switch (index) {
          0 => CupertinoTabView(
              // defaultTitle: HomePage.title,
              builder: (context) => HomePage(
                key: homeKey,
              ),
            ),
          1 => CupertinoTabView(
              defaultTitle: CategoryScreen.title,
              builder: (context) => ShopItemScreen(
                key: receiptKey,
              ),
            ),
          2 => CupertinoTabView(
              defaultTitle: ShopHomePage.title,
              builder: (context) => ShopHomePage(
                key: productKey,
              ),
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
