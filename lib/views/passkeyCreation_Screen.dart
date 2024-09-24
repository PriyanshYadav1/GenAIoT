import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genaiot/views/passkey_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class passkeyCreation_Screen extends StatefulWidget {
  const passkeyCreation_Screen({super.key});

  @override
  State<passkeyCreation_Screen> createState() => _passkeyCreation_ScreenState();
}

class _passkeyCreation_ScreenState extends State<passkeyCreation_Screen> {
  final signUp_PasskeyController = TextEditingController();

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
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Image.asset('assets/images/logo-no-background.png'),
                      Image.asset('assets/images/logo.png'),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        "Passkey Setup",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                            fontSize: 30),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Enter Passkey',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        controller: signUp_PasskeyController,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          if (signUp_PasskeyController.text != '') {
                            FocusScope.of(context).unfocus();
                            await prefs.setString(
                                'passkey', signUp_PasskeyController.text);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const passkey_Screen()));
                            Fluttertoast.showToast(
                                msg: 'Passkey Registered',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black12,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Field has invalid input",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black12,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
