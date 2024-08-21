import 'package:flutter/material.dart';
import 'hamburger_menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
