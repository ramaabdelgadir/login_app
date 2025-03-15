import 'package:flutter/material.dart';
import 'package:login_app/views/login_view.dart';
import 'package:login_app/views/home_view.dart';
import 'package:login_app/views/profile_view.dart';
import 'package:login_app/views/signup_view.dart';
import 'package:login_app/views/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialRoute: '/Login',
      // routes: {
      //   '/Login': (context) =>  LoginPage(),
      //   '/Home': (context) => const HomePage(),
      //   '/profile': (context) => const ProfilePage(),
      //   '/signup/Step 1': (context) => const SignupPage(step: 1),
      //   '/signup/Step 2': (context) => const SignupPage(step: 2),
      //   '/signup/Step 3': (context) => const SignupPage(step: 3),
      // },
      home: Splash(),
    );
  }
}
