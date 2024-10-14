import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'hamburger_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}


class HomePageState extends State<HomePage> {


  Future<String> getUsername () async {
    final prefs  = await SharedPreferences.getInstance();
    return await prefs.getString("usernamePrefs").toString();
  }

  Future<String> getEmail () async {
    final prefs  = await SharedPreferences.getInstance();
    return await prefs.getString("UaeremailPrefs").toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          leading: Builder(
            builder: (context) => Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ],
            ),
          ),
          title: const Text(
            'Home',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        drawer: AppDrawer(),
        body: Stack(fit: StackFit.expand, children: [
          Image.asset(
            'assets/images/iot.png',
            fit: BoxFit.cover,
          ),
        ]));
  }
}

//
// class HomePageState extends State<HomePage> {
//
//   @override
//   void initState() {
//     super.initState();
//     // Open the drawer when the widget is first built
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Scaffold.of(context).openDrawer();
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     // final apps = widget.apps;
//
//     return MaterialApp(
//       home: Scaffold(
//           body: AppDrawer()
//
//       ),
//     );
//   }
// }
