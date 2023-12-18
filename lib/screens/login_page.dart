import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final String title;
  final String emailLabel;
  final String passwordLabel;
  final String loginButtonLabel;

  const LoginPage({
    Key? key,
    this.title = 'Login Page',
    this.emailLabel = 'Email',
    this.passwordLabel = 'Password',
    this.loginButtonLabel = 'Login',
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController =
      TextEditingController(); // Added type annotation
  final TextEditingController passwordController =
      TextEditingController(); // Added type annotation
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: widget.emailLabel),
          ),
          TextField(
            controller: passwordController,
            obscureText: !showPassword,
            decoration: InputDecoration(
              labelText: widget.passwordLabel,
              suffixIcon: IconButton(
                icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: Text(widget.loginButtonLabel),
          ),
        ],
      ),
    );
  }
}
