import 'dart:ffi';

import 'package:intl/intl.dart';



String convertToIST(double timestamp) {
  // Parse the timestamp string
  DateTime utcTime = DateTime.fromMillisecondsSinceEpoch((timestamp*1000).toInt(), isUtc: true);

  // IST is UTC+5:30
  Duration deviceOffset = DateTime.now().timeZoneOffset;


  // Duration istOffset = Duration();
  DateTime istTime = utcTime.add(deviceOffset);

  // Format the IST time to a readable string
  String formattedISTTime = DateFormat('yyyy-MM-dd   HH:mm:ss').format(istTime);
  return formattedISTTime;
}

String time_ago(double timestamp){
  DateTime utcTime = DateTime.fromMillisecondsSinceEpoch((timestamp*1000).toInt(), isUtc: true);

  // IST is UTC+5:30
  Duration deviceOffset = DateTime.now().timeZoneOffset;

  DateTime istTime = utcTime.add(deviceOffset);
  final currentTime = DateTime.now();

  print("currentTime"+currentTime.toString()+utcTime.toString()+istTime.toString()+deviceOffset.toString());
  final difference = currentTime.difference(istTime);
print("difference"+difference.toString());
  var formattedDate="";

  if (difference.inDays > 0) {
    formattedDate = '${difference.inDays} days ago';
  } else if (difference.inHours > 0) {
    formattedDate = '${difference.inHours} hours ago';
  } else if (difference.inMinutes > 0) {
    formattedDate = '${difference.inMinutes} minutes ago';
  } else {
    formattedDate = 'just now';
  }
  return formattedDate;
}