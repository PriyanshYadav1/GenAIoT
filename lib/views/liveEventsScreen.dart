




import 'dart:convert';
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:genaiot/models/live_data.dart';
import 'package:genaiot/utils/api_calling.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:genaiot/views/assets.dart';
// import 'package:kdgaugeview/kdgaugeview.dart';
// import 'package:intl/intl.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

// import 'liveEvents.dart';
import '../utils/DatabaseHelper.dart';

class LiveEventsScreen extends StatefulWidget {
  final String title;
  final String assetId;
  const LiveEventsScreen({super.key, required this.title, required this.assetId});

  @override
  _LiveEventsScreenState createState() => _LiveEventsScreenState();
}

class _LiveEventsScreenState extends State<LiveEventsScreen> {
  bool isLoading = true;
  int _selectedIndex = 0;
 // bool _telemetry = false;
  List<LiveData> gaugeDataList = [];
  List transformedData = [];
  List<dynamic> recentTelemetryData = [];
  List<dynamic> latestTelemetryData = [];
  List<dynamic> liveEventsData = [];
  bool isUtc = false;
  Map<String, List<FlSpot>> graphData = {};





  @override
  void initState() {
    super.initState();
    initializeGaugeData();
  }

  Future<void> initializeGaugeData() async {
      await fetchLatestTelemetry();
   await fetchRecentTelemetry();
    await liveEvents();
  }


