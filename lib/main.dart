import 'package:flutter/material.dart';
import 'package:genaiot/login_Screen.dart';
import 'assetsPage/assets.dart';
import 'home.dart';
import 'SignUp_Screen.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

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
      onGenerateRoute: (settings){
        if(settings.name == '/assets'){
          final String image = settings.arguments as String;
          return MaterialPageRoute(builder: (context){
            return AssetsPage(image: image);
          },);
        }
      },
    );
  }
}
