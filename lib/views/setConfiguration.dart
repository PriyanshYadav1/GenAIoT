

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/api_calling.dart';
import '../utils/commom_functions.dart';
import 'liveEventsScreen.dart';

class SetConfigurationScreen extends StatefulWidget {
  final String assetId;
  final String assetModel;

  SetConfigurationScreen({required this.assetId, required this.assetModel});

  @override
  _SetConfigurationScreenState createState() => _SetConfigurationScreenState();
}

class _SetConfigurationScreenState extends State<SetConfigurationScreen> {
  List<Map<String, dynamic>> getConfData = [];
  List<Map<String, dynamic>> originalGetData = [];
  bool isLoading = false;
  Map<String, double> sliderValues = {};

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

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: getConfData.length,
            itemBuilder: (context, index) {
              return _buildHeartbeatCard(context, getConfData[index]);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(onPressed: (){},
                child: Text("Cancel",style: TextStyle(color: Colors.white)),style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800],
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),),),
           SizedBox(width: 5,),
            ElevatedButton(onPressed: (){},
              child: Text("Save",style: TextStyle(color: Colors.white),),style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),),),
            SizedBox(width: 5,),
          ],
        )
      ],
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
              limitWords(data['property_display_name'] ?? 'Unknown', 2),
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.grey[900]),
            ),
            Spacer(),
            _buildValueWidget(data),
            // Text(
            //   data['property_default_value'] ?? 'Unknown',
            //   style: TextStyle(fontSize: 13,color: Colors.grey[600],fontWeight: FontWeight.bold),
            // ),
            //Spacer(),

          ],
        ),
        trailing: SizedBox.shrink(),
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey[200]),
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

  Widget _buildValueWidget(Map<String, dynamic> data) {
    final propertyType = data['property_type'];
    final propertyDataType = data['property_data_type'];
    final String propertyId = data['property_display_name'];

    if (propertyType == 'read_only') {
      return Text(
        data['property_default_value'] ?? 'Unknown',
        style: TextStyle(fontSize: 13, color: Colors.grey[600], fontWeight: FontWeight.bold),
      );
    }
    else if (propertyType == 'read_write') {
      if (propertyDataType == 'integer') {
        // Initialize slider value if not already done
        sliderValues[propertyId] ??= double.tryParse(data['property_default_value'] ?? '0') ?? 0;

        double minValue = double.tryParse(data['property_min_value'].toString()) ?? 0;
        double maxValue = double.tryParse(data['property_max_value'].toString()) ?? 100;

        return Expanded(
          flex: 5,
         // width: double.infinity, // Makes the slider take the full width
         // padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Slider(
            value: sliderValues[propertyId]!,
            min: minValue,
            max: maxValue,
            divisions: (maxValue - minValue).toInt(), // Calculate divisions based on min and max
            activeColor: Colors.blue[400],
            label: sliderValues[propertyId]!.round().toString(),
            onChanged: (double newValue) {
              setState(() {
                sliderValues[propertyId] = newValue; // Update the selected value
              });
            },
          ),
        );
      } else if (propertyDataType == 'enum') {
        return DropdownButton<String>(
          value: data['property_default_value'],
          items: (data['property_enum'] as List<dynamic>).map<DropdownMenuItem<String>>((dynamic value) {
            return DropdownMenuItem<String>(

              value: value,
              child: Container(

                decoration: BoxDecoration(borderRadius:BorderRadius.circular(4) ,color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(value.toString(),style: TextStyle(fontSize: 14,color: Colors.grey[700]),)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              // Update the selected enum value here if necessary
              data['property_default_value'] = newValue; // Update the data source
            });
          },
          dropdownColor: Colors.white, // Background color for the dropdown menu
          style: TextStyle(fontSize: 16, color: Colors.red),
          underline: SizedBox(),
        );
      } else if (propertyDataType == 'boolean') {
        return DropdownButton<String>(
          value: data['property_default_value'],
          items: (data['property_enum'] as List<dynamic>).map<DropdownMenuItem<String>>((dynamic value) {
            return DropdownMenuItem<String>(

              value: value,
              child: Container(

                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(4) ,color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(value.toString(),style: TextStyle(fontSize: 14,color: Colors.grey[700]),)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              // Update the selected enum value here if necessary
              data['property_default_value'] = newValue; // Update the data source
            });
          },
          dropdownColor: Colors.white, // Background color for the dropdown menu
          style: TextStyle(fontSize: 16, color: Colors.red),
          underline: SizedBox(),
        );
      } else if (propertyDataType == 'string') {
        return DropdownButton<String>(
          value: data['property_default_value'],
          items: (data['property_enum'] as List<dynamic>).map<DropdownMenuItem<String>>((dynamic value) {
            return DropdownMenuItem<String>(

              value: value,
              child: Container(

                  decoration: BoxDecoration(borderRadius:BorderRadius.circular(4) ,color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(value.toString(),style: TextStyle(fontSize: 14,color: Colors.grey[700]),)),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              // Update the selected enum value here if necessary
              data['property_default_value'] = newValue; // Update the data source
            });
          },
          dropdownColor: Colors.white, // Background color for the dropdown menu
          style: TextStyle(fontSize: 16, color: Colors.red),
          underline: SizedBox(),
        );
      }
    }
   
    return SizedBox.shrink();
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
