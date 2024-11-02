import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:p2p_exchange/app/screens/registration/registration.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.facebook),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.g_translate),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.apple),
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(TextSpan(
                  text: 'Or ', // Normal text
                  children: [
                    TextSpan(
                      text: 'Register',
                      style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationPage()));
                        },
                    ),
                  ],
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
