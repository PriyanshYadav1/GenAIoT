import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> get(url) async {
  final prefs = await SharedPreferences.getInstance();
  print("dasdadasdada 4" "Bearer ");
  var baseUrl = "https://xlr8-apim.azure-api.net";
  var accessToken = prefs.getString('access-token') ?? "";
  var appShortCode = prefs.getString('appShortCode') ?? "";

  var headers = {
    "Authorization": "Bearer $accessToken",
    "temp_header_name": "xlr8-apim",
   "app_short_code": appShortCode,
  };
  print("dasdadasdada 4Bearer $accessToken");

  try {
    var request = http.Request('GET', Uri.parse(baseUrl + url));

    request.headers.addAll(headers);
    print("URL===========$baseUrl"+url);
    print("dasdadasdada 12$headers");
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("dasdadasdadaaaaaaa${response.statusCode}");
      var apiResp = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(apiResp);

      print("dasdadasdad=====30a$jsonResponse");

     // return jsonResponse;
      return {'success': true, 'data': jsonResponse};
    } else {
      // Show toast with error message

      print("dasdadasdada34${response.statusCode}");
      print("dasdadasdada35${response.reasonPhrase}");
      return {'success': false, 'message': '${response.reasonPhrase}'};

    }
  } catch (e) {
    // Handle any errors that occur during the request
    print("An error occurred: $e");
    return {'success': false, 'message': 'An error occurred: $e'};



  }
}






Future<dynamic> getData(url,valdata) async {
  final prefs = await SharedPreferences.getInstance();
  print("dasdadasdada 4" "Bearer ");
  final client = http.Client();

  var baseUrl = "https://xlr8-apim.azure-api.net";
  var accessToken = prefs.getString('access-token') ?? "";
  var appShortCode = prefs.getString('appShortCode') ?? "";

  var headers = {
    "Authorization": "Bearer $accessToken",
    "temp_header_name": "xlr8-apim",
    "app_short_code": appShortCode,
    'responseType': 'arraybuffer',
    "app_icon_uri":valdata.toString()
  };
  print("dasdadasdada 4Bearer $accessToken");

  try {
    // var request = http.Request('GET', Uri.parse(baseUrl + url));
    final response = await http.get(Uri.parse(baseUrl + url), headers: {
      "Authorization": "Bearer $accessToken",
      "temp_header_name": "xlr8-apim",
      "app_short_code": appShortCode,
      'responseType': 'arraybuffer',
      "app_icon_uri":valdata.toString()
    });
    final Uint8List data = response.bodyBytes;

    final String base64String = base64Encode(data);
    print('Base64 Icon: $base64String');
    // request.headers.addAll(headers);
    //
    //
    // final streamedResponse = await client.send(request);
    // // Convert the stream to a list of bytes
    // final bytes = await streamedResponse.stream.toBytes();
    // print("streamedResponse"+bytes.toString()+"");
    //
    // // Decode the bytes to a string if necessary
    // final responseString = utf8.decode(bytes);
    // print(responseString.toString()+"streamedResponse");



    // If it's JSON, you can decode it further
    // final jsonResponse = jsonDecode(responseString);
    // print("URL===========" + baseUrl+url);
    // print("dasdadasdada 12"+headers.toString());
    // http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      // Uint8List data = response.bodyBytes;

      // print("dasdadasdadaaaaaaa" + response.statusCode.toString());
      // print("sdadsadadasdas"+response.stream.toString());
      // var apiResp = await response.stream.bytesToString();
      // print("dasdadasdad=====30a"+apiResp.toString());





      // var jsonResponse = jsonDecode(apiResp);
      //
      // print("dasdadasdad=====30a"+jsonResponse.toString());
      //
      // // return jsonResponse;
      return base64String;
    } else {
      // Show toast with error message

      // print("dasdadasdada34" + response.statusCode.toString());
      // print("dasdadasdada35" + response.reasonPhrase.toString());
      // return {'success': false, 'message': '${response.reasonPhrase}'};

    }
  } catch (e) {
    // Handle any errors that occur during the request
    print("An error occurred: $e");
    return {'success': false, 'message': 'An error occurred: $e'};



  }
}

