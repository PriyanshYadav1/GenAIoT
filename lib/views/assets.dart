
// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:genaiot/views/scr_5_asset_stats_representation.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

import '../utils/api_calling.dart';
// import 'app_list.dart';
import 'liveEventsScreen.dart';

class AssetsPage extends StatefulWidget {
  final String appShortCode;

  const AssetsPage({super.key, required this.appShortCode});

  @override
  _AssetsPageState createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  String? appShortCode;
  List<ListItem> allAssets = [];
  List<ListItem> filteredAssets = [];
  String currentAppName = '';
  bool isLoading = true;
  // String errorMessage = '';
  bool errorOccurred = false;

  @override
  void initState() {
    super.initState();
    if (widget.appShortCode.isNotEmpty) {
      currentAppName = widget.appShortCode;
      _fetchAssets(widget.appShortCode);
    }
  }


  Future<void> _fetchAssets(String appShortCode) async {
    setState(() {
      isLoading = true;
       errorOccurred = false;
    });

    const url = '/api/assets';

   // const url = '/api/asset_models';


    print('Fetching assets : $url');


    final response = await get(url);
    print("Received assets: $response");


    if (response['success']) {
      final responseData = response['data'];


      if (responseData != null && responseData.isNotEmpty) {
        List<dynamic> data = responseData is List ? responseData : [];

         final assets = data.map((json) {
          return ListItem.fromJson(json is Map<String, dynamic> ? json : {}, appShortCode);
        }).toList();


        // if (responseData != null && responseData is List) {
        //
        //   for (var asset in responseData) {
        //     if (asset is Map<String, dynamic> && asset.containsKey('short_code')) {
        //       final shortCode = asset['short_code'];
        //       print('Short Code: ${asset['short_code']}');
        //       fetchAssetss(shortCode);
        //     }
        //   }}

        setState(() {
          allAssets = assets;
          filteredAssets = assets;
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
      _showErrorDialog( 'An unknown error occurred.');

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

  // Color _getIconColor(String status) {
  //   switch (status.toLowerCase()) {
  //     case 'connected':
  //       return Colors.green;
  //     case 'disconnected':
  //       return Colors.red;
  //     case 'off':
  //       return Colors.grey;
  //     default:
  //       return Colors.black; // Default color for unknown status
  //   }
  // }

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title:
          //Text(currentAppName.isEmpty ? 'Assets' : currentAppName),
          Text(
            currentAppName.isEmpty ? 'Assets' : currentAppName,
            style: GoogleFonts.inter(
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded,
                color: Color(0xFF616161),
                size: 18.0,
              ),

              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: AssetSearchDelegate(assets: filteredAssets),
                  );
                },
              ),
            ),
          ],
        ),
        // drawer: AppDrawer(),
        body:
        isLoading
            ? const Center(child: CircularProgressIndicator())
            // : errorMessage != null
            // ? Center(
            //   child: SizedBox(
            //
            //     width: MediaQuery.of(context).size.width * 0.5,
            //     height: MediaQuery.of(context).size.height * 0.2,
            //
            //     child: Card(
            //                elevation: 10,
            //     child: Center(child: Text(errorMessage!, style: TextStyle(color: Colors.red), textAlign: TextAlign.center,))),
            //   ),
            // )
           // :
       : ListView.builder(
          itemCount: filteredAssets.length,
          itemBuilder: (context, index) {
            final item = filteredAssets[index];
            return Card(
              color: Colors.white,
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: Icon(item.icon, color: _getIconColor(index)),
                title: Text(item.title),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  String assetId = item.id;
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LiveEventsScreen(title: item.title,assetId: assetId),),);
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

// search functionallity

class AssetSearchDelegate extends SearchDelegate {
  final List<ListItem> assets;

  AssetSearchDelegate({required this.assets});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = assets.where((asset) {
      return asset.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          leading: Icon(item.icon, color: _getIconColor(index)),
          title: Text(item.title),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // Handle tap event
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = assets.where((asset) {
      return asset.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final item = suggestions[index];
        return ListTile(
          leading: Icon(item.icon, color: _getIconColor(index)),
          title: Text(item.title),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            query = suggestions[index].title;
            showResults(context);
          },
        );
      },
    );
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

// //color based on status
//   Color _getIconColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'connected':
//         return Colors.green;
//       case 'disconnected':
//         return Colors.red;
//       case 'off':
//         return Colors.grey;
//       default:
//         return Colors.black; // Default color for unknown status
//     }
//   }
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
// here icons displayed based on appShortCode temporarily.
class AssetIcons {
  static IconData getIcon(String appShortCode) {
    switch (appShortCode) {
      case 'VC-PCMS':
        return Icons.circle;
      case 'GE-CMS':
        return Icons.circle;
      case 'JD-B':
        return Icons.circle;
      case 'S-PWQM':
        return Icons.circle;
      case 'R-SPM':
        return Icons.circle;
      case 'E-PWM':
        return Icons.circle;
      case 'BMI-U':
        return Icons.circle;
      case 'BK-PMS':
        return Icons.circle;
      case 'E-PWM':
        return Icons.circle;
      case 'JLL-SBM':
        return Icons.circle;
      case 'GS-PIM':
        return Icons.circle;
      case 'SS-B':
        return Icons.circle;
      case 'L-SHM':
        return Icons.circle;
      default:
        return Icons.circle;
    }
  }
}

