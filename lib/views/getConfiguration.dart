
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/api_calling.dart';
import '../utils/commom_functions.dart';
import 'liveEventsScreen.dart';

class GetConfigurationScreen extends StatefulWidget {
  final String assetId;
 final String assetModel;

  GetConfigurationScreen({required this.assetId, required this.assetModel});

  @override
  _GetConfigurationScreenState createState() => _GetConfigurationScreenState();
}

class _GetConfigurationScreenState extends State<GetConfigurationScreen> {
  List<Map<String, dynamic>> getConfData = [];
  List<Map<String, dynamic>> originalGetData = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchGetData();
  }




  Future<void> fetchGetData() async {
    try {
      setState(() {
        isLoading = true;
      });


      // Fetch data from SQLite
      var edgeTelemetryModelData = await getFromSqllite("getset_model", "data_model" + widget.assetModel);
      print("GETSET assetModel"+ widget.assetModel);
      print("GETSET model: ${edgeTelemetryModelData.toString()}");

      if (edgeTelemetryModelData != null) {
        setState(() {
          // Assuming edgeTelemetryModelData is a List of maps
          getConfData = List<Map<String, dynamic>>.from(edgeTelemetryModelData);
          originalGetData = List<Map<String, dynamic>>.from(edgeTelemetryModelData); // Store original data if needed
        });
      }
    } catch (e, stackTrace) {

      var lines = stackTrace.toString().split('\n');
      if (lines.isNotEmpty) {
        // print('StackTrace line details: ${lines[0]}'); // Example: Print the first line of stack trace
      }

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

    if (getConfData.isEmpty) {
      return Center(child: Text('No Configuration data available',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[500])));
    }

    return ListView.builder(
      itemCount: getConfData.length,
      itemBuilder: (context, index) {
        return _buildHeartbeatCard(context, getConfData[index]);
      },
    );
  }

  Widget _buildHeartbeatCard(BuildContext context, Map<String, dynamic> data) {
    final currentTime = DateTime.now();
    final formattedTime = DateFormat('yyyy-MM-dd  HH:mm:ss').format(currentTime); // Format the current time

    String limitWords(String text, int maxWords) {
      List<String> words = text.split(' ');
      if (words.length <= maxWords) {
        return text;
      } else {
        return words.take(maxWords).join(' ') + '...';
      }
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      elevation: 4,
      color: Colors.white,
      child: ExpansionTile(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Spacer(),
            Text(
              limitWords(data['property_display_name'] ?? 'Unknown', 4),
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.grey[900]),
            ),
            Spacer(),
            Text(
              data['property_default_value'] ?? 'Unknown',
              style: TextStyle(fontSize: 13,color: Colors.grey[600],fontWeight: FontWeight.bold),
            ),
            //Spacer(),

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
                        _buildRichTextRow("Asset Model:", data['asset_model_short_code'] ?? 'N/A'),
                        _buildRichTextRow("Source:", data['source_short_code'] ?? 'N/A'),
                        _buildRichTextRow("Parameter:", data['property_display_name'] ?? 'N/A'),
                        _buildRichTextRow("Current Value:", data['property_default_value'] ?? 'N/A'),
                        _buildRichTextRow("TimeStamp:", formattedTime ?? 'N/A'),

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
        //         Text("Event: ${data['value'] ?? 'N/A'}"),
        //         Text("Source: ${data['child_device'] ?? 'N/A'}"),
        //       ],
        //     ),
        //   ),
        // ],
      ),
    );
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
                style: TextStyle(fontSize: 13, color: Colors.black,fontWeight: FontWeight.bold),
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



}
