import 'package:flutter/cupertino.dart';

import '../views/assets.dart';

class ListItem {
  final String title;
  final IconData icon;
  final AssetStatus status;

  ListItem({required this.title, required this.icon, required this.status});

}