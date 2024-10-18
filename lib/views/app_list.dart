import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../models/app_model.dart';
import '../utils/DatabaseHelper.dart';
import '../utils/api_calling.dart';
import 'hamburger_menu.dart';
import 'ImageViewer.dart';
import 'assets.dart';
import 'globals.dart' as globals;

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
  bool activityLoader = false;
  bool isFetching = false;

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

    final response22 = await getData(url1, "app-icons/JLL-SBM.png");

    print("response22" + response22);

    print("Received data: $response22");

    if (response['success']) {
      final responseData = response['data'];

      print("Response + $responseData");
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
        _showErrorDialog('No data received from the server!');
      }
    } else {
      setState(() {
        isLoading = false;
        errorOccurred = true;
      });
      _showErrorDialog('An unknown error occurred.');

    }
  }

  Future<void> fetchAssetModels(String appShortCode) async {


    await clearTable("api_data");
    try {
      final response = await get('/api/asset_models');

      if (response['success']) {
        final responseData = await response['data'];
        if (responseData != null && responseData is List) {
          for (var asset in responseData) {
            if (asset is Map<String, dynamic> &&
                asset.containsKey('short_code')) {
              final shortCode = await asset['short_code'];
              print('Short Code: ${asset['short_code']}');
              await fetchAssetss(shortCode);
            }
          }
        }
      } else {
        print('Failed to load asset models');
      }
    } catch (e) {
      print('Error fetching asset models:');
    }
  }

  Future<void> fetchAssetss(String shortCode) async {
    var url2 = await '/api/data_model/' + shortCode;
    var url3 = await '/api/widgets/' + shortCode;

    print('Fetching assets from $url2');

    final response = await get(url2);
    print("Received data assets from URL2: $response");

    final response1 = await get(url3);
    print("Received data assets from URL3: $response1");

    await saveApiToDb(url2, "data_model" + shortCode);

    await saveApiToDb(url3, "widget" + shortCode);
  }

  void _showErrorDialog(String message) {
    // Ensure that the dialog is shown after the widget build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        // Check if the context is still valid
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SizedBox(
              child: AlertDialog(
                elevation: 10,
                title: Text(
                  'Error',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey[900]),
                ),
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = size.width < size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
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
        
       // activityLoader ?
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
                  if (isFetching) {
                    // Show a temporary message or a loading indicator when already fetching
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Loading in progress..."),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return; // Exit early if already fetching
                  }

                    // Proceed with the fetching logic
                    setState(() {
                      isFetching = true;
                      activityLoader = true;
                    });

                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString("appShortCode", app.shortCode);
                    globals.appShortCode =app.shortCode;
                    await fetchAssetModels(app.shortCode);
                    // here we have to store app_shortCode in SharedPreferences and get it in api_calling.dart page globally.

                    // await saveApiToDb("/api/widgets/CNGCOM","widgets");
                    // await saveApiToDb("/api/edge_event_model/CNGCOM","edge_event_model");
                    // await saveApiToDb("/api/edge_telemetry_model/CNGCOM","edge_telemetry_model");

                    Fluttertoast.showToast(
                        msg: app.shortCode,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black12,
                        textColor: Colors.white,
                        fontSize: 16.0);

                  Navigator.push (
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssetsPage(appShortCode: app.shortCode,),
                      // builder: (context) => AssetsPage(),
                    ),
                  );
                  setState(() {
                    activityLoader = false;
                    isFetching = false;
                  });

                },
                child: Card(
                  elevation: 4.0,
                 // shadowColor: Colors.black.withOpacity(1.0),
                  margin: const EdgeInsets.all(5.0),
                  clipBehavior: Clip.antiAlias,
                  semanticContainer: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: SizedBox(
                    width: size.width * 0.7,
                    height: size.height * 0.45,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      width: double.infinity,
                      height: isPortrait
                          ? size.height * 0.16
                          : size.height * 0.8,

                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.6),
                           // spreadRadius: 5,
                           // blurRadius: 10,
                           // offset: Offset(0, 5), // Shadow position
                          ),
                        ],
                      ),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: AspectRatio(
                              //aspectRatio: 16 / 9,
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
        )
        //       :Container(
        //   child: Text("dfdfsdfdsfdsd"),
        // ),
      ),
    );
  }

}

Future<void> clearTable(String s) async {
  final Database db = await DatabaseHelper.instance.database;

  // Execute the DELETE statement
  await db.delete(s);

}

Future<void> saveApiToDb(url, key) async {
  var apiAllData = await get(url);
  final uniqueKey = key;
  final exampleData = {
    DatabaseHelper.columnUniqueKey: uniqueKey,
    DatabaseHelper.columnData: jsonEncode(apiAllData["data"]),
  };

  final existingData = await DatabaseHelper.instance.queryAllRows();
  bool exists = existingData
      .any((row) => row[DatabaseHelper.columnUniqueKey] == uniqueKey);

  print("dsajdlksadljksajdlkasldsa398");
  if (exists) {
    print("dsajdlksadljksajdlkasldsa399");
    // Update the existing record
    await DatabaseHelper.instance.update(uniqueKey, exampleData);
  } else {
    // Insert new record
    print("dsajdlksadljksajdlkasldsa404");
    await DatabaseHelper.instance.insert(exampleData);
  }

}
