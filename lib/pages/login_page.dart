import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _userCtl = TextEditingController();
  final _passCtl = TextEditingController();
  bool _loading = false;

  // Simple (fake) authentication: username must not be empty and password == 'flutter'
  Future<void> _doLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 600)); // simulate network
    final user = _userCtl.text.trim();
    final pass = _passCtl.text;
    if (pass == 'flutter') {
      final sp = await SharedPreferences.getInstance();
      await sp.setString('username', user);
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage(username: user)),
      );
    } else {
      setState(() => _loading = false);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Login Gagal'),
          content: const Text('Password salah. Gunakan password: flutter'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _userCtl.dispose();
    _passCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Centered card login with nice spacing
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 12),
                    const Text('Welcome to Natalia App', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: _userCtl,
                      decoration: const InputDecoration(labelText: 'Masukkan Username', prefixIcon: Icon(Icons.person)),
                      validator: (v) => (v==null || v.trim().isEmpty) ? 'Username tidak boleh kosong' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _passCtl,
                      decoration: const InputDecoration(labelText: 'Masukkan Password', prefixIcon: Icon(Icons.lock)),
                      obscureText: true,
                      validator: (v) => (v==null || v.isEmpty) ? 'Password tidak boleh kosong' : null,
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _doLogin,
                        child: _loading ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Login'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        // Demo credentials helper
                        showDialog(context: context, builder: (_) => AlertDialog(
                          title: const Text('Demo Info'),
                          content: const Text('Gunakan password: flutter untuk login. Username bebas.'),
                          actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
                        ));
                      },
                      child: const Text('Butuh bantuan login?'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
