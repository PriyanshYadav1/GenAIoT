




  import 'dart:convert';

import 'package:flutter/material.dart';
  import 'package:genaiot/models/live_data.dart';
  import 'package:genaiot/utils/api_calling.dart';
  // import 'package:genaiot/views/assets.dart';
  // import 'package:kdgaugeview/kdgaugeview.dart';
 // import 'package:intl/intl.dart';
  import 'package:intl/intl.dart';
// import 'liveEvents.dart';

  import '../utils/DatabaseHelper.dart';

  class StatRepresentation extends StatefulWidget {
    final String title;

    const StatRepresentation({super.key, required this.title});

    @override
    _StatRepresentationState createState() => _StatRepresentationState();
  }

  class _StatRepresentationState extends State<StatRepresentation> {
    bool isLoading = true;
    int _selectedIndex = 0;
    //bool _telemetry = false;
    List<LiveData> gaugeDataList = [];
    List transformedData = [];
    List<dynamic> recentTelemetryData = [];
    List<dynamic> latestTelemetryData = [];

    // void _toggleTelemetry() {
    //   setState(() {
    //     _telemetry = !_telemetry; // Toggle the boolean value
    //   });
    // }

    @override
    void initState() {
      super.initState();
      initializeGaugeData();
    }

    Future<void> initializeGaugeData() async {
      await fetchLatestTelemetry();
      await fetchRecentTelemetry();
     // await liveEvents(); // Assuming you need to fetch tickets
    }

    Future<void> fetchLatestTelemetry() async {
      try {
        setState(() {
          isLoading = true;
        });

        var liveData = await get("/api/assets/562223bc-25fb-4057-a08a-74c02f1c5326/latesttelemetry");

        if (liveData != null && liveData["data"] != null) {
          List<dynamic> data = liveData["data"];

          // Fetch the edge telemetry model data from SQLite
          List<dynamic> edgeTelemetryModelData = await getFromSqllite("edge_telemetry_model");

          List<Map<String, dynamic>> transformedData = [];

          for (var item in data) {
            final double timestamp = (item['ts'] as num?)?.toDouble() ?? 0.0;
            final dateTime = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt(), isUtc: true);
            final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
            final formattedDate = dateFormat.format(dateTime);
            final Map<String, dynamic> itemData = item['data'] as Map<String, dynamic>? ?? {};

            for (var entry in itemData.entries) {
              final devId = entry.key;
              final metrics = entry.value as Map<String, dynamic>;

              for (var metric in metrics.entries) {
                var dataAll = await getValueByPropertyJsonKey(edgeTelemetryModelData, metric.key.toString(), "property_json_key");

                transformedData.add({
                  'devId': devId,
                  'name': metric.key,
                  'value': metric.value.toString(),
                  'ts': formattedDate,
                  'property_display_name': dataAll["property_display_name"],
                  'property_unit': dataAll["property_unit"],
                });
              }
            }
          }

          setState(() {
            latestTelemetryData = transformedData;
          });

          print("transformedData: $latestTelemetryData");
        }
      } catch (e) {
        print('Error fetching latest telemetry: $e');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }

    Future<void> fetchRecentTelemetry() async {
      try {
        setState(() {
          isLoading = true;
        });

        var liveData = await get("/api/assets/562223bc-25fb-4057-a08a-74c02f1c5326/recenttelemetry");

        if (liveData != null && liveData["data"] != null) {
          List<dynamic> data = liveData["data"];

          // Fetch the edge telemetry model data from SQLite
          List<dynamic> edgeTelemetryModelData = await getFromSqllite("edge_telemetry_model");

          List<Map<String, dynamic>> transformedData = [];

          for (var item in data) {
            final double timestamp = (item['ts'] as num?)?.toDouble() ?? 0.0;
            final dateTime = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt(), isUtc: true);
            final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
            final formattedDate = dateFormat.format(dateTime);
            final Map<String, dynamic> itemData = item['data'] as Map<String, dynamic>? ?? {};

            for (var entry in itemData.entries) {
              final devId = entry.key;
              final metrics = entry.value as Map<String, dynamic>;

              for (var metric in metrics.entries) {
                var dataAll = await getValueByPropertyJsonKey(edgeTelemetryModelData, metric.key.toString(), "property_json_key");

                transformedData.add({
                  'devId': devId,
                  'name': metric.key,
                  'value': metric.value.toString(),
                  'ts': formattedDate,
                  'property_display_name': dataAll["property_display_name"],
                  'property_unit': dataAll["property_unit"],
                });
              }
            }
          }

          setState(() {
            recentTelemetryData = transformedData;
          });

          print("transformedData: $transformedData");
        }
      } catch (e) {
        print('Error fetching recent telemetry: $e');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }




    // Future<void> initializeGaugeData() async {
    //   try {
    //     setState(() {
    //       isLoading = true; // Start loading
    //       transformedData = []; // Reset the transformed data
    //     });
    //
    //     var liveData = await get("/api/live_data/562223bc-25fb-4057-a08a-74c02f1c5326");
    //
    //     // Check if liveData contains data
    //     if (liveData == null || liveData["data"] == null || (liveData["data"] as List).isEmpty) {
    //       // No data from server, handle accordingly
    //       _handleNoData();
    //       return; // Exit early as there's no data to process
    //     }
    //
    //     var data = liveData["data"];
    //
    //     List<dynamic> edge_telemetry_model_data = await getFromSqllite("edge_telemetry_model");
    //
    //     for (var item in data) {
    //       final double timestamp = (item['ts'] as num?)?.toDouble() ?? 0.0;
    //       final dateTime = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt(), isUtc: true);
    //       final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    //       final formattedDate = dateFormat.format(dateTime);
    //       final Map<String, dynamic> itemData = item['data'] as Map<String, dynamic>? ?? {};
    //
    //       for (var entry in itemData.entries) {
    //         final devId = entry.key;
    //         final metrics = entry.value as Map<String, dynamic>;
    //
    //         for (var metric in metrics.entries) {
    //           var dataAll = await getValueByPropertyJsonKey(edge_telemetry_model_data, metric.key.toString(), "property_json_key");
    //
    //           print(dataAll.toString() + "dataAll.toString");
    //           transformedData.add({
    //             'devId': devId,
    //             'name': metric.key,
    //             'value': metric.value.toString(),
    //             'ts': formattedDate,
    //             'property_display_name': dataAll["property_display_name"],
    //             'property_unit': dataAll["property_unit"],
    //           });
    //         }
    //       }
    //     }
    //
    //     print("transformedData.to" + transformedData.toString());
    //
    //   } catch (e) {
    //     print('Error fetching data: $e');
    //
    //     _handleError(Exception(e));
    //   } finally {
    //     setState(() {
    //       isLoading = false; // End loading
    //     });
    //   }
    // }



    // void _handleNoData() {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('Error'),
    //         content: Text('No data received from the server.'),
    //         actions: <Widget>[
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             child: Text('OK'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

    // void _handleError(Exception e) {
    //   // Implement your logic to handle errors, e.g., show a dialog or a message
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('Error'),
    //         content: Text('An error occurred while fetching data: $e'),
    //         actions: <Widget>[
    //           TextButton(
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //             child: Text('OK'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }





    void _onNavButtonTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Expanded(
              child: _buildSelectedView(),
            ),
            // if(_telemetry)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       _buildNavButton('Recent', 0, "call"),
            //       _buildNavButton('Latest', 1, "call"),
            //     ],
            //   )
           // ,
           //  Row(
           //    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           //    children: [
           //      _buildNavButton('Metadata', 0,"call"),
           //      _buildNavButton('Telemetry', 1,"button"),
           //      _buildNavButton('Live Events', 2,"call"),
           //    ],
           //  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavButton('Latest Telemetry', 0),
                _buildNavButton('Recent Telemetry', 1),
                _buildNavButton('Live Events', 2),
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildNavButton(String label, int index) {
        bool isSelected = _selectedIndex == index;
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ElevatedButton(
            onPressed: () => _onNavButtonTapped(index),
            style: ElevatedButton.styleFrom(
              foregroundColor: isSelected ? Colors.white : Colors.grey[800],
              backgroundColor: isSelected ? Colors.black : Colors.grey[300],
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(200.0),
              ),
            ),
            child: Text(label),
          ),
        );


    }

    Widget _buildSelectedView() {
      switch (_selectedIndex) {
        case 0:
          return _buildTelemetryView(latestTelemetryData);
        case 1:
          return _buildTelemetryView(recentTelemetryData);
        case 2:
          return _buildLiveEventsView(_tickets);
        default:
          return Center(child: Text('Select a View'));
      }
    }



    Widget _buildTelemetryView(List<dynamic> telemetryData) {
      return isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 7.0,
          mainAxisSpacing: 7.0,
        ),
        itemCount: telemetryData.length,
        itemBuilder: (context, index) {
          final gaugeData = telemetryData[index];

          print("gaugeData: $gaugeData");
          return Card(
            color: Colors.white,
            elevation: 30,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            gaugeData["property_display_name"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            '(${gaugeData["property_unit"]})',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          gaugeData["value"],
                          style: TextStyle(
                            fontSize: 48,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(
                          gaugeData["ts"].toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
    }


    Widget _buildLiveEventsView(List<Ticket> tickets) {
      return _buildTicketList(tickets);
    }
  }

Future<List> getFromSqllite(keys) async {

  final dataJson = await DatabaseHelper.instance.getDataByUniqueKey(keys);
  List<dynamic> dataList = [];

  if (dataJson != null) {
    final jsonData = dataJson[DatabaseHelper.columnData] as String?;
    if (jsonData != null) {
      // Parse JSON data
      dataList = jsonDecode(jsonData);
      print(dataList.toString() + "dataList.toString()");
    }
  }

  return dataList;


}

  dynamic getValueByPropertyJsonKey(List<dynamic> widget_data, String propertyJsonKey, String keyName) {


    print(propertyJsonKey+keyName+"propertyJsonKey+keyName");
    for (var asset in widget_data) {
      // Debugging print statement
      print('Asset: ${asset.toString()}');

      // Check if the asset contains the property with the keyName and its value matches propertyJsonKey
      if (asset["property_json_key"] == propertyJsonKey) {
        return asset; // Return the whole asset or modify this to return a specific property if needed
      }
    }
    return null; // Return null if the key is not found
  }





  class GaugeData {
    final double minSpeed;
    final double maxSpeed;
    final double speed;
    final String unitOfMeasurement;
    final DateTime timestamp;
    final String displayName;
    final String widgetType;

    GaugeData({
      required this.minSpeed,
      required this.maxSpeed,
      required this.speed,
      required this.unitOfMeasurement,
      required this.timestamp,
      required this.displayName,
      required this.widgetType,
    });

    factory GaugeData.fromJson(Map<String, dynamic> json) {
      return GaugeData(
        minSpeed: json['minSpeed'],
        maxSpeed: json['maxSpeed'],
        speed: json['speed'],
        unitOfMeasurement: json['unitOfMeasurement'],
        timestamp: DateTime.parse(json['timestamp']),
        displayName: json['displayName'],
        widgetType: json['widgetType'],
      );
    }

    String getFormattedDate() {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute}:${timestamp.second}';
    }
  }

//================LIVE EVENTS===========================
 // =======================================================

  Widget _buildTicketList(List<Ticket> tickets) {
    return ListView.builder(
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        return _buildTicketCard(context, tickets[index]);
        //return _buildTicketCard(context, tickets[index]);
      },
    );
  }


  Widget _buildTicketCard(BuildContext context, Ticket ticket) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)), // Adjusted border radius for better appearance
      elevation: 4,


      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              _getIconData(ticket.status), // Get the correct icon based on status
              color: _getIconColor(ticket.status), // Get the correct color based on status
              size: 24,
            ),
            Spacer(),
           Text(
                "HDFULL",
                // ticket.title, // Display ticket title
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            Spacer(),

            Text(
              "(3 days ago)",
              // ticket.title, // Display ticket title
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Spacer(),
            Icon(Icons.thumb_up, size: 24),



          ],

        ),
        trailing: SizedBox.shrink(),
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildRichTextRow("Time Stamp:", "2024-09-10 12:10:10"),
                      _buildRichTextRow("Message:", "Time to clean hardDisk"),
                      _buildRichTextRow("Child Device:", "IG"),
                      _buildRichTextRow("Actions:", ""),
                    ],
                  ),
                ),
              ],
            )
    ),]),);
  }
  Widget _buildRichTextRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, left: 20.0),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center row horizontally
          children: [
            // Label
            SizedBox(
              width: 120, // Adjust the width for alignment
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                  textAlign: TextAlign.right, // Align text to the right within the box
                ),
              ),
            ),
            SizedBox(width: 10), // Space between label and value
            // Value
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  overflow: TextOverflow.ellipsis, // Handle overflow if needed
                  textAlign: TextAlign.left, // Align text to the left within the box
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }

  IconData _getIconData(String status) {
    switch (status) {
      case 'info':
        return Icons.info_outline;
      case 'warning':
        return Icons.warning_outlined;
      case 'danger':
        return Icons.warning_outlined;
      default:
        return Icons.warning_outlined;
    }
  }

  Color _getIconColor(String status) {
    switch (status) {
      case 'info':
        return Colors.blue; // Blue for info
      case 'warning':
        return Colors.yellow; // Yellow for warning
      case 'danger':
        return Colors.red; // Red for danger
      default:
        return Colors.grey; // Default color
    }
  }

  class Ticket {
    final String id;
    final String title;
    final String status;
    final String createdBy;
    final String createdOn;
    final String category;
    final String allottedTo;
    final String assignedTo;

    Ticket({
      required this.id,
      required this.title,
      required this.status,
      required this.createdBy,
      required this.createdOn,
      required this.category,
      required this.allottedTo,
      required this.assignedTo,
    });

    factory Ticket.fromJson(Map<String, dynamic> json) {
      return Ticket(
        id: json['id'],
        title: json['title'],
        status: json['status'],
        createdBy: json['createdBy'],
        createdOn: json['createdOn'],
        category: json['category'],
        allottedTo: json['allottedTo'],
        assignedTo: json['assignedTo'],
      );
    }
  }
  List<Ticket> _tickets = [
    Ticket(
      id: '001',
      title: 'Sample Ticket 11',
      status: 'New',
      category: 'Install',
      createdBy: 'User1',
      createdOn: '2024-09-10',
      allottedTo: 'User2',
      assignedTo: 'User3',
    ),
    Ticket(
      id: '002',
      title: 'Sample Ticket 2',
      status: 'In-progress',
      category: 'Ticket',
      createdBy: 'User4',
      createdOn: '2024-09-11',
      allottedTo: 'User5',
      assignedTo: 'User6',
    ),
  ];


