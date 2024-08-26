// import 'dart:developer';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:msal_auth/msal_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AuthMethods extends StatefulWidget {
//   const AuthMethods({super.key});
//
//   @override
//   State<AuthMethods> createState() => _AuthMethodsState();
// }
//
// class _AuthMethodsState extends State<AuthMethods> {
//   final _clientId = '6fd20d17-de8d-4a86-ade1-7646d14a60d4';
//   final _tenantId = 'c8401f36-1f3c-4dba-b027-b707446a396d';
//   late final _authority =
//       'https://login.microsoftonline.com/$_tenantId/oauth2/v2.0/authorize';
//   final _scopes = <String>[
//     'https://graph.microsoft.com/user.read',
//     // Add other scopes here if required.
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp();
//   }
//
//   Future<MsalAuth> getMsalAuth() async {
//     return MsalAuth.createPublicClientApplication(
//       clientId: _clientId,
//       scopes: _scopes,
//       androidConfig: AndroidConfig(
//         configFilePath: 'assets/msal_config.json',
//         tenantId: _tenantId,
//       ),
//       iosConfig: IosConfig(authority: _authority),
//     );
//   }
//
//   Future<void> getToken() async {
//     try {
//       String userToken;
//       final msalAuth = await getMsalAuth();
//       final user = await msalAuth.acquireToken();
//       log('User data: ${user?.toJson()}');
//       final prefs = await SharedPreferences.getInstance();
//       try {
//         userToken = user.toString();
//       } catch (q) {
//         userToken = 'Empty Token';
//         log(q.toString());
//         print("Token Not Found");
//       }
//       if (userToken != 'Empty Token') {
//         await prefs.setString('token', userToken);
//       } else {
//         await prefs.setString('token', userToken);
//       }
//     } on MsalException catch (e) {
//       log('Msal exception with error: ${e.errorMessage}');
//     } catch (e) {
//       log(e.toString());
//     }
//   }
//
//   Future<void> getTokenSilently() async {
//     try {
//       final msalAuth = await getMsalAuth();
//       final user = await msalAuth.acquireTokenSilent();
//       log('User data: ${user?.toJson()}');
//     } on MsalException catch (e) {
//       log('Msal exception with error: ${e.errorMessage}');
//     } catch (e) {
//       log(e.toString());
//     }
//   }
//
//   Future<void> logout() async {
//     try {
//       final msalAuth = await getMsalAuth();
//       await msalAuth.logout();
//     } on MsalException catch (e) {
//       log('Msal exception with error: ${e.errorMessage}');
//     } catch (e) {
//       log(e.toString());
//     }
//   }
// }
