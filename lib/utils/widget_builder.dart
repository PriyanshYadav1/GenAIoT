// import 'package:flutter/material.dart';
// import 'package:kdgaugeview/kdgaugeview.dart';
// import '../models/live_data.dart';
//
// class WidgetBuilder extends StatefulWidget{
//   @override
//   const WidgetBuilder({super.key});
//
//   _WidgetBuilderState createState() =>  _WidgetBuilderState();
//
// }
//
// class _WidgetBuilderState extends State<WidgetBuilder>{
//   bool isLoading = true;
//   List<LiveData> liveDataList = [];
//   @override
//   Widget build(BuildContext context, ) {
//     return _buildLiveDataView();
//   }
//
//
//   Widget _buildSelectedView(LiveData liveDataObject) {
//     switch (liveDataObject.widgetType) {
//       case "label":
//         return _buildMetadataView();
//       case "gauge":
//         return _buildLiveDataView();
//       default:
//         return Center(child: Text('Select a View'));
//     }
//     //if(LiveData.widgetType == "label"){}
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
//       itemCount: liveDataList.length,
//       itemBuilder: (context, index) {
//         final LiveData liveData1 = liveDataList[index];
//
//         return Card(
//           elevation: 55,
//           margin: const EdgeInsets.only(left: 25.0, right: 25.0, top: 5),
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5),
//                 color: Colors.white,
//               ),
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: liveData1.widgetType == "gauge"
//                         ? Container(
//                       height: 270,width: 270,
//                       child: KdGaugeView(
//                         minSpeed: liveData1.minimumValue,
//                         maxSpeed: liveData1.maximumValue,
//                         speed: liveData1.actualValue,
//                         unitOfMeasurement: liveData1.unitOfMeasurement,
//                         animate: true,
//                         gaugeWidth: 15,
//                         activeGaugeColor: Colors.lightBlue,
//                         unitOfMeasurementTextStyle: const TextStyle(
//                             fontSize: 20,
//                             height: -20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.grey
//                         ),
//                         duration: const Duration(seconds: 1),
//                         speedTextStyle: const TextStyle(
//                           fontSize: 25,
//                           height: 2,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.lightBlueAccent,
//                         ),
//                         innerCirclePadding: 11,
//                         subDivisionCircleColors: Colors.white,
//                         divisionCircleColors: Colors.white,
//                         minMaxTextStyle: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.grey
//                         ),
//                       ),
//                     )
//                         : Container(
//
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             liveData1.dataType,
//                             style: TextStyle(
//                               height: -9,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 8.0),
//                           Text(
//                             '(${liveData1.unitOfMeasurement})',
//                             style: TextStyle(
//                               fontSize: 16,
//                               height: -8,
//                               color: Colors.grey[700],
//                             ),
//                           ),
//                           SizedBox(height: 16.0),
//                           Text(
//                             liveData1.actualValue.toString(),
//                             style: TextStyle(
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.blue,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   if (liveData1.widgetType == "gauge") ...[
//                     const SizedBox(height: 10),
//                     Text(
//                       liveData1.dataType,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         height: -3,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                   const SizedBox(height: 10),
//                   Text(
//                     //'Date: ${liveData1.getFormattedDate()}',
//                     'Date: ${liveData1.dateTime}',
//                     style: const TextStyle(
//                       color: Colors.grey,
//                       fontSize: 12,
//                       height: -1,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
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
