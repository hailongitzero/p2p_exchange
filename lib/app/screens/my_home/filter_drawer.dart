import 'package:flutter/material.dart';

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
