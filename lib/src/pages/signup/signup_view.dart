import 'package:flutter/material.dart';

/// Presents the page containing fields to signup with a username and password, plus buttons.
class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  static const routeName = '/signup';

  @override
  SignupViewState createState() => SignupViewState();
}

class SignupViewState extends State<SignupView> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileController = TextEditingController();

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
                  "Sign Up",
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(height: 16.0),
                const Text(
                  "Your name and email is shared only with members of your AGC Chapter and AGC Administrators."
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            // [Name]
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 12.0),
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
            const SizedBox(height: 12.0),
            TextField(
              controller: _mobileController,
              decoration: const InputDecoration(
                labelText: 'Mobile',
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
                onPressed: () {
                  // Eventually: pushReplacementNamed
                  Navigator.pushNamed(context, '/home');
                },
                child: const Text('Sign up')),
          ],
        ),
      ),
    );
  }
}
