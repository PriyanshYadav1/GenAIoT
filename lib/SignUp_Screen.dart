import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genaiot/login_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class signUp_Screen extends StatefulWidget {
  @override
  State<signUp_Screen> createState() => _signUp_ScreenState();
}

class _signUp_ScreenState extends State<signUp_Screen> {
  //Controllers for fields
  final signUP_EmailController = TextEditingController();

  final signUP_PasswordController = TextEditingController();

  final signUp_RetypePasswordController = TextEditingController();

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
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logo-no-background.png'),
                      SizedBox(
                        height: 50,
                      ),
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                            fontSize: 30),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        controller: signUP_EmailController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        controller: signUP_PasswordController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: ' Retype Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        controller: signUp_RetypePasswordController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Passkey',
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
                          if (signUP_PasswordController.text ==
                                  signUp_RetypePasswordController.text &&
                              (signUP_EmailController.text != '' &&
                                  signUP_PasswordController.text != '' &&
                                  signUp_RetypePasswordController.text != '' &&
                                  signUp_PasskeyController.text != '')) {
                            if (signUP_PasswordController.text ==
                                signUp_RetypePasswordController.text) {
                              FocusScope.of(context).unfocus();
                              await prefs.setString(
                                  'email', signUP_EmailController.text);
                              await prefs.setString(
                                  'password', signUP_PasswordController.text);
                              await prefs.setString(
                                  'passkey', signUp_PasskeyController.text);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => login_Screen()));
                              Fluttertoast.showToast(
                                  msg: 'Registration Successful',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black12,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Password input mismatch",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black12,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: "Fields have invalid inputs",
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
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => login_Screen()));
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
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
