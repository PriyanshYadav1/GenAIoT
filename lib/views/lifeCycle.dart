
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/api_calling.dart';
import '../utils/commom_functions.dart';

class LifeCycle extends StatefulWidget {
  final String assetId;

  LifeCycle({required this.assetId});

  @override
  _LifeCycleState createState() => _LifeCycleState();
}

class _LifeCycleState extends State<LifeCycle> {
  Map<String, List<Map<String, dynamic>>> groupedLifeCycle = {};
  bool isLoading = false;
  List<Map<String, dynamic>> originalData = [];

  @override
  void initState() {
    super.initState();
    fetchLifeCycleData();
  }

  Future<void> fetchLifeCycleData() async {
    try {
      setState(() {
        isLoading = true;
      });

      var lifecycleData = await get("/api/lifecycle/" + widget.assetId);
      if (lifecycleData != null && lifecycleData["data"] != null) {
        List<dynamic> data = lifecycleData["data"];
        List<Map<String, dynamic>> transformedData = [];

        // Store the original data
        originalData = List<Map<String, dynamic>>.from(data);

        for (var item in data) {
          final double timestamp = (item['ts'] as num?)?.toDouble() ?? 0.0;
          final dateTime = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt(), isUtc: true);
          String dateKey = DateFormat('yyyy-MM-dd').format(dateTime);

          transformedData.add({
            'id': item['id'],
            'child_device_Life': item['child_device_short_code'],
            'event': item['event_type'],
            'fullts': convertToIST(item['ts']),
            'timestamp': timestamp,
            'date': dateKey,
          });
        }


        // Group by date
        groupedLifeCycle = {};
        for (var item in transformedData) {
          String dateKey = item['date'];
          if (!groupedLifeCycle.containsKey(dateKey)) {
            groupedLifeCycle[dateKey] = [];
          }
          groupedLifeCycle[dateKey]!.add(item);
        }

        // Sort dates in descending order
        List<String> sortedKeys = groupedLifeCycle.keys.toList()
          ..sort((a, b) => DateTime.parse(b).compareTo(DateTime.parse(a)));

        // Sort events within each date group by timestamp in descending order
        for (var key in sortedKeys) {
          groupedLifeCycle[key]!.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
        }

        // Update the groupedLifeCycle with sorted keys
        groupedLifeCycle = Map.fromIterable(sortedKeys,
            key: (key) => key,
            value: (key) => groupedLifeCycle[key]!);



      }
    } catch (e) {
      print('Error fetching lifecycle data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (groupedLifeCycle.isEmpty) {
      return Center(child: Text('No LifeCycle data available', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[500])));
    }

    return ListView(
      children: groupedLifeCycle.entries.map((entry) {
        String date = entry.key;
        List<Map<String, dynamic>> events = entry.value;

        return ExpansionTile(
          title: Text(date, style: TextStyle(fontWeight: FontWeight.bold),),
          trailing: SizedBox.shrink(),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text('Device', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('Event', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('Timestamp', style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text('JSON Packet', style: TextStyle(fontWeight: FontWeight.bold))),

                ],
              ),
            ),
            Divider(),
            // Data rows
            ...events.map((event) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(event['child_device_Life'] ?? 'Unknown')),
                    Expanded(child: Text(event['event'] ?? 'Unknown',
                      style: TextStyle(
                          color: (() {
                            if (event['event'] == 'Device Connected') {
                              return Colors.green; // Connected status
                            } else if (event['event'] == 'Device Disconnected') {
                              return Colors.red; // Disconnected status
                            } else {
                              return Colors.grey; // Default color for unknown status
                            }
                          })(),
                      ),)),
                    Expanded(child: Text(event['fullts'] ?? 'Unknown')),
                    Expanded(child: IconButton(
                      icon: Icon(Icons.remove_red_eye),
                      //   color: (() {
                      //     if (event['event'] == 'Device Connected') {
                      //       return Colors.green; // Connected status
                      //     } else if (event['event'] == 'Device Disconnected') {
                      //       return Colors.red; // Disconnected status
                      //     } else {
                      //       return Colors.grey; // Default color for unknown status
                      //     }
                      //   })(),
                      // ),
                      onPressed: () {
                        var originalItem = originalData.firstWhere((item) => item['id'] == event['id']);
                        _showPopupLife(context, originalItem);
                       // _showPopupLife(context, event);
                      },
                    ),),
                  ],
                ),
              );
            }).toList(),
          ],
        );

      }).toList(),
    );
  }

  void _showPopupLife(BuildContext context, Map<String, dynamic> originalData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Heartbeat JSON Packet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          content: SingleChildScrollView(
            child: ListBody(
              children: originalData.entries.map((entry) {
                return RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: '${entry.key}: ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      TextSpan(text: '${entry.value}\n', style: TextStyle(color: Colors.deepOrange)),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              child: Text('Close', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

//
//   void _showPopupLife(BuildContext context, Map<String, dynamic> originalData) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Life Cycle Event Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: originalData.entries.map((entry) {
//                 return RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(text: '${entry.key}: ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//                       TextSpan(text: '${entry.value}\n', style: TextStyle(color: Colors.deepOrange)),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//           actions: [
//             TextButton(
//               child: Text('Close', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

