
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'hamburger_menu.dart';
// import 'assets.dart';


class HomePage extends StatefulWidget {
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
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ],
          ),
        ),
        title: Text(
          'Home',style: TextStyle(fontWeight: FontWeight.bold,
         ),
        ),
        centerTitle: true,
      ),
       drawer: AppDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/iot.png',fit: BoxFit.cover,),

        ]

      )

    );
  }
}
