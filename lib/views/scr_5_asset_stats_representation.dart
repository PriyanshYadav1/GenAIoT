  // import 'package:flutter/material.dart';
  // import 'package:kdgaugeview/kdgaugeview.dart';
  //
  // class StatRepresentation extends StatefulWidget {
  //   final String title;
  //
  //   const StatRepresentation({super.key, required this.title});
  //
  //   Widget build(BuildContext context) {
  //     return MaterialApp(
  //       home: StatRepresentation(
  //         title: title,
  //         // appBar: AppBar(
  //         //   title: Text(title),
  //         // ),
  //       ),
  //     );
  //   }
  //
  //   @override
  //   _RepresentationState createState() => _RepresentationState();
  // }
  //
  // class _RepresentationState extends State<StatRepresentation> {
  //   @override
  //   Widget build(BuildContext context) {
  //     bool isPressed = false;
  //     return Scaffold(
  //       appBar: AppBar(
  //         title: Text(widget.title),
  //       ),
  //       backgroundColor: Colors.white,
  //       body: Container(
  //         child: Column(
  //           children: [
  //             const SizedBox(width: double.infinity, height: 20),
  //             const Row(
  //               children: <Widget>[
  //                 SizedBox(width: 20),
  //                 SizedBox(width: 20),
  //                 SizedBox(width: 20),
  //               ],
  //             ),
  //             const SizedBox(height: 3, width: double.infinity),
  //             Container(
  //               //alignment: AlignmentDirectional(-0.65,0),
  //               child: Expanded(
  //                 child: ListView(
  //                   padding: EdgeInsets.zero,
  //                   children: <Widget>[
  //                     Expanded(
  //                         child: Stack(
  //                       fit: StackFit.loose,
  //                       alignment: AlignmentDirectional.center,
  //                       children: <Widget>[
  //                         // const CircleAvatar(
  //                         //   backgroundColor: Colors.red,
  //                         //   foregroundColor: Colors.red,
  //                         //   radius: 80
  //                         // ),
  //                         Container(
  //                           decoration: BoxDecoration(
  //                               border: Border.all(
  //                                   width: 1.2, color: Colors.grey.shade300),
  //                               borderRadius: BorderRadius.circular(5),
  //                               color: Colors.white),
  //                           padding: const EdgeInsetsDirectional.all(20),
  //                           //color: Colors.white,
  //                           height: 250,
  //                           width: 250,
  //                           //foregroundDecoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.red.shade200,spreadRadius: 1,blurRadius: 0,offset: Offset(0, 0))]),
  //                           child: KdGaugeView(
  //                             minSpeed: 0,
  //                             maxSpeed: 232,
  //                             animate: true,
  //                             gaugeWidth: 12,
  //                             activeGaugeColor: Colors.lightBlue,
  //                             speed: 100,
  //                             // child: Column(
  //                             //   mainAxisAlignment: MainAxisAlignment.center,
  //                             //   children: <Widget>[
  //                             //     CircleAvatar(
  //                             //         backgroundColor: Colors.grey,
  //                             //         radius: 50
  //                             //     )
  //                             //   ],
  //                             // ),
  //                             duration: const Duration(seconds: 1),
  //                             unitOfMeasurement: "PSI",
  //                             unitOfMeasurementTextStyle: const TextStyle(
  //                               fontSize: 20,
  //                               fontWeight: FontWeight.bold,
  //                               height: -14,
  //                               color: Colors.grey,
  //                             ),
  //                             speedTextStyle: const TextStyle(
  //                                 fontSize: 25,
  //                                 fontWeight: FontWeight.bold,
  //                                 height: 2,
  //                                 color: Colors.lightBlueAccent),
  //                             innerCirclePadding: 8,
  //                             subDivisionCircleColors: Colors.white,
  //                             divisionCircleColors: Colors.white,
  //                             //inactiveGaugeColor: Colors.white,
  //                             minMaxTextStyle: const TextStyle(
  //                                 fontSize: 15,
  //                                 fontWeight: FontWeight.bold,
  //                                 height: -8,
  //                                 color: Colors.grey),
  //                           ),
  //                         ),
  //                       ],
  //                     )),
  //                     const SizedBox(
  //                       height: 20,
  //                     ),
  //                     Expanded(
  //                         child: Stack(
  //                       fit: StackFit.loose,
  //                       alignment: AlignmentDirectional.center,
  //                       children: <Widget>[
  //                         // const CircleAvatar(
  //                         //   backgroundColor: Colors.red,
  //                         //   foregroundColor: Colors.red,
  //                         //   radius: 80
  //                         // ),
  //                         Container(
  //                           decoration: BoxDecoration(
  //                               border: Border.all(
  //                                   width: 1.2, color: Colors.grey.shade300),
  //                               borderRadius: BorderRadius.circular(5),
  //                               color: Colors.white),
  //                           padding: const EdgeInsetsDirectional.all(20),
  //                           //color: Colors.white,
  //                           height: 250,
  //                           width: 250,
  //                           //foregroundDecoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.red.shade200,spreadRadius: 1,blurRadius: 0,offset: Offset(0, 0))]),
  //                           child: KdGaugeView(
  //                             minSpeed: 0,
  //                             maxSpeed: 232,
  //                             animate: true,
  //                             gaugeWidth: 12,
  //                             activeGaugeColor: Colors.lightBlue,
  //                             speed: 100,
  //                             // child: Column(
  //                             //   mainAxisAlignment: MainAxisAlignment.center,
  //                             //   children: <Widget>[
  //                             //     CircleAvatar(
  //                             //         backgroundColor: Colors.grey,
  //                             //         radius: 50
  //                             //     )
  //                             //   ],
  //                             // ),
  //                             duration: const Duration(seconds: 1),
  //                             unitOfMeasurement: "F",
  //                             unitOfMeasurementTextStyle: const TextStyle(
  //                               fontSize: 20,
  //                               fontWeight: FontWeight.bold,
  //                               height: -14,
  //                               color: Colors.grey,
  //                             ),
  //                             speedTextStyle: const TextStyle(
  //                                 fontSize: 25,
  //                                 fontWeight: FontWeight.bold,
  //                                 height: 2,
  //                                 color: Colors.lightBlueAccent),
  //                             innerCirclePadding: 8,
  //                             subDivisionCircleColors: Colors.white,
  //                             divisionCircleColors: Colors.white,
  //                             //inactiveGaugeColor: Colors.white,
  //                             minMaxTextStyle: const TextStyle(
  //                                 fontSize: 15,
  //                                 fontWeight: FontWeight.bold,
  //                                 height: -8,
  //                                 color: Colors.grey),
  //                           ),
  //                         ),
  //                       ],
  //                     )),
  //                     const SizedBox(
  //                       height: 20,
  //                     ),
  //                     ListTile(
  //                       contentPadding:
  //                           const EdgeInsets.only(left: 30.0, right: 30.0),
  //                       leading: Text("Hours",
  //                           style: TextStyle(
  //                               fontSize: 17, color: Colors.grey.shade600)),
  //                       trailing: const Text("12570 Hours",
  //                           style: TextStyle(fontSize: 17, color: Colors.black)),
  //                     ),
  //                     ListTile(
  //                       contentPadding:
  //                           const EdgeInsets.only(left: 30.0, right: 30.0),
  //                       leading: Text("Hours Left To Service",
  //                           style: TextStyle(
  //                               fontSize: 17, color: Colors.grey.shade600)),
  //                       trailing: const Text("2430 Hours",
  //                           style: TextStyle(fontSize: 17, color: Colors.black)),
  //                     ),
  //                     ListTile(
  //                       contentPadding:
  //                           const EdgeInsets.only(left: 30.0, right: 30.0),
  //                       leading: Text("Voltage",
  //                           style: TextStyle(
  //                               fontSize: 17, color: Colors.grey.shade600)),
  //                       trailing: const Text("472Ac-482AC/665DC",
  //                           style: TextStyle(fontSize: 17, color: Colors.black)),
  //                     ),
  //                     ListTile(
  //                       contentPadding:
  //                           const EdgeInsets.only(left: 30.0, right: 30.0),
  //                       leading: Text("Hours",
  //                           style: TextStyle(
  //                               fontSize: 17, color: Colors.grey.shade600)),
  //                       trailing: const Text("12570 Hours",
  //                           style: TextStyle(fontSize: 17, color: Colors.black)),
  //                     ),
  //                     ListTile(
  //                       contentPadding:
  //                           const EdgeInsets.only(left: 30.0, right: 30.0),
  //                       leading: Text("Hours Left To Service",
  //                           style: TextStyle(
  //                               fontSize: 17, color: Colors.grey.shade600)),
  //                       trailing: const Text("2430 Hours",
  //                           style: TextStyle(fontSize: 17, color: Colors.black)),
  //                     ),
  //                     ListTile(
  //                       contentPadding:
  //                           const EdgeInsets.only(left: 30.0, right: 30.0),
  //                       leading: Text("Voltage",
  //                           style: TextStyle(
  //                               fontSize: 17, color: Colors.grey.shade600)),
  //                       trailing: const Text("472Ac-482AC/665DC",
  //                           style: TextStyle(fontSize: 17, color: Colors.black)),
  //                     ),
  //                     ListTile(
  //                       contentPadding:
  //                           const EdgeInsets.only(left: 30.0, right: 30.0),
  //                       leading: Text("Average Frequency",
  //                           style: TextStyle(
  //                               fontSize: 17, color: Colors.grey.shade600)),
  //                       trailing: const Text("12570 Hours",
  //                           style: TextStyle(fontSize: 17, color: Colors.black)),
  //                     ),
  //                     ListTile(
  //                       contentPadding:
  //                           const EdgeInsets.only(left: 30.0, right: 30.0),
  //                       leading: Text("Voltage",
  //                           style: TextStyle(
  //                               fontSize: 17, color: Colors.grey.shade600)),
  //                       trailing: const Text("472Ac-482AC/665DC",
  //                           style: TextStyle(fontSize: 17, color: Colors.black)),
  //                     ),
  //                     ListTile(
  //                       contentPadding:
  //                           const EdgeInsets.only(left: 30.0, right: 30.0),
  //                       leading: Text("Hours",
  //                           style: TextStyle(
  //                               fontSize: 17, color: Colors.grey.shade600)),
  //                       trailing: const Text("12570 Hours",
  //                           style: TextStyle(fontSize: 17, color: Colors.black)),
  //                     ),
  //                     ListTile(
  //                       contentPadding:
  //                           const EdgeInsets.only(left: 30.0, right: 30.0),
  //                       leading: Text("Hours Left To Service",
  //                           style: TextStyle(
  //                               fontSize: 17, color: Colors.grey.shade600)),
  //                       trailing: const Text("2430 Hours",
  //                           style: TextStyle(fontSize: 17, color: Colors.black)),
  //                     ),
  //                     ListTile(
  //                       contentPadding:
  //                           const EdgeInsets.only(left: 30.0, right: 30.0),
  //                       leading: Text("Voltage",
  //                           style: TextStyle(
  //                               fontSize: 17, color: Colors.grey.shade600)),
  //                       trailing: const Text("472Ac-482AC/665DC",
  //                           style: TextStyle(fontSize: 17, color: Colors.black)),
  //                     ),
  //                     ListTile(
  //                       contentPadding:
  //                           const EdgeInsets.only(left: 30.0, right: 30.0),
  //                       leading: Text("Hours",
  //                           style: TextStyle(
  //                               fontSize: 17, color: Colors.grey.shade600)),
  //                       trailing: const Text("12570 Hours",
  //                           style: TextStyle(fontSize: 17, color: Colors.black)),
  //                     ),
  //                     ListTile(
  //                       contentPadding:
  //                           const EdgeInsets.only(left: 30.0, right: 30.0),
  //                       leading: Text("Hours Left To Service",
  //                           style: TextStyle(
  //                               fontSize: 17, color: Colors.grey.shade600)),
  //                       trailing: const Text("2430 Hours",
  //                           style: TextStyle(fontSize: 17, color: Colors.black)),
  //                     ),
  //                     ListTile(
  //                       contentPadding:
  //                           const EdgeInsets.only(left: 30.0, right: 30.0),
  //                       leading: Text("Voltage",
  //                           style: TextStyle(
  //                               fontSize: 17, color: Colors.grey.shade600)),
  //                       trailing: const Text("472Ac-482AC/665DC",
  //                           style: TextStyle(fontSize: 17, color: Colors.black)),
  //                     ),
  //                     ListTile(
  //                       contentPadding:
  //                           const EdgeInsets.only(left: 30.0, right: 30.0),
  //                       leading: Text("Average Frequency",
  //                           style: TextStyle(
  //                               fontSize: 17, color: Colors.grey.shade600)),
  //                       trailing: const Text("12570 Hours",
  //                           style: TextStyle(fontSize: 17, color: Colors.black)),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             Expanded(
  //                 flex: 0,
  //                 child: Row(
  //                   children: [
  //                     const SizedBox(width: 13.5),
  //                     ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                         backgroundColor: isPressed
  //                             ? Colors.grey.shade500
  //                             : Colors.grey.shade300,
  //                         elevation: isPressed ? 8 : 2,
  //                       ),
  //                       onPressed: () {
  //                         setState(() {
  //                           isPressed = !isPressed; // Toggle the pressed state
  //                         });
  //                         // Your onPressed action goes here
  //                       },
  //                       child: const Text(
  //                         'MetaData',
  //                         style: TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.black),
  //                       ),
  //                     ),
  //                     const SizedBox(width: 10),
  //                     ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                           backgroundColor: Colors.grey.shade300),
  //                       onPressed: () {},
  //                       child: const Text(
  //                         'Live Data',
  //                         style: TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.black),
  //                       ),
  //                     ),
  //                     const SizedBox(width: 10),
  //                     ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                           backgroundColor: Colors.grey.shade300),
  //                       onPressed: () {},
  //                       child: const Text(
  //                         'Live Action',
  //                         style: TextStyle(
  //                             fontSize: 16,
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.black),
  //                       ),
  //                     ),
  //                     const SizedBox(width: 10)
  //                   ],
  //                 )),
  //             const SizedBox(height: 10, width: double.infinity)
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  // }


  //
  //
  //
  // import 'package:flutter/material.dart';
  // import 'package:genaiot/models/live_data.dart';
  // import 'package:genaiot/utils/api_calling.dart';
  // import 'package:genaiot/views/assets.dart';
  // import 'package:kdgaugeview/kdgaugeview.dart';
  // import 'dart:convert'; // Required for jsonDecode
  //
  // class StatRepresentation extends StatefulWidget {
  //   final String title;
  //
  //   const StatRepresentation({super.key, required this.title});
  //
  //   @override
  //   _StatRepresentationState createState() => _StatRepresentationState();
  // }
  //
  // class _StatRepresentationState extends State<StatRepresentation> {
  //   bool isLoading = true;
  //   List<GaugeData> gaugeDataList = [];
  //   List<String> appsDataList = ["","",""];
  //   int _selectedIndex = 1;
  //   List<dynamic> widgetsListing = [];
  //
  //   @override
  //   void initState() {
  //     super.initState();
  //     initializeGaugeData();
  //   }
  //
  //
  //
  //
  //
  //   Future<void> initializeGaugeData () async {
  //
  //
  //     var edge_telemetry_model = await get("/api/edge_telemetry_model/CNGCOM");
  //     var live_data = await get("/api/live_data/562223bc-25fb-4057-a08a-74c02f1c5326");
  //     var widgets = await get("/api/widgets/CNGCOM");
  //
  //
  //     // print(edge_telemetry_model["data"].toString()+"edge_telemetry_model datadatadata");
  //     // print(live_data["data"].toString()+"widgets datadatadata");
  //     // print("widgets datadatadata"+widgets["data"][0]["id"].toString());
  //     var data = live_data["data"];
  //     // var appsDataList = data.map((json) {
  //     //   return LiveData.fromJson(json is Map<String, dynamic> ? json : {});
  //     // }).toList();
  //
  //
  //     // print("=========================apps.toString()="+appsDataList.length.toString());
  //
  //     // apps.map((json) {
  //     //   gaugeDataList.add(
  //     //       GaugeData(
  //     //         minSpeed: 0,
  //     //         maxSpeed: 250,
  //     //         speed: 100,
  //     //         unitOfMeasurement: "°C",
  //     //         timestamp: DateTime.fromMillisecondsSinceEpoch(1724230979 * 1000),
  //     //         displayName: "Temperature change",
  //     //         widgetType: "gauge",
  //     //       ));
  //     //   });
  //
  //
  //
  //
  //
  //
  //     // if (widgets["data"] is List) {
  //     //   // Map the JSON data to a list of WidgetData objects
  //     //   List<WidgetData> widgets = widgets["data"]
  //     //       .map<WidgetData>((json) => WidgetData.fromJson(json))
  //     //       .toList();
  //     //
  //     //   // Use the parsed list of WidgetData objects
  //     //   for (var widget in widgets) {
  //     //     print('Widget ID: ${widget.id}');
  //     //     print('Widget Code: ${widget.widgetCode}');
  //     //     print('Property JSON Key: ${widget.widgetParameters.propertyJsonKey}');
  //     //     print('Purpose: ${widget.purpose}');
  //     //     print('---');
  //     //   }
  //     // } else {
  //     //   print('Unexpected JSON format');
  //     // }
  //
  //     // print("===================="+data.toString());
  //
  //
  //     // final assets = data.map((json) {
  //     //   return Asset.fromJson(json is Map<String, dynamic> ? json : {});
  //     // }).toList();
  //     //
  //     // print(assets.first.purpose+"assets.first.purpose");
  //
  //     //
  //     // List<LiveData> apps = [];
  //     // apps = widgets["data"].map((json) {
  //     //   print(LiveData.fromJson(json).appShortCode+"appShortCodeappShortCodeappShortCode");
  //     // }).toList();
  //
  //
  //     // print(apps.toString()+"dsadsadsa");
  //
  //     // print("=============${LiveData.fromJson(live_data["data"][0]).appShortCode}");
  //
  //
  //     gaugeDataList = [
  //       GaugeData(
  //         minSpeed: 0,
  //         maxSpeed: 250,
  //         speed: 100,
  //         unitOfMeasurement: "°C",
  //         timestamp: DateTime.fromMillisecondsSinceEpoch(1724230979 * 1000),
  //         displayName: "Temperature change",
  //         widgetType: "gauge",
  //       ),
  //       GaugeData(
  //         minSpeed: 0,
  //         maxSpeed: 250,
  //         speed: 120,
  //         unitOfMeasurement: "hPa",
  //         timestamp: DateTime.fromMillisecondsSinceEpoch(1724230979 * 1000),
  //         displayName: "Pressure",
  //         widgetType: "line",
  //       ),
  //       GaugeData(
  //         minSpeed: 0,
  //         maxSpeed: 250,
  //         speed: 100,
  //         unitOfMeasurement: "°C",
  //         timestamp: DateTime.fromMillisecondsSinceEpoch(1724230979 * 1000),
  //         displayName: "Temperature",
  //         widgetType: "gauge",
  //       ),
  //       GaugeData(
  //         minSpeed: 0,
  //         maxSpeed: 250,
  //         speed: 120,
  //         unitOfMeasurement: "hPa",
  //         timestamp: DateTime.fromMillisecondsSinceEpoch(1724230979 * 1000),
  //         displayName: "Pressure",
  //         widgetType: "line",
  //       ),
  //     ];
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  //
  //   void _onNavButtonTapped(int index) {
  //     setState(() {
  //       _selectedIndex = index;
  //     });
  //   }
  //
  //   @override
  //   Widget build(BuildContext context) {
  //     return Scaffold(
  //       appBar: AppBar(
  //         backgroundColor: Colors.white,
  //         title: Text(widget.title),
  //       ),
  //       body: Column(
  //         children: [
  //           // Navigation Buttons
  //           // Expanded(
  //           //   child: _buildSelectedView(),
  //           // ),
  //           // Expanded(
  //           //   child: _buildSelectedView(),
  //           // ),
  //           // Row(
  //           //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           //   children: [
  //           //     _buildNavButton('Metadata', 0),
  //           //     _buildNavButton('Live Data', 1),
  //           //     _buildNavButton('Live Events', 2),
  //           //   ],
  //           // ),
  //           //
  //           Container(
  //             child: Text("data"),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: GridView.builder(
  //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //                 crossAxisCount: 2,
  //                 crossAxisSpacing: 5.0,
  //                 mainAxisSpacing: 5.0,
  //               ),
  //               itemCount: 10,
  //               itemBuilder: (context, index) {
  //                 return Container(
  //                 child: Text("data"),
  //                 );
  //               }
  //             ),
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               _buildNavButton('Metadata', 0),
  //               _buildNavButton('Live Data', 1),
  //               _buildNavButton('Live Events', 2),
  //             ],
  //           ),
  //
  //         ],
  //       ),
  //
  //
  //       // Column(
  //       //   children: [
  //       // Navigation Buttons
  //       //     Container(
  //       //       child: Row(
  //       //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       //         children: [
  //       //           _buildNavButton('Metadata', 0),
  //       //           _buildNavButton('Live Data', 1),
  //       //           _buildNavButton('Live Events', 2),
  //       //         ],
  //       //       ),
  //       //     ),
  //       //     Expanded(
  //       //       child: _buildSelectedView(),
  //       //     ),
  //       //   ],
  //       // ),
  //     );
  //   }
  //
  //   Widget _buildNavButton(String label, int index) {
  //     bool isSelected = _selectedIndex == index;
  //     return Padding(
  //       padding: const EdgeInsets.only(top: 8.0),
  //       child: ElevatedButton(
  //         onPressed: () => _onNavButtonTapped(index),
  //         style: ElevatedButton.styleFrom(
  //           foregroundColor: isSelected ? Colors.white : Colors.grey[800],
  //           backgroundColor: isSelected ? Colors.black : Colors.grey[300],
  //           padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  //           elevation: 0,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(200.0),
  //           ),
  //         ),
  //         child: Text(label),
  //       ),
  //     );
  //   }
  //
  //   Widget _buildSelectedView() {
  //     switch (_selectedIndex) {
  //       case 0:
  //         return _buildMetadataView();
  //       case 1:
  //         return _buildLiveDataView();
  //       case 2:
  //         return _buildLiveEventsView();
  //       default:
  //         return Center(child: Text('Select a View'));
  //     }
  //   }
  //
  //   Widget _buildLiveDataView() {
  //     return isLoading
  //         ? const Center(child: CircularProgressIndicator())
  //         : GridView.builder(
  //       padding: const EdgeInsets.all(8.0),
  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 1, // Single column grid
  //         crossAxisSpacing: 10.0,
  //         mainAxisSpacing: 10.0,
  //       ),
  //       itemCount: widgetsListing.length,
  //       itemBuilder: (context, index) {
  //         final gaugeData = widgetsListing[index];
  //
  //         return Text(
  //           "dsadsadas"
  //         );
  //       },
  //     );
  //   }
  //
  //   Widget _buildMetadataView() {
  //     return Center(child: Text('Metadata View'));
  //   }
  //
  //   Widget _buildLiveEventsView() {
  //     return Center(child: Text('Live Events View'));
  //   }
  // }
  //
  //
  // class GaugeData {
  //   final double minSpeed;
  //   final double maxSpeed;
  //   final double speed;
  //   final String unitOfMeasurement;
  //   final DateTime timestamp;
  //   final String displayName;
  //   final String widgetType;
  //
  //   GaugeData({
  //     required this.minSpeed,
  //     required this.maxSpeed,
  //     required this.speed,
  //     required this.unitOfMeasurement,
  //     required this.timestamp,
  //     required this.displayName,
  //     required this.widgetType,
  //   });
  //
  //   // Method to convert timestamp to a formatted date string
  //   String getFormattedDate() {
  //     return '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute}:${timestamp.second}';
  //   }
  // }





  import 'dart:convert';

