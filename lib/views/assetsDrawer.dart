import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'assets.dart';
import 'getConfiguration.dart';
import 'heartbeatWidget.dart';
import 'lifeCycle.dart';
import 'liveEventsScreen.dart';

class AssetDrawer extends StatefulWidget {
  final String title;
  final String assetId;
  final String assetModel;


  const AssetDrawer({
    Key? key,
    required this.title,
    required this.assetId,
    required this.assetModel,
  }) : super(key: key);

  @override
  _AssetDrawerState createState() => _AssetDrawerState();
}

class _AssetDrawerState extends State<AssetDrawer> {

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {

    setState(() {});
  }






  @override
  Widget build(BuildContext context) {



    return Drawer(
      child: Stack(
        children: [
          Container(
            // width: 400,
            color: Colors.blue,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, bottom: 25.0, top: 40.0),

                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Container(
                    height: 1.0,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      ListTile(
                        contentPadding:
                        const EdgeInsets.only(left: 30.0, right: 25.0),
                        leading: const Icon(Icons.home,
                            color: Colors.white, size: 22),
                        title: const Text('Home',
                            style:
                            TextStyle(color: Colors.white, fontSize: 14)),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.white, size: 15),
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LiveEventsScreen(
                                title: widget.title,
                                assetId: widget.assetId,
                                assetModel: widget.assetModel,
                              ),
                            ),
                                (Route<dynamic> route) => false,
                          );
                        },

                      ),
                      ListTile(
                          contentPadding:
                          const EdgeInsets.only(left: 30.0, right: 25.0),
                          leading: const Icon(Icons.app_registration_rounded,
                              color: Colors.white, size: 22),
                          title: const Text('Apps',
                              style:
                              TextStyle(color: Colors.white, fontSize: 14)),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded,
                              color: Colors.white, size: 15),
                          onTap: () {
                           // Navigator.pushAndRemoveUntil(
                             // context,
                              // MaterialPageRoute(
                              // //  builder: (context) => const AppsGrid(),
                              // ),
                              // image is passed as a parameter
                                 // (Route<dynamic> route) => false,
                           // );
                          }),
                      ListTile(
                        contentPadding:
                        const EdgeInsets.only(left: 30.0, right: 25.0),
                        leading: const Icon(Icons.person_outline_rounded,
                            color: Colors.white, size: 22),
                        title: const Text('My Profile',
                            style:
                            TextStyle(color: Colors.white, fontSize: 14)),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.white, size: 15),
                        onTap: () {},
                      ),

                      ListTile(
                        contentPadding:
                        const EdgeInsets.only(left: 30.0, right: 25.0),
                        leading: const Icon(Icons.cloud_queue,
                            color: Colors.white, size: 22),
                        title: const Text('Sites',
                            style:
                            TextStyle(color: Colors.white, fontSize: 14)),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.white, size: 15),
                        onTap: () {},
                      ),
                      ListTile(
                        contentPadding:
                        const EdgeInsets.only(left: 30.0, right: 25.0),
                        leading: const Icon(Icons.confirmation_num_outlined,
                            color: Colors.white, size: 22),
                        title: const Text('Tickets',
                            style:
                            TextStyle(color: Colors.white, fontSize: 14)),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.white, size: 15),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 1.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
