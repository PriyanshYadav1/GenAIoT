import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget _buildConfigurations() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        onPressed: () {
          // Handle GET action
        },
        child: Text('GET'),
      ),
      SizedBox(height: 10),
      ElevatedButton(
        onPressed: () {
          // Handle SET action
        },
        child: Text('SET'),
      ),
    ],
  );
}