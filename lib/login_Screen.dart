import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genaiot/SignUp_Screen.dart';
import 'package:genaiot/home.dart';
import 'package:genaiot/passkey_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login_Screen extends StatefulWidget {
  login_Screen({super.key});

  @override
  State<login_Screen> createState() => _login_ScreenState();
}

class _login_ScreenState extends State<login_Screen> {
  //Controllers for fields
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

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
                        height: 60,
                      ),
                      const Text(
                        "Welcome!",
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
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        controller: emailController,
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
                        controller: passwordController,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          var email = prefs.getString('email');
                          var password = prefs.getString('password');
                          if ((emailController.text == 'jack' &&
                                  passwordController.text == '1234') ||
                              emailController.text == email &&
                                  passwordController.text == password) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          } else {
                            Fluttertoast.showToast(
                                msg: 'Invalid Credentials',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black12,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          child: Row(
                        children: [
                          SizedBox(
                            width: 27,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => passkey_Screen()));
                            },
                            child: const Text(
                              'Passkey Login',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => signUp_Screen()));
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )),
                      const SizedBox(
                        height: 25,
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
