//
// import 'package:flutter/material.dart';
// import '../models/assets_model.dart';
// import 'scr_5_asset_stats_representation.dart';
// import '../controllers/asset_search.dart';
// // import 'hamburger_menu.dart';
//
// enum AssetStatus { connected, disconnected, off }
//
// class AssetsPage extends StatefulWidget {
//
//   final String appName;
//   const AssetsPage({super.key, required this.appName});
//
//
//   @override
//   _AssetsPageState createState() => _AssetsPageState();
// }
//
// class _AssetsPageState extends State<AssetsPage> {
//
// // List of assets to be displayed in the list
//   List<ListItem> assets = [
//     ListItem(title: 'Police Car Monitoring System 1', icon: Icons.directions_car, status: AssetStatus.connected),
//     ListItem(title: 'Police Car Monitoring System 2', icon: Icons.directions_car, status: AssetStatus.disconnected),
//     ListItem(title: 'Police Car Monitoring System 3', icon: Icons.directions_car, status: AssetStatus.off),
//     ListItem(title: 'Police Car Monitoring System 4', icon: Icons.directions_car, status: AssetStatus.connected),
//     // ListItem(title: 'Bulldozer Asset 1', icon: Icons.directions_subway, status: AssetStatus.connected),
//     // ListItem(title: 'Bulldozer Asset 2', icon: Icons.directions_subway, status: AssetStatus.disconnected),
//     // ListItem(title: 'Bulldozer Asset 3', icon: Icons.directions_subway, status: AssetStatus.off),
//     // ListItem(title: 'Bulldozer Asset 4', icon: Icons.directions_subway, status: AssetStatus.connected),
//     // ListItem(title: 'Home Security Monitoring 1', icon: Icons.home, status: AssetStatus.connected),
//     // ListItem(title: 'Home Security Monitoring 2', icon: Icons.home, status: AssetStatus.disconnected),
//     ListItem(title: 'Police Car Monitoring System 5', icon: Icons.directions_car, status: AssetStatus.off),
//     ListItem(title: 'Police Car Monitoring System 6', icon: Icons.directions_car, status: AssetStatus.connected),
//     ListItem(title: 'Police Car Monitoring System 7', icon: Icons.directions_car, status: AssetStatus.connected),
//     ListItem(title: 'Police Car Monitoring System 8', icon: Icons.directions_car,status: AssetStatus.disconnected),
//     ListItem(title: 'Police Car Monitoring System 9', icon: Icons.directions_car,status: AssetStatus.connected),
//     ListItem(title: 'Police Car Monitoring System 10', icon: Icons.directions_car,status: AssetStatus.off),
//
//
//     ListItem(title: 'Industrial Blenders 1', icon: Icons.blender, status: AssetStatus.connected),
//     ListItem(title: 'Industrial Blenders 2', icon: Icons.blender, status: AssetStatus.disconnected),
//     ListItem(title: 'Industrial Blenders 3', icon: Icons.blender, status: AssetStatus.connected),
//     ListItem(title: 'Industrial Blenders 4', icon: Icons.blender, status: AssetStatus.off),
//     ListItem(title: 'Industrial Blenders 5', icon: Icons.blender, status: AssetStatus.connected),
//     ListItem(title: 'Industrial Blenders 6', icon: Icons.blender, status: AssetStatus.off),
//     ListItem(title: 'Industrial Blenders 7', icon: Icons.blender, status: AssetStatus.connected),
//     ListItem(title: 'Industrial Blenders 8', icon: Icons.blender, status: AssetStatus.disconnected),
//     ListItem(title: 'Industrial Blenders 9', icon: Icons.blender, status: AssetStatus.connected),
//     ListItem(title: 'Industrial Blenders 10', icon: Icons.blender, status: AssetStatus.connected),
//
//
//     ListItem(title: 'Compressor Monitoring System 1', icon: Icons.compress, status: AssetStatus.off),
//     ListItem(title: 'Compressor Monitoring System 2', icon: Icons.compress, status: AssetStatus.disconnected),
//     ListItem(title: 'Compressor Monitoring System 3', icon: Icons.compress, status: AssetStatus.connected),
//     ListItem(title: 'Compressor Monitoring System 4', icon: Icons.compress, status: AssetStatus.disconnected),
//     ListItem(title: 'Compressor Monitoring System 5', icon: Icons.compress, status: AssetStatus.connected),
//     ListItem(title: 'Compressor Monitoring System 6', icon: Icons.compress, status: AssetStatus.connected),
//     ListItem(title: 'Compressor Monitoring System 7', icon: Icons.compress, status: AssetStatus.off),
//     ListItem(title: 'Compressor Monitoring System 8', icon: Icons.compress, status: AssetStatus.connected),
//     ListItem(title: 'Compressor Monitoring System 9', icon: Icons.compress, status: AssetStatus.disconnected),
//     ListItem(title: 'Compressor Monitoring System 10', icon: Icons.compress, status: AssetStatus.connected),
//
//     // ListItem(title: 'Pond Water Quality Monitoring 1', icon: Icons.directions_car, status: AssetStatus.off),
//     // ListItem(title: 'Pond Water Quality Monitoring 2', icon: Icons.directions_car, status: AssetStatus.connected),
//     // ListItem(title: 'Swimming Pool Monitoring 1', icon: Icons.directions_car,status: AssetStatus.connected),
//     // ListItem(title: 'Swimming Pool Monitoring 2', icon: Icons.directions_car,status: AssetStatus.connected),
//     // ListItem(title: 'Pressure Washer Monitoring 1', icon: Icons.home, status: AssetStatus.connected),
//     // ListItem(title: 'Pressure Washer Monitoring 2', icon: Icons.home, status: AssetStatus.disconnected),
//     // ListItem(title: 'Utilities 1', icon: Icons.directions_car, status: AssetStatus.off),
//     // ListItem(title: 'Utilities 2', icon: Icons.directions_car, status: AssetStatus.connected),
//     // ListItem(title: 'Pump Monitoring System 1', icon: Icons.directions_car,status: AssetStatus.connected),
//     // ListItem(title: 'Pump Monitoring System 2', icon: Icons.directions_car,status: AssetStatus.connected),
//   ];
//
//   List<ListItem> filteredAssets = [];
//
//
//   @override
//   void initState() {
//     super.initState();
//     _filterAssets(widget.appName);
//   }
//
//   void _filterAssets(String appName) {
//     setState(() {
//       filteredAssets = assets .where((asset) {
//         return asset.title.toLowerCase().contains(appName.toLowerCase());
//       }).toList();
//       filteredAssets ??= [];
//     });
//   }
//
//   Color _getIconColor(AssetStatus status) {
//     switch (status) {
//       case AssetStatus.connected:
//         return Colors.green;
//       case AssetStatus.disconnected:
//         return Colors.red;
//       case AssetStatus.off:
//         return Colors.grey;
//       default:
//         return Colors.black;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // leadingWidth: 100,
//         // leading: Builder(
//         //   builder: (context) => Row(
//         //     children: [
//         //       IconButton(
//         //         icon: const Icon(Icons.menu),
//         //         onPressed: () {
//         //           Scaffold.of(context).openDrawer();
//         //         },
//         //       ),
//         //       Expanded(
//         //         child: Padding(
//         //           padding: const EdgeInsets.only(left: 8.0),
//         //           child: CircleAvatar(
//         //             radius: 100,
//         //             backgroundImage: AssetImage(widget.image),
//         //           ),
//         //         ),
//         //       ),
//         //     ],
//         //   ),
//         // ),
//         title: Text(widget.appName,
//           style: const TextStyle(fontWeight: FontWeight.bold),),
//
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 5.0),
//             child: IconButton(
//               icon: const Icon(Icons.search),
//               onPressed: () {
//                 showSearch(
//                   context: context,
//                   delegate: AssetSearchDelegate(assets: filteredAssets),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       // drawer: AppDrawer(),
//       body:
//       ListView.builder(
//         itemCount: filteredAssets.length,
//         itemBuilder: (context, index) {
//           final item = filteredAssets[index];
//           return
//             Card(
//               elevation: 10.0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: ListTile(
//               leading: Icon(item.icon, color: _getIconColor(item.status)),
//               title: Text(item.title),
//               trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 20,),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => StatRepresentation(title: item.title ),), // image is passed as a parameter
//                     );
//                   }
//                         ),
//             );
//         },
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

