import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:genaiot/views/login_Screen.dart';
import 'package:genaiot/views/passkey_Screen.dart';
import 'package:genaiot/views/home.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that plugin services are initialized

  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('Token');

  runApp(MyApp(
      initialRoute: token != null && token.isNotEmpty ? '/passkey' : '/login'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        '/login': (context) => const login_Screen(),
        '/passkey': (context) => const passkey_Screen(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:genaiot/views/login_Screen.dart';
// import 'package:genaiot/views/passkey_Screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'views/home.dart';
//
// void main() async {
//   final prefs = await SharedPreferences.getInstance();
//   var Token = await prefs.getString('Token');
//   if (Token != null && Token != "") {
//     runApp(const passkey_Screen());
//   } else {
//     runApp(login_Screen());
//   }
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/login',
//       routes: {
//         '/login': (context) => const login_Screen(),
//         '/home': (context) => const HomePage(),
//       },
//     );
//   }
// }
