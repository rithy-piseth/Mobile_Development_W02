import 'package:flutter/material.dart';
import 'package:login/1%20-%20START%20CODE/data/services/auth_service.dart';

import 'theme.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.onLogin});

  final VoidCallback onLogin;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String? errorMessage;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void onLoginPressed() async {
    // Wrap all the code with a try/catch on AuthException: if exception, disaplyer error with the exception
    try {
      String name = nameController.text;
      String password = passwordController.text;

      if (name.isEmpty || password.isEmpty) {
        setState(() {
          errorMessage = "Name and Password shall be Enter";
        });
      }
      await AuthenticationService.instance.login(
        name: name,
        password: password,
      );
      // Get the name + password from controllers
    } on AuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }

    setState(() {
      errorMessage = null;
    });

    onLoginPressed();

    // Validate the name+password => if empty display error :  "Name and password shall be entered"

    // Call AuthenticationService instance to login

    // Iff success, notify the parent (use the callback) and refresh the state

    // If failure disaply the error and refresh
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            const SizedBox(height: 20),

            // Login image
            Image.asset("assets/img1.jpg", height: 250),

            const SizedBox(height: 40),

            // Username
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 20),

            // Password
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),

            const SizedBox(height: 30),

            // Login button
            GestureDetector(
              onTap: onLoginPressed,
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.mainColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text("LOGIN", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),

            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Center(
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
