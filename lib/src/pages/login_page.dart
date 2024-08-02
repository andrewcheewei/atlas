import 'dart:async';
import 'package:atlas/main.dart';
import 'package:atlas/src/pages/signup_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    super.initState();
    _authSubscription = supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
        Navigator.of(context).pushReplacementNamed('/main');
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle = TextStyle(color: Colors.grey);
    TextStyle linkStyle = TextStyle(color: Colors.blue);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: ListView(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                label: Text('Email'),
              ),
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                label: Text('Password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(style: defaultStyle, children: <TextSpan>[
                      TextSpan(
                          text: 'Forgot password',
                          style: linkStyle,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // add reset password functionality
                              print('foo');
                            })
                    ]),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: RichText(
                      text: TextSpan(style: defaultStyle, children: <TextSpan>[
                        TextSpan(text: 'New to Atlas? '),
                        TextSpan(
                            text: 'Sign up',
                            style: linkStyle,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpPage()));
                              })
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    final email = _emailController.text.trim();
                    final password = _passwordController.text.trim();

                    await supabase.auth
                        .signInWithPassword(email: email, password: password);
                    if (mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/', (Route<dynamic> route) => false);
                    }
                  } on AuthException catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(error.message),
                          backgroundColor: Theme.of(context).colorScheme.error),
                    );
                  }
                },
                child: const Text('Login')),
          ],
        ),
      ),
    );
  }
}
