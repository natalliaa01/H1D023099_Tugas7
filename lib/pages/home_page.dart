import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/sidemenu.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  final String? username;
  const HomePage({super.key, this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    if (widget.username != null) {
      setState(() { _username = widget.username; });
      return;
    }
    final sp = await SharedPreferences.getInstance();
    setState(() { _username = sp.getString('username') ?? 'Guest'; });
  }

  Future<void> _logout() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove('username');
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: SideMenu(onLogout: _logout, username: _username ?? '...'),
      body: Center(
      child: Text(
        'Halo, ${_username ?? "Guest"}! Ini adalah halaman utama aplikasi.',
        textAlign: TextAlign.center,
      ),
    ),

    );
  }
}
