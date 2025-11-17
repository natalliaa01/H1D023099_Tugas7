import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/about_page.dart';

void main() {
  runApp(const MyApp());
}

/// MyApp defines named routes and checks if user already logged in.
/// Creative differences from the module:
/// - Uses a small splash logic to auto-redirect if a stored username exists.
/// - Uses custom color scheme and simple animation for route transitions.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String?> _getSavedUsername() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString('username');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NIM_Tugas7',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: false,
      ),
      // initialRoute is decided dynamically via FutureBuilder inside home.
      home: FutureBuilder<String?>(
        future: _getSavedUsername(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            // simple splash
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.data != null && snapshot.data!.isNotEmpty) {
            // user already logged in -> HomePage
            return HomePage(username: snapshot.data!);
          }
          // show login
          return const LoginPage();
        },
      ),
      routes: {
        LoginPage.routeName: (c) => const LoginPage(),
        HomePage.routeName: (c) => const HomePage(),
        AboutPage.routeName: (c) => const AboutPage(),
      },
    );
  }
}
