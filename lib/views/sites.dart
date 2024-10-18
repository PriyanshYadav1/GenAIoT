import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../utils/DatabaseHelper.dart';
import '../utils/api_calling.dart';
import 'app_list.dart';
import 'assets.dart';
import 'hamburger_menu.dart';
import 'globals.dart' as globals;

class Sites extends StatefulWidget {
  final bool isSite;

  const Sites({super.key, required this.isSite});

  @override
  _SitesState createState() => _SitesState();
}

class _SitesState extends State<Sites> {
  List<ListItem> allSites = [];
  List<ListItem> allFleets = [];
  bool isLoading = true;
  bool errorOccurred = false;
  late String? title;
  late String? display_name;
  late String? _appShortCode;

  @override
  void initState() {
    super.initState();
    _appShortCode = globals.appShortCode;

    if (widget.isSite) {
      title = "Sites";
      print("App Short Code: $_appShortCode"); // Debugging line
      if (_appShortCode != null && _appShortCode!.isNotEmpty) {
        _fetchSites(_appShortCode!, widget.isSite);
      } else {
        _showErrorDialog(
            'App Short Code Is Not Available. Please Select An App First');
      }
    }
  }

  //method to fetch site wise data /////////////////////////////////////////////
  // Future<void> fetchSiteData(String shortCode) async {
  //   var url2 = await '/api/data_model/' + shortCode;
  //   var url3 = await '/api/widgets/' + shortCode;
  //
  //   print('Fetching assets from $url2');
  //
  //   final response = await get(url2);
  //   print("Received data assets from URL2: $response");
  //
  //   final response1 = await get(url3);
  //   print("Received data assets from URL3: $response1");
  //
  //   await saveApiToDb(url2, "data_model" + shortCode);
  //
  //   await saveApiToDb(url3, "widget" + shortCode);
  // }

// method to fetch all sites ////////////////////////////////////////////
  Future<void> _fetchSites(String appShortCode, bool isSite) async {
    setState(() {
      isLoading = true;
      errorOccurred = false;
    });

    const url = '/api/sites';
    print('Fetching assets : $url');

    final response = await get(url);
    print("Received sites: $response");

    if (response != null && response['success']) {
      final responseData = response['data'];

      if (responseData != null && responseData.isNotEmpty) {
        List<dynamic> data = responseData is List ? responseData : [];

        final sites = data.map((json) {
          return ListItem.fromJson(
              json is Map<String, dynamic> ? json : {}, appShortCode);
        }).toList();

        setState(() {
          allSites = sites;
          //filteredAssets = assets;
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
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AppsGrid(),
                        ),
                        // image is passed as a parameter
                        (Route<dynamic> route) => false,
                      );
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

  // In the _getIconColor method, a static status is assigned based on the index of the item. This method cycles through three colors to simulate different statuses.
  Color _getIconColor(int index) {
    // Static logic to assign status colors based on the index
    switch (index % 3) {
      case 0:
        return Colors.green; // Simulate "connected"
      case 1:
        return Colors.red; // Simulate "disconnected"
      case 2:
        return Color(0xFF808080); // Simulate "off"
      default:
        return Colors.black; // Default color
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          leading: Builder(
            builder: (context) => Row(
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
          title: const Text(
            'Sites',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        drawer: AppDrawer(),
        //drawer: AppDrawer(),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: allSites.length,
                itemBuilder: (context, index) {
                  final item = allSites[index];
                  return Card(
                    color: Colors.white,
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      //leading: Icon(item.icon, color: _getIconColor(index)),
                      title: Text(item.title),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        String assetId = item.id;
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> LiveEventsScreen(title: item.title,assetId: assetId),),);
                        // navigating to a detail page
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}

// In the _getIconColor method, a static status is assigned based on the index of the item. This method cycles through three colors to simulate different statuses.
Color _getIconColor(int index) {
  // Static logic to assign status colors based on the index
  switch (index % 3) {
    case 0:
      return Colors.green; // Simulate "connected"
    case 1:
      return Colors.red; // Simulate "disconnected"
    case 2:
      return Color(0xFF808080); // Simulate "off"
    default:
      return Colors.black; // Default color
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

class ListItem {
  final String title;
  final IconData icon;
  final String index;
  final String id;

  ListItem({required this.title, required this.icon, required this.index, required this.id});

  factory ListItem.fromJson(Map<String, dynamic> json, String appShortCode) {
    return ListItem(
      id: json['id'] as String,
      title: json['display_name'] as String,
      icon: AssetIcons.getIcon(appShortCode), // Set icon based on appShortCode
      index: json['index'] as String? ?? 'unknown', // Default to 'unknown' if status is missing
    );
  }
}