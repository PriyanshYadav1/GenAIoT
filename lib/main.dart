import 'package:flutter/material.dart';
import 'package:genaiot/views/login_Screen.dart';
import 'views/home.dart';
import 'views/SignUp_Screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const login_Screen(),
        '/signup': (context) => const signUp_Screen(),
        '/home': (context) => const HomePage(),
      },

    );
  }
}
