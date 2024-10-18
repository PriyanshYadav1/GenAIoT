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
  List<Map<String, dynamic>> lifeCycle = [];
  List<Map<String, dynamic>> originalLifeCycle = [];
  bool isLoading = false;

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

      // Fetch heartbeat data from the API
      var lifecycleData = await get("/api/lifecycle/" + widget.assetId);
      print("LIFE CYCLE: $lifecycleData");

      if (lifecycleData != null && lifecycleData["data"] != null) {
        List<dynamic> data = lifecycleData["data"];
        List<Map<String, dynamic>> transformedData = [];

        // Store the original data
        originalLifeCycle = List<Map<String, dynamic>>.from(data);

        for (var item in data) {
          final double timestamp = (item['ts'] as num?)?.toDouble() ?? 0.0;
          final dateTime = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt(), isUtc: true);
          var formattedDate = '';
          final currentTime = DateTime.now().toUtc();
          // final difference = currentTime.difference(dateTime);

          print("convertToIST"+convertToIST(item['ts']));


          // if (difference.inDays > 0) {
          //   formattedDate = '${difference.inDays} days ago';
          // } else if (difference.inHours > 0) {
          //   formattedDate = '${difference.inHours} hours ago';
          // } else if (difference.inMinutes > 0) {
          //   formattedDate = '${difference.inMinutes} minutes ago';
          // } else {
          //   formattedDate = 'just now';
          // }

          final dateFormat = DateFormat('yyyy-MM-dd    HH:mm:ss');
          final fullformattedDate = dateFormat.format(dateTime);

          transformedData.add({
            'id': item['id'],
            'asset_id': item['asset_id'],
            'asset_name': item['asset_name'],
            'site_id': item['asset_site_id'],
            'app_code': item['app_short_code'],
            'model': item['asset_model_short_code'],
            'date': item['date'],
            'iothub': item['iothub_device_id'],
            'child_device_Life': item['child_device_short_code'],
            'event': item['event_type'],
            'ts': time_ago(item['ts']),
            'fullts': convertToIST(item['ts']),
            'timestamp': timestamp,
          });
        }

        // Sort the transformed data if necessary
        transformedData.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));

        // Update the state with transformed data
        setState(() {
          lifeCycle = transformedData;
        });

        print("Transformed Data: $transformedData");
      }
    } catch (e, stackTrace) {
      print('Error fetching heartbeat data: $e');
     // _handleError(Exception(e), stackTrace);
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

    if (lifeCycle.isEmpty) {
      return Center(child: Text('No LifeCycle data available',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.grey[500]),
      ));
    }
    return ListView.builder(
      itemCount: lifeCycle.length,
      itemBuilder: (context, index) {
        return _buildLifeCycleCard(context, lifeCycle[index]);
      },
    );
  }

  Widget _buildLifeCycleCard(BuildContext context, Map<String, dynamic> data) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 4,
      color: Colors.white,
      child: ExpansionTile(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            Text(
              //"ssss",
              data['child_device_Life'] ?? 'Unknown',
              style: TextStyle( fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey[900]),
            ),
            Spacer(),
            Text(
              //"ssss",
              data['fullts'] ?? 'Unknown',
              style: TextStyle( fontSize: 15,fontWeight: FontWeight.bold,color: Colors.grey[600]),
            ),
            Spacer(),
            // Expanded(
            //   child: Text(
            //     data['child_device_Life'] ?? 'Unknown Device',
            //     style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
            //   ),
            // ),
            // Expanded(
            //   child: Text(
            //     data['event'] ?? 'Unknown',
            //    // data['event'] ?? 'Unknown Event',
            //     style: TextStyle(fontSize: 15),
            //   ),
            // ),
            // Expanded(
            //   child: Text(
            //     data['fullts'] ?? 'Unknown',
            //     style: TextStyle(fontSize: 15),
            //   ),
            // ),
            IconButton(
              icon: Icon(Icons.remove_red_eye_sharp, size: 24),
              onPressed: () {
                var originalItem = originalLifeCycle.firstWhere((item) => item['id'] == data['id']);
                _showPopupLife(context, originalItem);
              },
            ),
          ],
        ),
        trailing: SizedBox.shrink(),
        children: [
          Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(

                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildRichTextRow("Time:", data['fullts'] ?? 'N/A'),
                        _buildRichTextRow("Event:", data['event'] ?? 'N/A'),
                        // _buildRichTextRow("Message:", data['ack'] ?? 'N/A'),
                        _buildRichTextRow("Source:", data['child_device_Life'] ?? 'N/A'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        // children: [
        //   Padding(
        //     padding: const EdgeInsets.all(15.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text("Time: ${data['fullts'] ?? 'N/A'}"),
        //         Text("Event: ${data['event'] ?? 'N/A'}"),
        //         Text("Source: ${data['child_device_Life'] ?? 'N/A'}"),
        //       ],
        //     ),
        //   ),
        // ],
      ),
    );
  }



  void _showPopupLife(BuildContext context, Map<String, dynamic> originalData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Life Cycle Events JSON Packet',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                //  Text('Data:', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                ...originalData.entries.map((entry) {
                  return RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${entry.key}: ',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '${entry.value}\n', // Add newline after each value
                          style: TextStyle(color: Colors.deepOrange),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Close',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
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

  Widget _buildRichTextRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3.0, left: 30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          SizedBox(
            width: 100,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                label,
                style: TextStyle(fontSize: 13, color: Colors.grey[900]),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          SizedBox(width: 10), // Space between label and value
          // Value
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                value,
                style: TextStyle(fontSize: 13, color: Colors.grey[900]),
                textAlign: TextAlign.left, // Align text to the left within the box
              ),
            ),
          ),
        ],
      ),
    );
  }


  void _showPopup(BuildContext context, Map<String, dynamic> originalData) {
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
