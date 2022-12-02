import 'package:flutter/material.dart';

/// Presents the page containing fields to enter a username and password, plus buttons.
class SigninView extends StatefulWidget {
  const SigninView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  SigninViewState createState() => SigninViewState();
}

class SigninViewState extends State<SigninView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 40.0),
            Column(
              children: <Widget>[
                Image.asset('assets/images/vegetables.png', width: 100),
                const SizedBox(height: 16.0),
                Text(
                  "Welcome to",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "Agile Garden Club",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            const SizedBox(height: 120.0),
            // [Name]
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Forgot Password?'),
              ),
            ),
            const SizedBox(height: 12.0),
            SizedBox(
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    // Eventually: pushReplacementNamed
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Text('Sign in')),
            ),
            const SizedBox(height: 12.0),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Don't have an account? "),
              TextButton(
                child: const Text('Sign up'),
                onPressed: () {
                  // Eventually: pushReplacementNamed
                  Navigator.pushNamed(context, '/signup');
                },
              )
            ]),
          ],
        ),
      ),
    );
  }
}