import '../utils/api_calling.dart';

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
  String errorMessage = '';


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
      isLoading = true; // Start loading
      errorMessage = 'null';
    });

    final url = '/api/assets';
    print('Fetching assets from $url');

    try {
      final responseBody = await get(url);
      print('Response Body: $responseBody');

      if (responseBody != null) {
        List<dynamic> data = responseBody is List ? responseBody : [];

        print("Data Type: ${data.runtimeType}"); // Should be List<dynamic>
        print("Data Content: $data"); // Print the contents of 'data'
        print("Data in toString: ${data.toString()}"); // Print data as string

        final assets = data.map((json) {

          return ListItem.fromJson(json is Map<String, dynamic> ? json : {}, appShortCode);
        }).toList();

        setState(() {
          allAssets = assets;
          filteredAssets = assets;
          isLoading = false; // End loading
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'No data received from server.'; // Handle empty response
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error during HTTP request: $e'; // Handle any errors
      });
    }
  }




  // void _showError(String message) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Error'),
  //       content: Text(message),
  //       actions: [
  //         TextButton(
  //           child: const Text('OK'),
  //           onPressed: () => Navigator.of(context).pop(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Color _getIconColor(String status) {
    switch (status.toLowerCase()) {
      case 'connected':
        return Colors.green;
      case 'disconnected':
        return Colors.red;
      case 'off':
        return Colors.grey;
      default:
        return Colors.black; // Default color for unknown status
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(currentAppName.isEmpty ? 'Assets' : currentAppName),
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
        body: allAssets.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: filteredAssets.length,
          itemBuilder: (context, index) {
            final item = filteredAssets[index];
            return Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: Icon(item.icon, color: _getIconColor(item.status)),
                title: Text(item.title),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> StatRepresentation(title: item.title),),);
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
          leading: Icon(item.icon, color: _getIconColor(item.status)),
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
          leading: Icon(item.icon, color: _getIconColor(item.status)),
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

