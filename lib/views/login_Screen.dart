import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:genaiot/views/passkeyCreation_Screen.dart';
import 'package:genaiot/views/passkey_Screen.dart';
import 'package:msal_auth/msal_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/api_calling.dart';
import 'globals.dart' as globals;

class login_Screen extends StatefulWidget {
  const login_Screen({super.key});

  @override
  State<login_Screen> createState() => _login_ScreenState();
}

class _login_ScreenState extends State<login_Screen> {
  //Controllers for fields
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // // CREDENTIALS FOR AUTH
  // final _clientId = '6fd20d17-de8d-4a86-ade1-7646d14a60d4';
  // final _tenantId = 'c8401f36-1f3c-4dba-b027-b707446a396d';
  // late final _authority =
  //     'https://login.microsoftonline.com/$_tenantId/oauth2/v2.0/authorize';
  // final _scopes = <String>[
  //   'https://graph.microsoft.com/user.read',
  // ];

  Future<MsalAuth> getMsalAuth() async {
    return MsalAuth.createPublicClientApplication(
      clientId: globals.clientID,
      scopes: globals.scopes,
      androidConfig: AndroidConfig(
        configFilePath: 'assets/msal_config.json',
        tenantId: globals.tenantId,
      ),
      iosConfig: IosConfig(authority: globals.authority),
    );
  }

  Future<void> getToken() async {
    try {
      final msalAuth = await getMsalAuth();
      final user = await msalAuth.acquireToken();

      // final jsonData = user?.toJson();
      globals.UserEmail = user!.username;
      globals.UserName = user!.displayName;
      final responseToken = user?.accessToken;
      // TOKEN CREATION AND EXPIRY
      // final responseTokenCreationTime = user?.tokenCreatedAt;
      // final responseTokenExpirationTime = user?.tokenExpiresOn;

      // log('Email: ${email}');
      // log('Display Name: ${name}');
      // log('Token: ${responseToken}');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('Name', user!.displayName);
      await prefs.setString('Email', user!.username);
      await prefs.setString('Token', responseToken!);
      print(responseToken);
    } on MsalException catch (e) {
      log('Msal exception with error: ${e.errorMessage}');
    } catch (e) {
      log(e.toString());
    }
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
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logo-no-background.png'),
                      const SizedBox(
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
                        height: 40,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await getToken();
                          final prefs = await SharedPreferences.getInstance();
                          var token = prefs.getString('Token');
                          if (token != null && token != "") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const passkeyCreation_Screen()));
                          } else {
                            Fluttertoast.showToast(
                                msg: "Authentication Failed",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black12,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                          var data = await get("/token/api/get_token");
                          prefs.setString(
                              "access-token", data?["access_token"]);
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const passkey_Screen()));
                            },
                            child: const Text(
                              'Passkey Login',
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
