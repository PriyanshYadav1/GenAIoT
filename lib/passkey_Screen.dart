import 'package:flutter/material.dart';
import 'package:genaiot/login_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class passkey_Screen extends StatefulWidget {
  @override
  State<passkey_Screen> createState() => _passkey_ScreenState();
}

class _passkey_ScreenState extends State<passkey_Screen> {
  //Controllers for fields
  final passKeyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              'assets/images/login_bg.jpg',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(80),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo-no-background.png'),
                    SizedBox(
                      height: 80,
                    ),
                    const Text(
                      "Welcome Back !",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto',
                          fontSize: 30),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Pass Key',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      controller: passKeyController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        var passkey = passKeyController.text.toString();
                        var prefs = await SharedPreferences.getInstance();

                        prefs.setString("passkey", passkey);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Login with credentials',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 55,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void getValue() async {
  var prefs = await SharedPreferences.getInstance();
  prefs.getString("passkey");
}