//color based on status
  Color _getIconColor(String status) {
    switch (status.toLowerCase()) {
      case 'connected':
        return Colors.green;
      case 'disconnected':
        return Colors.red;
      case 'off':
        return Colors.grey;
      default:
        return Colors.black; // Default color for unknown status
    }
  }
}

class ListItem {
  final String title;
  final IconData icon;
  final String status;

  ListItem({required this.title, required this.icon, required this.status});

  factory ListItem.fromJson(Map<String, dynamic> json, String appShortCode) {
    return ListItem(
      title: json['display_name'] as String,
      icon: AssetIcons.getIcon(appShortCode), // Set icon based on appShortCode
      status: json['status'] as String? ?? 'unknown', // Default to 'unknown' if status is missing
    );
  }
}
// here icons displayed based on appShortCode temporarily.
class AssetIcons {
  static IconData getIcon(String appShortCode) {
    switch (appShortCode) {
      case 'VC-PCMS':
        return Icons.local_police;
      case 'GE-CMS':
        return Icons.directions_car;
      case 'JD-B':
        return Icons.directions_railway;
      case 'S-PWQM':
        return Icons.water_outlined;
      case 'R-SPM':
        return Icons.water_damage_outlined;
      case 'E-PWM':
        return Icons.precision_manufacturing;
      case 'BMI-U':
        return Icons.build;
      case 'BK-PMS':
        return Icons.heat_pump_outlined;
      case 'E-PWM':
        return Icons.precision_manufacturing;
      case 'JLL-SBM':
        return Icons.home_work;
      case 'GS-PIM':
        return Icons.manage_accounts;
      case 'SS-B':
        return Icons.backup_table;
      case 'L-SHM':
        return Icons.camera_indoor_sharp;
      default:
        return Icons.help;
    }
  }
}

