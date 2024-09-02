import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> get(url) async {
  final prefs = await SharedPreferences.getInstance();
  print("dasdadasdada 4" + "Bearer ");
  var access_token = prefs.getString("access-token");
  print("dasdadasdada 4" + "Bearer " + access_token!);
  var baseUrl = "https://xlr8-apim.azure-api.net";
  var headers = {
    "Authorization": "Bearer " + access_token!,
    "temp_header_name": "xlr8-apim"
  };

  try {
    var request = http.Request('GET', Uri.parse(baseUrl + url));

    request.headers.addAll(headers);

    print("dasdadasdada 12");
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("dasdadasdada" + response.statusCode.toString());
      var apiResp = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(apiResp);

      print("dasdadasdad30a");

      return jsonResponse;
    } else {
      print("dasdadasdada34" + response.statusCode.toString());
      print("dasdadasdada35" + response.reasonPhrase.toString());
    }
  } catch (e) {
    // Handle any errors that occur during the request
    print("An error occurred: $e");
  }
}
