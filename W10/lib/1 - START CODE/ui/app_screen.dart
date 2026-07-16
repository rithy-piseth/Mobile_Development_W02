import 'package:flutter/material.dart';
import 'package:login/1%20-%20START%20CODE/data/services/auth_service.dart';
import 'package:login/1%20-%20START%20CODE/ui/scores_screen.dart';
import 'auth_screen.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  void onLogin() {
    setState(() {});
  }

  Widget get content {
    bool isLogged = AuthenticationService.instance.isLoggedIn;
    // if logged in -> Display ScoresScreen
    if (isLogged) {
      return ScoresScreen();
    }

    // otherwise -> DisplayAuthScreen
    return AuthScreen(onLogin: onLogin);
  }

  @override
  Widget build(BuildContext context) {
    return content;
  }
}
