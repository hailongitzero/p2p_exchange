import 'package:flutter/cupertino.dart';
import 'package:p2p_exchange/app/screens/categories/category.dart';
import 'package:p2p_exchange/app/screens/home/home.dart';
import 'package:p2p_exchange/app/screens/my_home/my_home.dart';

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
            icon: CategoryScreen.icon,
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
              builder: (context) => HomePage(
                key: homeKey,
              ),
            ),
          1 => CupertinoTabView(
              defaultTitle: CategoryScreen.title,
              builder: (context) => CategoryScreen(
                key: receiptKey,
              ),
            ),
          2 => CupertinoTabView(
              defaultTitle: MyHomePage.title,
              builder: (context) => MyHomePage(
                key: productKey,
              ),
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
