import 'package:flutter/material.dart';

class signUp_Screen extends StatelessWidget {
  //Controllers for fields
  final signUP_EmailController = TextEditingController();
  final signUP_PasswordController = TextEditingController();

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
                            borderSide: const BorderSide(color: Colors.white)),
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
                            borderSide: const BorderSide(color: Colors.white)),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      controller: signUP_PasswordController,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
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
