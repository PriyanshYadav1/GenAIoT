// import 'package:flutter/material.dart';
// import 'hamburger_menu.dart';
// import '../models/app_model.dart';
// import 'assets.dart';
//
// class AppsGrid extends StatefulWidget {
//   const AppsGrid({super.key});
//
//   @override
//   State<AppsGrid> createState() => _AppsGridState();
// }
//
// class _AppsGridState extends State<AppsGrid> {
//   final List<App> apps = [
//     App(name: "Compressor Monitoring System", imageUrl: "https://cdn.pixabay.com/photo/2019/11/28/16/04/pump-4659468_640.jpg"),
//     App(name: "Police Car Monitoring System", imageUrl: "https://cdn.pixabay.com/photo/2024/03/01/14/10/ai-generated-8606642_1280.png"),
//     App(name: "Industrial Blenders", imageUrl: "https://cdn.pixabay.com/photo/2023/07/17/18/33/ai-generated-8133280_640.png"),
//     App(name: "Bulldozer", imageUrl: "https://cdn.pixabay.com/photo/2017/04/02/09/08/bulldozer-2195329_1280.jpg"),
//     App(name: "Pond Water Quality Monitoring", imageUrl: "https://cdn.pixabay.com/photo/2015/03/26/18/44/space-center-693251_640.jpg"),
//     App(name: "Swimming Pool Monitoring", imageUrl: "https://cdn.pixabay.com/photo/2015/07/10/15/01/water-839313_640.jpg"),
//     App(name: "Pressure Washer Monitoring", imageUrl: "https://cdn.pixabay.com/photo/2018/01/26/15/59/pressure-gauge-3109005_640.jpg"),
//     App(name: "Utilities", imageUrl: "https://cdn.pixabay.com/photo/2015/01/21/11/13/power-606592_640.jpg"),
//   App(name: "Pump Monitoring System", imageUrl: "https://cdn.pixabay.com/photo/2014/04/07/04/46/pump-318331_640.jpg"),
//   App(name: "Smart Building Management", imageUrl: "https://cdn.pixabay.com/photo/2022/05/22/17/22/building-7214070_1280.jpg"),
//   App(name: "Predictive Maintenance", imageUrl: "https://cdn.pixabay.com/photo/2015/07/11/14/53/plumbing-840835_640.jpg"),
//
//   App(name: "Home Security Monitoring", imageUrl: "https://cdn.pixabay.com/photo/2022/06/17/09/50/cctv-surveillance-camera-7267551_640.jpg")
//   ];
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           leadingWidth: 100,
//           leading: Builder(
//             builder: (context) => Row(
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.menu),
//                   onPressed: () {
//                     Scaffold.of(context).openDrawer();
//                   },
//                 ),
//                 // const Expanded(
//                 //   child: Padding(
//                 //     padding: EdgeInsets.only(left: 8.0),
//                 //     child: CircleAvatar(
//                 //       radius: 100,
//                 //       backgroundImage: NetworkImage(
//                 //         'https://example.com/profile_image.jpg',
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//           title: const Text('Apps'), centerTitle: true,
//         ),
//         drawer: AppDrawer(),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 5.0,
//               mainAxisSpacing: 5.0,
//             ),
//             itemCount: apps.length,
//             itemBuilder: (context, index) {
//               final app = apps[index];
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => AssetsPage(appName: app.name,),
//                     ),
//                   );
//                 },
//                 child: Card(
//                   elevation: 30.0,
//
//                   shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                   ),
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width*0.7,
//                     height: MediaQuery.of(context).size.height*0.25,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(15.0),
//                           child: AspectRatio(
//                             aspectRatio: 16/12,
//                             child: Image.network(
//                               app.imageUrl,
//                               fit: BoxFit.cover,
//                              width: double.infinity,
//                              height: MediaQuery.of(context).size.height*0.25,
//                              //  height: 170,
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             app.name,
//                             style: const TextStyle(fontSize: 16.0),
//                             overflow: TextOverflow.ellipsis,
//                             maxLines: 1,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }







import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_model.dart';
import '../utils/DatabaseHelper.dart';
import '../utils/api_calling.dart';
import 'hamburger_menu.dart';
import 'ImageViewer.dart';
import 'assets.dart';


class AppsGrid extends StatefulWidget {
  const AppsGrid({super.key});

  @override
  State<AppsGrid> createState() => _AppsGridState();
}


class MyHttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _inner.send(request);
  }

  @override
  void close() {
    _inner.close();
  }
}
class _AppsGridState extends State<AppsGrid> {

  List<App> apps = [];
  App? selectedApp;
  bool isLoading = false;
  String? errorMessage;
  bool errorOccurred = false;


  @override
  void initState() {
    super.initState();
    fetchApps();
  }


