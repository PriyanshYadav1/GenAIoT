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





import 'package:flutter/material.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'dart:convert'; // Required for jsonDecode

class StatRepresentation extends StatefulWidget {
  final String title;

  const StatRepresentation({super.key, required this.title});

  @override
  _StatRepresentationState createState() => _StatRepresentationState();
}

class _StatRepresentationState extends State<StatRepresentation> {
  List<GaugeData> gaugeDataList = [];
  bool isLoading = true;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    initializeGaugeData();
  }

  void initializeGaugeData() {
    gaugeDataList = [
      GaugeData(
        minSpeed: 0,
        maxSpeed: 250,
        speed: 100,
        unitOfMeasurement: "°C",
        timestamp: DateTime.fromMillisecondsSinceEpoch(1724230979 * 1000),
        displayName: "Temperature",
        widgetType: "gauge",
      ),
      GaugeData(
        minSpeed: 0,
        maxSpeed: 250,
        speed: 120,
        unitOfMeasurement: "hPa",
        timestamp: DateTime.fromMillisecondsSinceEpoch(1724230979 * 1000),
        displayName: "Pressure",
        widgetType: "line",
      ),
      GaugeData(
        minSpeed: 0,
        maxSpeed: 250,
        speed: 100,
        unitOfMeasurement: "°C",
        timestamp: DateTime.fromMillisecondsSinceEpoch(1724230979 * 1000),
        displayName: "Temperature",
        widgetType: "gauge",
      ),
      GaugeData(
        minSpeed: 0,
        maxSpeed: 250,
        speed: 120,
        unitOfMeasurement: "hPa",
        timestamp: DateTime.fromMillisecondsSinceEpoch(1724230979 * 1000),
        displayName: "Pressure",
        widgetType: "line",
      ),
    ];
    setState(() {
      isLoading = false;
    });
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
          // Navigation Buttons
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavButton('Metadata', 0),
                _buildNavButton('Live Data', 1),
                _buildNavButton('Live Events', 2),
              ],
            ),
          ),
          Expanded(
            child: _buildSelectedView(),
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
            borderRadius: BorderRadius.circular(17.0),
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
        ? const Center(child: CircularProgressIndicator())
        : GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, // Single column grid
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemCount: gaugeDataList.length,
      itemBuilder: (context, index) {
        final gaugeData = gaugeDataList[index];

        return Card(
          elevation: 55,
          margin: const EdgeInsets.only(left: 25.0, right: 25.0, top: 5),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: gaugeData.widgetType == "gauge"
                        ? KdGaugeView(
                      minSpeed: gaugeData.minSpeed,
                      maxSpeed: gaugeData.maxSpeed,
                      speed: gaugeData.speed,
                      unitOfMeasurement: gaugeData.unitOfMeasurement,
                      animate: true,
                      gaugeWidth: 12,
                      activeGaugeColor: Colors.lightBlue,
                      unitOfMeasurementTextStyle: const TextStyle(
                        fontSize: 20,
                        height: -20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      duration: const Duration(seconds: 1),
                      speedTextStyle: const TextStyle(
                        fontSize: 25,
                        height: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent,
                      ),
                      innerCirclePadding: 8,
                      subDivisionCircleColors: Colors.white,
                      divisionCircleColors: Colors.white,
                      minMaxTextStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    )
                        : Container(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            gaugeData.displayName,
                            style: TextStyle(
                              height: -9,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '(${gaugeData.unitOfMeasurement})',
                            style: TextStyle(
                              fontSize: 16,
                              height: -8,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                              gaugeData.speed.toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),

                        ],
                      ),



                    ),


                  ),
                  if (gaugeData.widgetType == "gauge") ...[
                    const SizedBox(height: 10),
                    Text(
                      gaugeData.displayName,
                      style: const TextStyle(
                        fontSize: 18,
                        height: -3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  Text(
                    'Date: ${gaugeData.getFormattedDate()}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      height: -1,
                    ),
                  ),
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

  // Method to convert timestamp to a formatted date string
  String getFormattedDate() {
    return '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute}:${timestamp.second}';
  }
}

// Function to parse JSON and return a list of GaugeData
List<GaugeData> parseGaugeDataList(String jsonString) {
  final List<dynamic> jsonList = jsonDecode(jsonString);
  return jsonList.map((jsonItem) {
    return GaugeData(
      minSpeed: jsonItem['minSpeed'].toDouble(),
      maxSpeed: jsonItem['maxSpeed'].toDouble(),
      speed: jsonItem['speed'].toDouble(),
      unitOfMeasurement: jsonItem['unitOfMeasurement'],
      displayName: jsonItem['displayName'],
      widgetType: jsonItem['widgetType'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(jsonItem['timestamp'] * 1000), // Convert seconds to milliseconds
    );
  }).toList();
}
