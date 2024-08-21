import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kdgaugeview/kdgaugeview.dart';
import 'assets.dart';



class StatRepresentation extends StatefulWidget {
  final String title;
  StatRepresentation({required this.title});

  Widget build(BuildContext context) {
    return MaterialApp(
      home: StatRepresentation(title: title,
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
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(width: double.infinity,height: 20),
            Row(
              children: <Widget>[
                SizedBox(width: 20),
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
                          decoration: BoxDecoration(border:Border.all(width: 1.2,color: Colors.grey.shade300),borderRadius: BorderRadius.circular(5),color: Colors.white),
                          padding: EdgeInsetsDirectional.all(20),
                          //color: Colors.white,
                          height: 200,
                          width: 200,
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
                            duration: Duration(seconds: 1),
                            unitOfMeasurement: "PSI",
                            unitOfMeasurementTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,height: -10,color: Colors.grey,),
                            speedTextStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,height: 2,color: Colors.lightBlueAccent),
                            innerCirclePadding: 7,
                            subDivisionCircleColors: Colors.white,
                            divisionCircleColors: Colors.white,
                            //inactiveGaugeColor: Colors.white,
                            minMaxTextStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,height: -8,color: Colors.grey),
                          ),
                        ),
                      ],
                    )
                ),
                SizedBox(width: 20),

                Expanded(
                  child: Container(
                    decoration: BoxDecoration(border:Border.all(width: 1.2,color: Colors.grey.shade300,),borderRadius: BorderRadius.circular(5),color: Colors.white),
                    padding: EdgeInsetsDirectional.all(20),
                    //color: Colors.white,
                    height: 200,
                    width: 200,
                    child: KdGaugeView(
                      minSpeed: 104,
                      maxSpeed: 302,
                      animate: true,
                      gaugeWidth: 12,
                      activeGaugeColor: Colors.lightBlue,
                      speed: 167,
                      duration: Duration(seconds: 1),
                      unitOfMeasurement: "F",
                      unitOfMeasurementTextStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,height: -10,color: Colors.grey,),
                      speedTextStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,height: 2,color: Colors.lightBlueAccent),
                      innerCirclePadding: 7,
                      subDivisionCircleColors: Colors.white,
                      divisionCircleColors: Colors.white,
                      //inactiveGaugeColor: Colors.white,
                      minMaxTextStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,height: -8,color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 3,width: double.infinity),
            Container(
              //alignment: AlignmentDirectional(-0.65,0),
              child: Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Hours",style: TextStyle(fontSize: 17,color: Colors.grey.shade600)),
                      trailing: Text("12570 Hours",style: TextStyle(fontSize: 17,color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Hours Left To Service",style: TextStyle(fontSize: 17,color: Colors.grey.shade600)),
                      trailing: Text("2430 Hours",style: TextStyle(fontSize: 17,color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Voltage",style: TextStyle(fontSize: 17,color: Colors.grey.shade600)),
                      trailing: Text("472Ac-482AC/665DC",style: TextStyle(fontSize: 17,color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Hours",style: TextStyle(fontSize: 17,color: Colors.grey.shade600)),
                      trailing: Text("12570 Hours",style: TextStyle(fontSize: 17,color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Hours Left To Service",style: TextStyle(fontSize: 17,color: Colors.grey.shade600)),
                      trailing: Text("2430 Hours",style: TextStyle(fontSize: 17,color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Voltage",style: TextStyle(fontSize: 17,color: Colors.grey.shade600)),
                      trailing: Text("472Ac-482AC/665DC",style: TextStyle(fontSize: 17,color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Average Frequency",style: TextStyle(fontSize: 17,color: Colors.grey.shade600)),
                      trailing: Text("12570 Hours",style: TextStyle(fontSize: 17,color: Colors.black)),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 30.0, right: 30.0),
                      leading: Text("Voltage",style: TextStyle(fontSize: 17,color: Colors.grey.shade600)),
                      trailing: Text("472Ac-482AC/665DC",style: TextStyle(fontSize: 17,color: Colors.black)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 0,
                child: Row(
                  children: [
                    SizedBox(width: 13.5),
                    ElevatedButton(
                      child: Text('MetaData',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300
                      ),
                      onPressed: () {
                        //setState((){})
                      },
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      child: Text('Live Data',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      child: Text('Live Action',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(width: 10)
                  ],
                )
            ),
            SizedBox(height: 10,width: double.infinity)
          ],
        ),
      ),
    );
  }
}