  Future<void> fetchApps() async {
    setState(() {
      isLoading = true;
      errorOccurred = false; // Reset error flag
    });

    const url = '/api/applications';
    print("${url}dsahdjsahdkjsa");

    const url1 = '/api/get_app_icon';
    final response = await get(url);


    final response22 = await getData(url1,"app-icons/JLL-SBM.png");


    print("response22"+response22);

    print("Received data: $response22");

    if (response['success']) {
      final responseData = response['data'];

      if (responseData != null) {
        List<dynamic> data = responseData is List ? responseData : [];
        setState(() {
          apps = data.map((json) {
            return App.fromJson(json is Map<String, dynamic> ? json : {});
          }).toList();
          selectedApp = apps.isNotEmpty ? apps[0] : null;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorOccurred = true;
        });
        _showErrorDialog('No data received!');
      }
    } else {
      setState(() {
        isLoading = false;
        errorOccurred = true;
      });
      _showErrorDialog(response['message'] ?? 'An unknown error occurred.');

    }
  }

  void _showErrorDialog(String message) {
    // Ensure that the dialog is shown after the widget build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) { // Check if the context is still valid
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              child: AlertDialog(
                elevation: 10,
                title: Text('Error',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[900]),),
                content: Text(message),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ],
              ),
            );
          },
        );
      }
    });
  }

  //
  // Future<void> fetchApps() async {
  //   setState(() {
  //     isLoading = true;
  //     errorMessage = null;
  //   });
  //
  //   final url = '/api/applications';
  //   print(url+"dsahdjsahdkjsa");
  //   try {
  //     final data = await get(url);
  //     print("Received data: $data");
  //
  //     if (data != null) {
  //       List<dynamic> responseData = data is List ? data : [];
  //       setState(() {
  //         apps = responseData.map((json) {
  //           return App.fromJson(
  //               json is Map<String, dynamic> ? json : {}
  //           );
  //         }).toList();
  //         selectedApp = apps.isNotEmpty ? apps[0] : null;
  //         isLoading = false;
  //       });
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //         errorMessage = 'No data received from server.';
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //       errorMessage = 'Error during HTTP request: $e';
  //     });
  //   }
  // }


  // void _onAppSelected(App app) {
  //   setState(() {
  //     selectedApp = app;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          leading: Builder(
            builder: (context) =>
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ],
                ),
          ),
          title: const Text('Apps', style: TextStyle(fontWeight: FontWeight.bold),), centerTitle: true,
        ),
        drawer: AppDrawer(),
        body:
        // apps.isEmpty ?
        // const Center(child: CircularProgressIndicator())
        //     :
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
            ),
            itemCount: apps.length,
            itemBuilder: (context, index) {
              final app = apps[index];
              return GestureDetector(
                onTap: () async {

                  // here we have to store app_shortCode in SharedPreferences and get it in api_calling.dart page globally.
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString("appShortCode", app.shortCode);
                  await saveApiToDb("/api/widgets/CNGCOM","widgets");
                  await saveApiToDb("/api/edge_telemetry_model/CNGCOM","edge_telemetry_model");


                  Fluttertoast.showToast(
                      msg: app.shortCode,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black12,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssetsPage(appShortCode: app.shortCode,),
                      // builder: (context) => AssetsPage(),
                    ),
                  );

                },
                child: Card(
                  elevation: 50.0,
                  shadowColor: Colors.black.withOpacity(1.0),
                  margin: const EdgeInsets.all(5.0), // Margin around the card
                  clipBehavior: Clip.antiAlias,
                  semanticContainer: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.7,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.25,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.2,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.15,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.6),
                            spreadRadius: 5,
                           // blurRadius: 10,
                           // offset: Offset(0, 5), // Shadow position
                          ),
                        ],
                      ),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: AspectRatio(
                              aspectRatio: 18 / 12,
                              child: Base64Image(
                                apiUrl: '/api/get_app_icon',
                                filePath: app.iconUri,
                              ),
                            ),
                          ),
                            // Image.network(
                            //   app.iconUri,
                            //   fit: BoxFit.cover,
                            //   width: double.infinity,
                            //   height: MediaQuery
                            //       .of(context)
                            //       .size
                            //       .height * 0.25,
                            //   errorBuilder: (context, error, stackTrace) {
                            //     // Placeholder image if the network image fails
                            //     return Image.network(
                            //       'https://cdn.pixabay.com/photo/2024/03/01/14/10/ai-generated-8606642_1280.png',
                            //       fit: BoxFit.cover,);
                            //
                            //   },
                            //   //  height: 170,
                            // ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              app.displayName,
                              style: const TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}

Future<void> saveApiToDb(url,key) async {

  var apiAllData = await get(url);
  final uniqueKey = key;
  final exampleData = {
    DatabaseHelper.columnUniqueKey: uniqueKey,
    DatabaseHelper.columnData: jsonEncode(apiAllData["data"]),
  };

  final existingData = await DatabaseHelper.instance.queryAllRows();
  bool exists = existingData.any((row) => row[DatabaseHelper.columnUniqueKey] == uniqueKey);

  if (exists) {
    // Update the existing record
    await DatabaseHelper.instance.update(uniqueKey, exampleData);
  } else {
    // Insert new record
    await DatabaseHelper.instance.insert(exampleData);
  }

}
