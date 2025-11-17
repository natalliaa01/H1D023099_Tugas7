import 'package:flutter/material.dart';
import '../pages/about_page.dart';
import '../pages/home_page.dart';

class SideMenu extends StatelessWidget {
  final VoidCallback onLogout;
  final String username;
  const SideMenu({super.key, required this.onLogout, required this.username});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(username),
            accountEmail: const Text('nim@example.edu'),
            currentAccountPicture: CircleAvatar(child: Text(username.isEmpty ? '?' : username[0].toUpperCase())),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, HomePage.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AboutPage.routeName);
            },
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              onLogout();
            },
          )
        ],
      ),
    );
  }
}
