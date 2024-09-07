import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/api_calling.dart';


class Base64Image extends StatelessWidget {
  final String apiUrl;
  final String filePath;

  Base64Image({required this.apiUrl, required this.filePath});

  Future<Uint8List> _fetchImageBytes() async {


    final response22 = await getData(apiUrl,filePath);

    return base64Decode(response22);
    // } else {
    //   throw Exception('Failed to load image');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _fetchImageBytes(),
      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return Image.memory(snapshot.data!);
        } else {
          return Center(child: Text('No data'));
        }
      },
    );
  }
}
