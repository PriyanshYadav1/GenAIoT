import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> get(url) async {
  final prefs = await SharedPreferences.getInstance();
  print("dasdadasdada 4" + "Bearer ");
  var baseUrl = "https://xlr8-apim.azure-api.net";
  var access_token = await prefs.getString('access-token') ?? "";
  var appShortCode = await prefs.getString('appShortCode') ?? "";

  var headers = {
    "Authorization": "Bearer " + access_token,
    "temp_header_name": "xlr8-apim",
   "app_short_code": appShortCode,
  };
  print("dasdadasdada 4" + "Bearer "+access_token);

  try {
    var request = http.Request('GET', Uri.parse(baseUrl + url));

    request.headers.addAll(headers);
    print("URL===========" + baseUrl+url);
    print("dasdadasdada 12"+headers.toString());
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("dasdadasdadaaaaaaa" + response.statusCode.toString());
      var apiResp = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(apiResp);

      print("dasdadasdad=====30a"+jsonResponse.toString());

     // return jsonResponse;
      return {'success': true, 'data': jsonResponse};
    } else {
      // Show toast with error message

      print("dasdadasdada34" + response.statusCode.toString());
      print("dasdadasdada35" + response.reasonPhrase.toString());
      return {'success': false, 'message': '${response.reasonPhrase}'};

    }
  } catch (e) {
    // Handle any errors that occur during the request
    print("An error occurred: $e");
    return {'success': false, 'message': 'An error occurred: $e'};



  }
}

