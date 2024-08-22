import 'package:flutter/material.dart';
import 'package:genaiot/views/login_Screen.dart';
import 'views/assets.dart';
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
        '/login': (context) => login_Screen(),
        '/signup': (context) => signUp_Screen(),
        '/home': (context) => HomePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/assets') {
          final String image = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return AssetsPage(image: image);
            },
          );
        }
        return null;
      },
    );
  }
}
