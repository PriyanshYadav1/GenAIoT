import 'package:flutter/material.dart';
import 'package:kdgaugeview/kdgaugeview.dart';

class StatRepresentation extends StatefulWidget {
  final String title;

  const StatRepresentation({super.key, required this.title});

  Widget build(BuildContext context) {
    return MaterialApp(
      home: StatRepresentation(
        title: title,
        // appBar: AppBar(
        //   title: Text(title),
        // ),
      ),
    );
  }

  @override
  _RepresentationState createState() => _RepresentationState();
}

class _RepresentationState extends State<StatRepresentation> {
  @override
  Widget build(BuildContext context) {
    bool isPressed = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            const SizedBox(width: double.infinity, height: 20),
            const Row(
              children: <Widget>[
                SizedBox(width: 20),
                SizedBox(width: 20),
                SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 3, width: double.infinity),
            Container(
              //alignment: AlignmentDirectional(-0.65,0),
              child: Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Expanded(
                        child: Stack(
                      fit: StackFit.loose,
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        // const CircleAvatar(
                        //   backgroundColor: Colors.red,
                        //   foregroundColor: Colors.red,
                        //   radius: 80
                        // ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.2, color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          padding: const EdgeInsetsDirectional.all(20),
                          //color: Colors.white,
                          height: 250,
                          width: 250,
                          //foregroundDecoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.red.shade200,spreadRadius: 1,blurRadius: 0,offset: Offset(0, 0))]),
                          child: KdGaugeView(
                            minSpeed: 0,
                            maxSpeed: 232,
                            animate: true,
                            gaugeWidth: 12,
                            activeGaugeColor: Colors.lightBlue,
                            speed: 100,
                            // child: Column(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: <Widget>[
                            //     CircleAvatar(
                            //         backgroundColor: Colors.grey,
                            //         radius: 50
                            //     )
                            //   ],
                            // ),
                            duration: const Duration(seconds: 1),
                            unitOfMeasurement: "PSI",
                            unitOfMeasurementTextStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: -14,
                              color: Colors.grey,
                            ),
                            speedTextStyle: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                height: 2,
                                color: Colors.lightBlueAccent),
                            innerCirclePadding: 8,
                            subDivisionCircleColors: Colors.white,
                            divisionCircleColors: Colors.white,
                            //inactiveGaugeColor: Colors.white,
                            minMaxTextStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: -8,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: Stack(
                      fit: StackFit.loose,
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        // const CircleAvatar(
                        //   backgroundColor: Colors.red,
                        //   foregroundColor: Colors.red,
                        //   radius: 80
                        // ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.2, color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          padding: const EdgeInsetsDirectional.all(20),
                          //color: Colors.white,
                          height: 250,
                          width: 250,
                          //foregroundDecoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.red.shade200,spreadRadius: 1,blurRadius: 0,offset: Offset(0, 0))]),
                          child: KdGaugeView(
                            minSpeed: 0,
                            maxSpeed: 232,
                            animate: true,
                            gaugeWidth: 12,
                            activeGaugeColor: Colors.lightBlue,
                            speed: 100,
                            // child: Column(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: <Widget>[
                            //     CircleAvatar(
                            //         backgroundColor: Colors.grey,
                            //         radius: 50
                            //     )
                            //   ],
                            // ),
                            duration: const Duration(seconds: 1),
                            unitOfMeasurement: "F",
                            unitOfMeasurementTextStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: -14,
                              color: Colors.grey,
                            ),
                            speedTextStyle: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                height: 2,
                                color: Colors.lightBlueAccent),
                            innerCirclePadding: 8,
                            subDivisionCircleColors: Colors.white,
                            divisionCircleColors: Colors.white,
                            //inactiveGaugeColor: Colors.white,
                            minMaxTextStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                height: -8,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Hours",
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey.shade600)),
                      trailing: const Text("12570 Hours",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Hours Left To Service",
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey.shade600)),
                      trailing: const Text("2430 Hours",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Voltage",
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey.shade600)),
                      trailing: const Text("472Ac-482AC/665DC",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Hours",
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey.shade600)),
                      trailing: const Text("12570 Hours",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Hours Left To Service",
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey.shade600)),
                      trailing: const Text("2430 Hours",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Voltage",
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey.shade600)),
                      trailing: const Text("472Ac-482AC/665DC",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Average Frequency",
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey.shade600)),
                      trailing: const Text("12570 Hours",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Voltage",
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey.shade600)),
                      trailing: const Text("472Ac-482AC/665DC",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Hours",
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey.shade600)),
                      trailing: const Text("12570 Hours",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Hours Left To Service",
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey.shade600)),
                      trailing: const Text("2430 Hours",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Voltage",
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey.shade600)),
                      trailing: const Text("472Ac-482AC/665DC",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Hours",
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey.shade600)),
                      trailing: const Text("12570 Hours",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Hours Left To Service",
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey.shade600)),
                      trailing: const Text("2430 Hours",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Voltage",
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey.shade600)),
                      trailing: const Text("472Ac-482AC/665DC",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Average Frequency",
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey.shade600)),
                      trailing: const Text("12570 Hours",
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 0,
                child: Row(
                  children: [
                    const SizedBox(width: 13.5),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isPressed
                            ? Colors.grey.shade500
                            : Colors.grey.shade300,
                        elevation: isPressed ? 8 : 2,
                      ),
                      onPressed: () {
                        setState(() {
                          isPressed = !isPressed; // Toggle the pressed state
                        });
                        // Your onPressed action goes here
                      },
                      child: const Text(
                        'MetaData',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300),
                      onPressed: () {},
                      child: const Text(
                        'Live Data',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300),
                      onPressed: () {},
                      child: const Text(
                        'Live Action',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 10)
                  ],
                )),
            const SizedBox(height: 10, width: double.infinity)
          ],
        ),
      ),
    );
  }
}
