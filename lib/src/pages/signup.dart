import 'package:atlas/main.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
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
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () async {
                  final sm = ScaffoldMessenger.of(context);
                  final authResponse = await supabase.auth.signUp(
                      password: _passwordController.text,
                      email: _emailController.text);

                  sm.showSnackBar(SnackBar(
                      content:
                          Text("Logged In: ${authResponse.user!.email!}")));
                },
                child: Text("Sign Up"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