  Future<void> fetchLatestTelemetry() async {
    try {
      setState(() {
        isLoading = true;
      });
      var liveData = await get("/api/assets/${widget.assetId}/latesttelemetry");
      print("live Data==================${liveData}");
      if (liveData == null || liveData["data"] == null || (liveData["data"] as List).isEmpty) {
              // No data from server
              _handleNoData();
              return;
            }
      if (liveData != null && liveData["data"] != null) {
        List<dynamic> data = liveData["data"];

        // Fetch the edge telemetry model data from SQLite
       // List<dynamic> edgeTelemetryModelData = await getFromSqllite("edge_telemetry_model");
        List<Map<String, dynamic>> transformedData = [];

        for (var item in data) {
          var edgeTelemetryModelData = await getFromSqllite("telemetry_model","data_model"+item['asset_model_short_code']);
          var widgetModelData = await getFromSqlListing("Latest Telemetry","widget"+item['asset_model_short_code']);

          print("widgetModelData"+widgetModelData.toString());
          // var telemetryModel = edgeTelemetryM[""]
          final double timestamp = (item['ts'] as num?)?.toDouble() ?? 0.0;
          final dateTime = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt(), isUtc: isUtc);
          final dateFormat = DateFormat('yyyy-MM-dd   HH:mm:ss');
          final formattedDate = dateFormat.format(dateTime);
          final Map<String, dynamic> itemData = item['data'] as Map<String, dynamic>? ?? {};

          for (var entry in itemData.entries) {
            final devId = entry.key;
            final metrics = entry.value as Map<String, dynamic>;

            for (var metric in metrics.entries) {
              var dataAll = await getValueByPropertyJsonKey("telemetry_model",edgeTelemetryModelData, metric.key.toString(), "property_json_key",widgetModelData,"Latest Telemetry");
              if(dataAll!=null){
                transformedData.add({
                  'devId': devId,
                  'name': metric.key,
                  'value': metric.value.toString(),
                  'ts': formattedDate,
                  'property_display_name': dataAll["property_display_name"],
                  'property_unit': dataAll["property_unit"],
                  'property_data_type': dataAll["property_data_type"],
                });
              }
              // else{
              //   transformedData.add({
              //     'devId': devId,
              //     'name': metric.key,
              //     'value': metric.value.toString(),
              //     'ts': formattedDate,
              //     'property_display_name': "",
              //     'property_unit': "",
              //   });
              // }

            }
          }
        }

        setState(() {
          latestTelemetryData = transformedData;
        });

        print("transformedData: $latestTelemetryData");
      }
    } catch (e, stackTrace) {
     // print('Exception: $e');
     // print('StackTrace: $stackTrace');
      // Optionally, you can parse the stack trace to get the line number
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

  Future<void> fetchRecentTelemetry() async {
    try {
      setState(() {
        isLoading = true;
      });



      var liveData = await get("/api/assets/${widget.assetId}/recenttelemetry");
      print("live Data==================${liveData}");


      if (liveData != null && liveData["data"] != null) {
        List<dynamic> data = liveData["data"];


        List<Map<String, dynamic>> transformedData = [];
        Map<String, List<double>> groupedData = {};
        for (var item in data) {

          var edgeTelemetryModelData = await getFromSqllite("telemetry_model","data_model"+item['asset_model_short_code']);

          var widgetModelData = await getFromSqlListing("Recent Telemetry","widget"+item['asset_model_short_code']);
          final double timestamp = (item['ts'] as num?)?.toDouble() ?? 0.0;
          final dateTime = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt(), isUtc: isUtc);
          final dateFormat = DateFormat('yyyy-MM-dd   HH:mm:ss');
          final formattedDate = dateFormat.format(dateTime);
          final Map<String, dynamic> itemData = item['data'] as Map<String, dynamic>? ?? {};

          for (var entry in itemData.entries) {
            final devId = entry.key;
            final metrics = entry.value as Map<String, dynamic>;

            for (var metric in metrics.entries) {
              var dataAll = await getValueByPropertyJsonKey("telemetry_model",edgeTelemetryModelData, metric.key.toString(), "property_json_key",widgetModelData,"Recent Telemetry");

              if(dataAll!=null){
                transformedData.add({
                  'devId': devId,
                  'name': metric.key,
                  'value': dataAll["property_data_type"] == "float" ? double.parse(metric.value.toString()).toStringAsFixed(2) : metric.value.toString(),
                  //'value': metric.value.toString(),
                  'ts': formattedDate,
                  'timestamp': dateTime,
                  'property_display_name': dataAll["property_display_name"],
                  'property_unit': dataAll["property_unit"],
                  'property_data_type': dataAll["property_data_type"],
                });
                // Collect data points by display name
                String displayName = dataAll["property_display_name"];
                double value;

                // Check data type
                if (metric.value is num) {
                  value = (metric.value as num).toDouble();
                } else if (metric.value is String) {
                  String stringValue = metric.value.toString().trim();
                  if (stringValue.isEmpty || stringValue == "N/A" || stringValue == "null") {
                    continue; // Skip this entry
                  }
                  try {
                    value = double.parse(stringValue);
                  } catch (e) {
                    continue;
                  }
                } else if (metric.value is bool) {
                  continue;
                } else {
                  continue;
                }


                // Initialize list if it doesn't exist
                if (!groupedData.containsKey(displayName)) {
                  groupedData[displayName] = [];
                }
                groupedData[displayName]!.add(value);
              }



            }
          }
        }
        // Sort transformedData by timestamp (oldest to most recent)
        transformedData.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));


        // transformedData.sort((a, b) => double.parse(a['value']).compareTo(double.parse(b['value'])));

        setState(() {
          recentTelemetryData = transformedData;
          this.graphData = _prepareGraphData(transformedData);

        });

        print("transformedData: $transformedData");
        print("groupedData: $groupedData");
      }
    } catch (e, stackTrace) {
      print('Error fetching recent telemetry: $e');
      print('Stack trace: $stackTrace');
      print('Error fetching recent telemetry');
      _handleError(Exception(e),stackTrace);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }









  Future<void> liveEvents() async {
    try {
      setState(() {
        isLoading = true;
      });

      var liveData = await get("/api/live_event/"+widget.assetId);
       print("live Data==================${liveData}");

      if (liveData != null && liveData["data"] != null) {
        List<dynamic> data = liveData["data"];



        List<Map<String, dynamic>> transformedData = [];

        for (var item in data) {

          var edgeTelemetryModelData = await getFromSqllite("event_model","data_model"+item['asset_model_short_code']);

          final double timestamp = (item['ts'] as num?)?.toDouble() ?? 0.0;
          final dateTime = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt(), isUtc: isUtc);
          final currentTime = DateTime.now().toUtc();
          final difference = currentTime.difference(dateTime);


          var formattedDate="";
          if (difference.inDays > 0) {

            formattedDate = '${difference.inDays} days ago';   }
          else if (difference.inHours > 0) {
            formattedDate = '${difference.inHours} hours ago';   }
          else if (difference.inMinutes > 0) {
            formattedDate = '${difference.inMinutes} minutes ago';   }
          else {
            formattedDate = 'just now';   }
          final dateFormat = DateFormat('yyyy-MM-dd    HH:mm:ss');
          final fullformattedDate = dateFormat.format(dateTime);
          final Map<String, dynamic> itemData = item['data'] as Map<String, dynamic>? ?? {};

          var widgetModelData = await getFromSqlListing("Recent Telemetry","widget"+item['asset_model_short_code']);

          for (var entry in itemData.entries) {
            print("ENNNTRRYYYYYYYYYYYY "+entry.toString()+"   key  "+entry.key.toString()+" value "+entry.value["ecode"].toString());
            final devId = entry.key;
            final metrics = entry.value as Map<String, dynamic>;

            for (var metric in metrics.entries) {
              var dataAll = await getValueByPropertyJsonKeydata("live",edgeTelemetryModelData, entry.value["ecode"].toString(), "event_code",widgetModelData,"");
              print(dataAll.toString()+"(dataAll.toString()");

             // print("EVENTTTTTT MESSAGE :"+dataAll.event_message);

              if(dataAll!=null){
                transformedData.add({
                  "tss":timestamp,
                  'devId': devId,
                  'name': metric.key,
                  //'value': metric.value.toString(),
                  'value': entry.value["ecode"].toString(),
                  'ts': formattedDate,
                  'fullts':fullformattedDate,
                  'property_display_name': dataAll["event_message"],
                  'property_unit': dataAll["event_severity"],
                });
              }else{
                transformedData.add({
                  "tss":timestamp,
                  'devId': devId,
                  'name': metric.key,
                 // 'value': metric.value.toString(),
                  'value': entry.value["ecode"].toString(),
                  'ts': formattedDate,
                  'fullts':fullformattedDate,
                  'property_display_name': "N/A",
                  'property_unit': "",
                });
              }

            }
          }
        }

        transformedData.sort((a, b) => b['tss'].compareTo(a['tss']));


        setState(() {
          liveEventsData = transformedData;
        });

        print("transformedData: $transformedData");
      }
    } catch (e,stackTrace) {
      print('Error fetching recent telemetry: $e');
      _handleError(Exception(e),stackTrace);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }






  void _handleNoData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('No data received from the server.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _handleError(Exception e, StackTrace stackTrace) {



    // Implement your logic to handle errors, e.g., show a dialog or a message
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while fetching data ${e} ${stackTrace}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }





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
       title:
       Center(
         child: Text(
           widget.title,
           style: GoogleFonts.inter(
             textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
           ),
         ),
       ),
        actions: [
          SizedBox(
            width: 50, // Adjust the width as needed
            child: Center(
              child: Text(''), // Placeholder or other widget if needed
            ),
          ),
          SizedBox(width: 10), // Add some spacing between the SizedBox and the right edge
        ],
       // title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildSelectedView(),
          ),

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
      padding: const EdgeInsets.only(top: 4.0),
      child: ElevatedButton(
        onPressed: () => _onNavButtonTapped(index),
        style: ElevatedButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : Colors.grey[800],
          backgroundColor: isSelected ? Colors.black : Colors.grey[300],
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
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
    final Map<String, List<FlSpot>> graphData = _prepareGraphData(recentTelemetryData);
    switch (_selectedIndex) {
      case 0:
        return _buildTelemetryView(latestTelemetryData);
      case 1:
        //return _buildRecentTelemetryView(recentTelemetryData);
        return _buildRecentTelemetryView(graphData);
      case 2:
        return _buildLiveEventsView(liveEventsData);
      default:
        return Center(child: Text('Select a View'));
    }
  }



  // Widget _buildSelectedView() {
  //   switch (_selectedIndex) {
  //     case 0:
  //       return _buildTelemetryView(latestTelemetryData);
  //     case 1:
  //       return _buildRecTelemetryView();
  //     case 2:
  //       return _buildLiveEventsView(liveEventsData);
  //     default:
  //       return Center(child: Text('Select a View'));
  //   }
  // }

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
          elevation: 4,
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
                        formateData(gaugeData["property_data_type"],gaugeData["value"]),
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






  Map<String, List<FlSpot>> _prepareGraphData(List<dynamic> telemetryData) {
    Map<String, List<FlSpot>> graphData = {};
    Map<String, List<String>> xLabels = {};

   // telemetryData.sort((a, b) => DateTime.parse(a['ts']).compareTo(DateTime.parse(b['ts'])));
    telemetryData.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));

    // Iterate through telemetryData and group by property_display_name
    for (var item in telemetryData) {
      String displayName = item["property_display_name"];

      double dataFinalVal= 0.0;


     // double value = double.tryParse(item["value"]) ?? 0.0; // Safely parse the value

      if(item["property_data_type"]=="float"){
        dataFinalVal=double.parse(item["value"]);
      }
      if(item["property_data_type"]=="integer"){
        dataFinalVal=double.parse(item["value"]);
      }
      // print(displayName+item.toString()+"displayNamedisplayNamedisplayName");
      // Check if the value is boolean and skip it if it is
      // if (item["value"] is bool) {
      //   continue; // Skip boolean values
      // }


      // double value = 0;
      // if (item["value"] is num) {
      //   value = (item["value"] as num).toDouble();
      // } else if (item["value"] is String) {
      //   String stringValue = item["value"].toString().trim();
      //   if (stringValue.isEmpty || stringValue == "N/A" || stringValue == "null") {
      //     continue;
      //   }
      //   try {
      //     value = double.parse(stringValue);
      //   } catch (e) {
      //     continue;
      //   }
      // } else {
      //   continue;
      // }

      if (!graphData.containsKey(displayName)) {
        graphData[displayName] = [];
        xLabels[displayName] = [];
      }

      // Add the FlSpot for this value (using its index or a timestamp as x)

      if(item["property_data_type"]=="float" || item["property_data_type"]=="integer") {
        int index = graphData[displayName]!
            .length; // Use the length as the x-axis
        graphData[displayName]!.add(FlSpot(index.toDouble(), dataFinalVal as double));
      }else{
        graphData[displayName]!.add(FlSpot(0, 0));
      }
      // Format the timestamp for the x-axis label
      String xLabel = DateFormat('yyyy-MM-dd HH:mm:ss').format(item['timestamp']);
      xLabels[displayName]!.add(xLabel);
    }

    return graphData;
  }

  Widget _buildRecentTelemetryView(Map<String, List<FlSpot>> graphData) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 7.0,
        mainAxisSpacing: 7.0,
      ),
      itemCount: graphData.keys.length,
      itemBuilder: (context, index) {

        final displayName = graphData.keys.elementAt(index);
        final dataPoints = graphData[displayName]!;



        String data_type = "property_data_type";
        String Unit = "Units";
        String latestTimestamp = "";
        String value = "";


        // Loop through recentTelemetryData to find the latest timestamp
        for (var telemetry in recentTelemetryData) {
          if (telemetry["property_display_name"] == displayName) {
            Unit = telemetry["property_unit"] ?? Unit;
            latestTimestamp = telemetry["ts"] ?? latestTimestamp;
            data_type = telemetry["property_data_type"];
            value = telemetry["value"];
          }
        }




        final gaugeData = {
          "property_display_name": displayName,
          'property_data_type' : data_type,
          'value' : value,
          "data_points": dataPoints,
          "ts": latestTimestamp.isNotEmpty ? latestTimestamp : DateTime.now().toString(),
          "property_unit": Unit,

          // Use the latest unit
        };
        double getDynamicInterval(double min, double max, int labelCount) {
          if (labelCount <= 0 || max <= min) {
            return 1;
          }
          double range = max - min;
          return range / labelCount;
        }
       // final double xInterval = getDynamicInterval(0, dataPoints.length.toDouble(), 5); // 5 labels on x-axis
        final double yInterval = getDynamicInterval(getDataMin(dataPoints), getDataMax(dataPoints), 1); // 6 labels on y-axis


        double dataMin = getDataMin(dataPoints);
        double dataMax = getDataMax(dataPoints);
        double yRange = dataMax - dataMin;
        double lowerLimit = dataMin - (yRange * 0.8);
        double upperLimit = dataMax + (yRange * 0.8);

        return Card(
          color: Colors.white,
          elevation: 4,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          displayName, // Use display name here
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 2,),
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
                  SizedBox(height: 10,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: SizedBox(
                        height: 400,
                        child: LineChart(
                          LineChartData(
                            minY: lowerLimit,
                            maxY: upperLimit,
                            borderData: FlBorderData(show: true),
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: yInterval,
                                  reservedSize: 40,
                                  // minIncluded: true,
                                  getTitlesWidget: (value, meta) {
                                    // String label = value.toInt().toString(); // Or any abbreviation logic
                                    // return Text(label.length > 3 ? label.substring(0, 3) : label);

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(value.toInt().toStringAsFixed(0)),
                                    );

                                    // int index = value.toInt(); // Get the index from the value
                                    // if (index % 2 == 0) {
                                    //   return Padding(
                                    //     padding: const EdgeInsets.symmetric(vertical: 4.0),
                                    //     child: Text(index.toString()), // Customize the label text if needed
                                    //   );
                                    // }
                                    // return Container();
                                  },
                                ),
                              ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: dataPoints,
                                isCurved: true,
                                dotData: FlDotData(show: true),
                                belowBarData: BarAreaData(show: false),
                                color: Colors.blue,
                                barWidth: 1,
                                aboveBarData: BarAreaData(show: false),
                              ),
                            ],
                            
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Column(
                    children: [
                      Text(
                        gaugeData["property_data_type"] == "integer"
                            ? (dataPoints.isNotEmpty ? dataPoints.last.y.toStringAsFixed(0) : 'N/A')
                            : gaugeData["property_data_type"] == "float"
                            ? (dataPoints.isNotEmpty ? dataPoints.last.y.toString() : 'N/A')
                            : gaugeData["property_data_type"] == "enum"
                            ? formateData(gaugeData["property_data_type"], gaugeData["value"])
                            : gaugeData["property_data_type"] == "boolean"
                            ? formateData(gaugeData["property_data_type"], gaugeData["value"])
                            : gaugeData["property_data_type"]!=null ? "jh" :"",


                        // gaugeData["property_data_type"] == "float" || gaugeData["property_data_type"] == "integer"
                        //     ? (dataPoints.isNotEmpty ? dataPoints.last.y.toString() : 'N/A')
                        //     :dataPoints.last.y.toString(),


                        //gaugeData["property_data_type"] == "float" || gaugeData["property_data_type"] == "integer" ? dataPoints.isNotEmpty ? dataPoints.last.y.toString() : 'N/A' : "dasdsa",
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8,),
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
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  List<FlSpot> getDataPoints(List<dynamic> dataPoints) {
    return List.generate(
      dataPoints.length,
          (index) => FlSpot(index.toDouble(), dataPoints[index].toDouble()),
    );
  }

// Function to find the minimum value from the data points
  double getDataMin(List<FlSpot> dataPoints) {
    return dataPoints.map((e) => e.y).reduce((a, b) => a < b ? a : b);
  }

// Function to find the maximum value from the data points
  double getDataMax(List<FlSpot> dataPoints) {
    return dataPoints.map((e) => e.y).reduce((a, b) => a > b ? a : b);
  }




  // Widget _buildRecentTelemetryView(List<dynamic> telemetryData) {
  //   return GridView.builder(
  //     padding: const EdgeInsets.all(8.0),
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 1,
  //       crossAxisSpacing: 7.0,
  //       mainAxisSpacing: 7.0,
  //     ),
  //     //itemCount: hardcodedTelemetryData.length,
  //     itemCount: telemetryData.length,
  //     itemBuilder: (context, index) {
  //      // final gaugeData = hardcodedTelemetryData[index];
  //       final gaugeData = telemetryData[index];
  //
  //       // Get data points from hardcoded data
  //       final dataPointsList = gaugeData["data_points"] as List<dynamic>? ?? [];
  //       final List<FlSpot> dataPoints = dataPointsList.isNotEmpty
  //           ? getDataPoints(dataPointsList)
  //           : [];
  //
  //       return Card(
  //         color: Colors.white,
  //         elevation: 4,
  //         child: Center(
  //           child: Padding(
  //             padding: const EdgeInsets.all(20.0),
  //             child: Column(
  //               children: [
  //                 Center(
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Text(
  //                         gaugeData["property_display_name"],
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 17,
  //                         ),
  //                       ),
  //                       SizedBox(height: 2,),
  //                       Text(
  //                         '(${gaugeData["property_unit"]})',
  //                         style: TextStyle(
  //                           color: Colors.grey[400],
  //                           fontSize: 15,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(height: 10,),
  //                // Spacer(),
  //                 Expanded(
  //                   child: Padding(
  //                     padding: const EdgeInsets.only(right: 10.0),
  //                     child: SizedBox(
  //                       height: 400,
  //                       child: LineChart(
  //                         LineChartData(
  //                           borderData: FlBorderData(show: true),
  //                           titlesData: FlTitlesData(
  //                             bottomTitles: AxisTitles(
  //                               sideTitles: SideTitles(
  //                                 showTitles: false,
  //                               ),
  //                             ),
  //                             topTitles: AxisTitles(
  //                               sideTitles: SideTitles(
  //                                 showTitles: false,
  //                               ),
  //                             ),
  //                             rightTitles: AxisTitles(
  //                               sideTitles: SideTitles(
  //                                 showTitles: false,
  //                               ),
  //                             ),
  //                             leftTitles: AxisTitles(
  //                               sideTitles: SideTitles(
  //                                 showTitles: true,
  //                                 reservedSize: 40, // Adjust size for left titles
  //                                 getTitlesWidget: (value, meta) {
  //                                   return Text(value.toString());
  //                                 },
  //                               ),
  //                             ),
  //                           ),
  //                           lineBarsData: [
  //                             LineChartBarData(
  //                               spots: dataPoints,
  //                               isCurved: true,
  //                               dotData: FlDotData(show: true),
  //                               belowBarData: BarAreaData(show: false),
  //                               color: Colors.blue,
  //                               // Add extra spacing
  //                               barWidth: 1,
  //                               aboveBarData: BarAreaData(show: false),
  //                             ),
  //                           ],
  //                           //gridData: FlGridData(show: true),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(height: 15,),
  //                // Spacer(),
  //                 Column(
  //                   children: [
  //                     Text(
  //                       formatData( gaugeData["value"]),
  //                       style: TextStyle(
  //                         fontSize: 35,
  //                         color: Colors.grey[600],
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 //Spacer(),
  //                 SizedBox(height: 8,),
  //                 Column(
  //                   children: [
  //                     Text(
  //                       gaugeData["ts"].toString(),
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 15,
  //                         color: Colors.grey[500],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }




  String formatData( dynamic value) {
    return '$value';
  }




  Widget _buildLiveEventsView(List<dynamic> liveEventsData) {

    print(liveEventsData.toString()+"liveEventsData");
    return _buildTicketList(liveEventsData);
  }

}

String formateData(gaugeData, gaugeData2) {


  if(gaugeData=="float"){

    return double.parse(gaugeData2).toStringAsFixed(2);
  }else  if(gaugeData=="integer"){
    return int.parse(gaugeData2).toStringAsFixed(0);
  }else  if(gaugeData=="enum"){

    print("gaugeData2"+gaugeData2);
    return gaugeData2.toString();
  }else  if(gaugeData=="boolean"){
    return gaugeData2==true ? "True" : "False";
  }
  return "";
}

Future<List> getFromSqllite(value,keys) async {

  final dataJson = await DatabaseHelper.instance.getDataByUniqueKey(keys);
  List<dynamic> dataList = [];

  if (dataJson != null) {
    if (dataJson != null) {

      var finalData = dataJson[DatabaseHelper.columnData];
      print(finalData);

      // Parse JSON data
      var parsedData = jsonDecode(finalData);

      // Check if parsedData is a List

      if(parsedData is Map){
        print("parsedData is Map");
      }
      if (parsedData is List) {
        dataList = parsedData;
      } else if (parsedData is Map) {
        // If it's an object, extract the desired list from it
        // For example, if the object has a key "dataList"
        if (parsedData.containsKey(value)) {
          dataList = parsedData[value] as List<dynamic>;
        } else {
          print("No valid list found in the JSON object");
        }
      } else {
        if (parsedData.containsKey(value)) {
          dataList = parsedData[value] as List<dynamic>;
        } else {
          print("No valid list found in the JSON object");
        }
        print("Parsed data is neither a List nor a Map");
      }

      print(dataList.toString() + " dataList.toString()");
    }
  }

  return dataList;


}


Future<List> getFromSqlliteList(keys) async {

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


Future<List> getFromSqlListing(values,keys) async {

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


dynamic getValueByPropertyJsonKey(String type,List<dynamic> widget_data, String propertyJsonKey, String keyName, List widgetModelData, String TelemetryName) {

  var asset_d = null;

  print(propertyJsonKey+keyName+"propertyJsonKey+keyName");
  for (var asset in widget_data) {
    // Debugging print statement


    for (var asset_data in widgetModelData) {
      print('Assetasset_data: ${asset_data["purpose"].toString()}');
      if(asset_data["purpose"]==TelemetryName){
        if (asset[keyName] == propertyJsonKey) {
          asset_d = asset; // Return the whole asset or modify this to return a specific property if needed
        }
      }
      // Check if the asset contains the property with the keyName and its value matches propertyJsonKey

    }

  }
  return asset_d; // Return null if the key is not found
}


dynamic getValueByPropertyJsonKeydata(String type,List<dynamic> widget_data, String propertyJsonKey, String keyName, List widgetModelData, String TelemetryName) {

  var asset_d = null;

  print(propertyJsonKey+keyName+"propertyJsonKey+keyName");
  for (var asset in widget_data) {
    // Debugging print statement


    for (var asset_data in widgetModelData) {
      print('Assetasset_data: ${asset_data["purpose"].toString()}');
        if (asset[keyName] == propertyJsonKey) {
          asset_d = asset; // Return the whole asset or modify this to return a specific property if needed
        }
      }
      // Check if the asset contains the property with the keyName and its value matches propertyJsonKey

    }


  return asset_d; // Return null if the key is not found
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

Widget _buildTicketList(List<dynamic> data) {
  return ListView.builder(
    itemCount: data.length,
    itemBuilder: (context, index) {
      return _buildTicketCard(context, data[index]);
    },
  );
}



Widget _buildTicketCard(BuildContext context, Map<String, dynamic> data) {

  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    elevation: 4,
    color: Colors.white,
    child: ExpansionTile(
      backgroundColor:Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         //getIconForPropertyUnit(data["property_unit"]),
          if(data["property_unit"]=="Warning")...[
            Icon(
              Icons.warning_outlined,color: Colors.amber,
              size: 24,
            ),
          ]else if(data["property_unit"]=="Info")...[
            Icon(
              Icons.info_outlined,color: Colors.blue,
              size: 24,
            )
          ]else if(data["property_unit"]=="Critical")...[
            Icon(
              Icons.warning_outlined,color: Colors.red ,
              size: 24,
            )
          ]else if(data["property_unit"]=="Error")...[
            Icon(
              Icons.warning_outlined,color: Colors.red,
              size: 24,
            )
          ]
          // else
          //   Icon(
          //       Icons.warning_outlined,color: Colors.amber,
          //       size: 24,)
            ,

          Spacer(),
          Text(
            //"ssss",
            data['value'] ?? 'Unknown',
            style: TextStyle( fontSize: 15),
          ),
          Spacer(),
          Text(
            data['ts'] ?? 'Unknown',
            style: TextStyle( fontSize: 15),
          ),
          Spacer(),
          Icon(Icons.thumb_up, size: 24),
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
                      _buildRichTextRow("Message:", data['property_display_name'] ?? 'N/A'),
                      _buildRichTextRow("Child Device:", data['devId'] ?? 'N/A'),
                      _buildRichTextRow("Actions:", data['t'] ?? 'N/A'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// Widget getIconForPropertyUnit(String propertyUnit) {
//   final iconMap = {
//     'Warning': Icons.warning_outlined,
//     'Info': Icons.info_outlined,
//     'Danger': Icons.warning_outlined,
//     'Error': Icons.warning_outlined,
//   };
//
//   final colorMap = {
//     'Warning': Colors.amber,
//     'Info': Colors.blue,
//     'Danger': Colors.red,
//     'Error': Colors.red,
//   };
//
//
//   final icon = iconMap[propertyUnit] ?? Icons.help_outline;
//   final color = colorMap[propertyUnit] ?? Colors.grey; // Fallback color if propertyUnit is unknown
//
//   return Icon(icon, color: color, size: 24);
// }


// Widget _buildRichTextRow(String label, String value) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 5.0, left: 10.0),
//     child: Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center, // Center row horizontally
//         children: [
//           // Label
//           SizedBox(
//             width: 120, // Adjust the width for alignment
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 label,
//                 style: TextStyle(fontSize: 13, color: Colors.black),
//                 textAlign: TextAlign.right, // Align text to the right within the box
//               ),
//             ),
//           ),
//           SizedBox(width: 10), // Space between label and value
//           // Value
//           Expanded(
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 value,
//                 style: TextStyle(fontSize: 13, color: Colors.black),
//               //  overflow: TextOverflow.ellipsis, // Handle overflow if needed
//                 textAlign: TextAlign.left, // Align text to the left within the box
//               ),
//             ),
//           ),
//         ],
//       ),
//
//     ),
//   );
// }


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




// IconData _getIconData(String status) {
//   switch (status) {
//     case 'info':
//       return Icons.info_outline;
//     case 'warning':
//       return Icons.warning_outlined;
//     case 'danger':
//       return Icons.warning_outlined;
//     default:
//       return Icons.warning_outlined;
//   }
// }
//
// Color _getIconColor(String status) {
//   switch (status) {
//     case 'info':
//       return Colors.blue; // Blue for info
//     case 'warning':
//       return Colors.yellow; // Yellow for warning
//     case 'danger':
//       return Colors.red; // Red for danger
//     default:
//       return Colors.grey; // Default color
//   }
// }




