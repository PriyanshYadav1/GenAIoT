
import 'package:flutter/material.dart';
import '../models/assets_model.dart';
import 'scr_5_asset_stats_representation.dart';
import '../controllers/asset_search.dart';
// import 'hamburger_menu.dart';

enum AssetStatus { connected, disconnected, off }

class AssetsPage extends StatefulWidget {

  final String appName;
  const AssetsPage({super.key, required this.appName});


  @override
  _AssetsPageState createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {

// List of assets to be displayed in the list
  List<ListItem> assets = [
    ListItem(title: 'Police Car Monitoring System 1', icon: Icons.directions_car, status: AssetStatus.connected),
    ListItem(title: 'Police Car Monitoring System 2', icon: Icons.directions_car, status: AssetStatus.disconnected),
    ListItem(title: 'Police Car Monitoring System 3', icon: Icons.directions_car, status: AssetStatus.off),
    ListItem(title: 'Police Car Monitoring System 4', icon: Icons.directions_car, status: AssetStatus.connected),
    // ListItem(title: 'Bulldozer Asset 1', icon: Icons.directions_subway, status: AssetStatus.connected),
    // ListItem(title: 'Bulldozer Asset 2', icon: Icons.directions_subway, status: AssetStatus.disconnected),
    // ListItem(title: 'Bulldozer Asset 3', icon: Icons.directions_subway, status: AssetStatus.off),
    // ListItem(title: 'Bulldozer Asset 4', icon: Icons.directions_subway, status: AssetStatus.connected),
    // ListItem(title: 'Home Security Monitoring 1', icon: Icons.home, status: AssetStatus.connected),
    // ListItem(title: 'Home Security Monitoring 2', icon: Icons.home, status: AssetStatus.disconnected),
    ListItem(title: 'Police Car Monitoring System 5', icon: Icons.directions_car, status: AssetStatus.off),
    ListItem(title: 'Police Car Monitoring System 6', icon: Icons.directions_car, status: AssetStatus.connected),
    ListItem(title: 'Police Car Monitoring System 7', icon: Icons.directions_car, status: AssetStatus.connected),
    ListItem(title: 'Police Car Monitoring System 8', icon: Icons.directions_car,status: AssetStatus.disconnected),
    ListItem(title: 'Police Car Monitoring System 9', icon: Icons.directions_car,status: AssetStatus.connected),
    ListItem(title: 'Police Car Monitoring System 10', icon: Icons.directions_car,status: AssetStatus.off),


    ListItem(title: 'Industrial Blenders 1', icon: Icons.blender, status: AssetStatus.connected),
    ListItem(title: 'Industrial Blenders 2', icon: Icons.blender, status: AssetStatus.disconnected),
    ListItem(title: 'Industrial Blenders 3', icon: Icons.blender, status: AssetStatus.connected),
    ListItem(title: 'Industrial Blenders 4', icon: Icons.blender, status: AssetStatus.off),
    ListItem(title: 'Industrial Blenders 5', icon: Icons.blender, status: AssetStatus.connected),
    ListItem(title: 'Industrial Blenders 6', icon: Icons.blender, status: AssetStatus.off),
    ListItem(title: 'Industrial Blenders 7', icon: Icons.blender, status: AssetStatus.connected),
    ListItem(title: 'Industrial Blenders 8', icon: Icons.blender, status: AssetStatus.disconnected),
    ListItem(title: 'Industrial Blenders 9', icon: Icons.blender, status: AssetStatus.connected),
    ListItem(title: 'Industrial Blenders 10', icon: Icons.blender, status: AssetStatus.connected),


    ListItem(title: 'Compressor Monitoring System 1', icon: Icons.compress, status: AssetStatus.off),
    ListItem(title: 'Compressor Monitoring System 2', icon: Icons.compress, status: AssetStatus.disconnected),
    ListItem(title: 'Compressor Monitoring System 3', icon: Icons.compress, status: AssetStatus.connected),
    ListItem(title: 'Compressor Monitoring System 4', icon: Icons.compress, status: AssetStatus.disconnected),
    ListItem(title: 'Compressor Monitoring System 5', icon: Icons.compress, status: AssetStatus.connected),
    ListItem(title: 'Compressor Monitoring System 6', icon: Icons.compress, status: AssetStatus.connected),
    ListItem(title: 'Compressor Monitoring System 7', icon: Icons.compress, status: AssetStatus.off),
    ListItem(title: 'Compressor Monitoring System 8', icon: Icons.compress, status: AssetStatus.connected),
    ListItem(title: 'Compressor Monitoring System 9', icon: Icons.compress, status: AssetStatus.disconnected),
    ListItem(title: 'Compressor Monitoring System 10', icon: Icons.compress, status: AssetStatus.connected),

    // ListItem(title: 'Pond Water Quality Monitoring 1', icon: Icons.directions_car, status: AssetStatus.off),
    // ListItem(title: 'Pond Water Quality Monitoring 2', icon: Icons.directions_car, status: AssetStatus.connected),
    // ListItem(title: 'Swimming Pool Monitoring 1', icon: Icons.directions_car,status: AssetStatus.connected),
    // ListItem(title: 'Swimming Pool Monitoring 2', icon: Icons.directions_car,status: AssetStatus.connected),
    // ListItem(title: 'Pressure Washer Monitoring 1', icon: Icons.home, status: AssetStatus.connected),
    // ListItem(title: 'Pressure Washer Monitoring 2', icon: Icons.home, status: AssetStatus.disconnected),
    // ListItem(title: 'Utilities 1', icon: Icons.directions_car, status: AssetStatus.off),
    // ListItem(title: 'Utilities 2', icon: Icons.directions_car, status: AssetStatus.connected),
    // ListItem(title: 'Pump Monitoring System 1', icon: Icons.directions_car,status: AssetStatus.connected),
    // ListItem(title: 'Pump Monitoring System 2', icon: Icons.directions_car,status: AssetStatus.connected),
  ];

  List<ListItem> filteredAssets = [];


  @override
  void initState() {
    super.initState();
    _filterAssets(widget.appName);
  }

  void _filterAssets(String appName) {
    setState(() {
      filteredAssets = assets .where((asset) {
        return asset.title.toLowerCase().contains(appName.toLowerCase());
      }).toList();
      filteredAssets ??= [];
    });
  }

  Color _getIconColor(AssetStatus status) {
    switch (status) {
      case AssetStatus.connected:
        return Colors.green;
      case AssetStatus.disconnected:
        return Colors.red;
      case AssetStatus.off:
        return Colors.grey;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leadingWidth: 100,
        // leading: Builder(
        //   builder: (context) => Row(
        //     children: [
        //       IconButton(
        //         icon: const Icon(Icons.menu),
        //         onPressed: () {
        //           Scaffold.of(context).openDrawer();
        //         },
        //       ),
        //       Expanded(
        //         child: Padding(
        //           padding: const EdgeInsets.only(left: 8.0),
        //           child: CircleAvatar(
        //             radius: 100,
        //             backgroundImage: AssetImage(widget.image),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        title: Text(widget.appName,
          style: const TextStyle(fontWeight: FontWeight.bold),),

        centerTitle: true,
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
      ListView.builder(
        itemCount: filteredAssets.length,
        itemBuilder: (context, index) {
          final item = filteredAssets[index];
          return
            Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
              leading: Icon(item.icon, color: _getIconColor(item.status)),
              title: Text(item.title),
              trailing: const Icon(Icons.arrow_forward_ios_rounded,size: 20,),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StatRepresentation(title: item.title ),), // image is passed as a parameter
                    );
                  }
                        ),
            );
        },
      ),
    );
  }
}