import 'package:flutter/material.dart';
  import 'package:genaiot/models/live_data.dart';
  import 'package:genaiot/utils/api_calling.dart';
  // import 'package:genaiot/views/assets.dart';
  // import 'package:kdgaugeview/kdgaugeview.dart';
  import 'package:intl/intl.dart';

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
    List<LiveData> gaugeDataList = [];
    List transformedData = [];

    @override
    void initState() {
      super.initState();
      initializeGaugeData();
    }

    Future<void> initializeGaugeData() async {
      try {


        var liveData = await get("/api/live_data/562223bc-25fb-4057-a08a-74c02f1c5326");
        // Process and parse the data
        var data = liveData["data"];

       // List<dynamic> widget_data = await getFromSqllite("widgets");
        List<dynamic> edge_telemetry_model_data = await getFromSqllite("edge_telemetry_model");

        // transformedData = await data.expand((item){
        //   final double timestamp = (item['ts'] as num?)?.toDouble() ?? 0.0;
        //
        //   final dateTime = DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt(), isUtc: true);
        //
        //   // Format the DateTime as a human-readable string
        //   final dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
        //   final formattedDate = dateFormat.format(dateTime);
        //   final Map<String, dynamic> data =
        //       item['data'] as Map<String, dynamic>? ?? {};
        //
        //
        //
        //   print(data.toString()+"safasdasdasdsa");
        //
        //   return data.entries.expand((entry) {
        //     final devId = entry.key;
        //     final metrics = entry.value as Map<String, dynamic>;
        //
        //     return metrics.entries.map((metric) async {
        //       // var dataAll = await getValueByPropertyJsonKey(edge_telemetry_model_data, metric.key.toString(),"property_json_key");
        //       //
        //       // print(dataAll.toString()+"dataAll.toString()");
        //       return {
        //         'devId': devId,
        //         'name': metric.key,
        //         'value': metric.value.toString(),
        //         'ts': formattedDate,
        //         'property_display_name': "dataAll.toString()",
        //         'property_unit': "dataAll.toString()",
        //       };
        //     });
        //   });
        // }).toList();



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
              // Fetch additional data asynchronously
              var dataAll = await getValueByPropertyJsonKey(edge_telemetry_model_data, metric.key.toString(), "property_json_key");

              print(dataAll.toString()+"dataAll.toString");
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

        print("transformedData.to"+transformedData.toString());



        // gaugeDataList = data.map<LiveData>((json) {
        //   return LiveData.fromJson(json);
        // }).toList();
      } catch (e) {
        print('Error fetching data: $e');
        // Handle the error
      } finally {
        setState(() {
          isLoading = false;
        });
      }
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
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Expanded(
              child: _buildSelectedView(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavButton('Metadata', 0),
                _buildNavButton('Live Data', 1),
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
          return _buildMetadataView();
        case 1:
          return _buildLiveDataView();
        case 2:
          return _buildLiveEventsView();
        default:
          return Center(child: Text('Select a View'));
      }
    }

    Widget _buildLiveDataView() {
      return isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 7.0,
          mainAxisSpacing: 7.0,
        ),
        itemCount: transformedData.length,
        itemBuilder: (context, index) {
          final gaugeData = transformedData[index];

          print("gaugeDatagaugeData"+gaugeData.toString());
          return Card(
            color: Colors.white,
            elevation: 30,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(

                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(gaugeData["property_display_name"],
                          textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                          Text('(${gaugeData["property_unit"]})',style: TextStyle(color: Colors.grey[400],fontSize: 15, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(gaugeData["value"],style: TextStyle(fontSize: 48, color: Colors.grey[600], fontWeight: FontWeight.bold),),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        Text(gaugeData["ts"].toString(),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.grey[500]),),
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

    Widget _buildMetadataView() {
      return Center(child: Text('Metadata View'));
    }

    Widget _buildLiveEventsView() {
      return Center(child: Text('Live Events View'));
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
