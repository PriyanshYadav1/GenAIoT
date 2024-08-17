
import 'package:flutter/material.dart';
import 'asset_search.dart';
import '../hamburger_menu.dart';


class AssetsPage extends StatefulWidget {

  final String image;
  AssetsPage({required this.image});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assets',
      home: AssetsPage(image:image),
    );
  }

  @override
  _AssetsPageState createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {

// List of assets to be displayed in the list
  List<ListItem> assets = [
    ListItem(title: 'Police Car Monitoring System 1', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 2', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 3', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 4', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 5', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 6', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 7', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 1', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 2', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 3', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 4', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 5', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 6', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 7', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 1', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 2', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 3', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 4', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 5', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 6', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 7', icon: Icons.directions_car),
  ];

  List<ListItem> filteredAssets = [];

  @override
  void initState() {
    super.initState();
    filteredAssets = assets; // Initialize filtered assets with the full list
  }

  // void filterAssets(String query) {
  //   final filtered = assets.where((asset) {
  //     return asset.title.toLowerCase().contains(query.toLowerCase());
  //   }).toList();
  //
  //   setState(() {
  //     filteredAssets = filtered;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Builder(
          builder: (context) => Row(
            children: [
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage(widget.image),
                  ),
                ),
              ),
            ],
          ),
        ),
        title: Text('Assets',
          style: TextStyle(fontWeight: FontWeight.bold),),

        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: AssetSearchDelegate(assets: assets),
                );
              },
            ),
          ),
        ],
      ),
       drawer: AppDrawer(),
      body:
      ListView.builder(
        itemCount: filteredAssets.length,
        itemBuilder: (context, index) {
          final item = filteredAssets[index];
          return
            Card(
              child: ListTile(
              hoverColor: Colors.grey[400],
              leading: Icon(item.icon),
              title: Text(item.title),
              trailing: Icon(Icons.arrow_forward_ios_rounded,size: 20,),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => AssetDetails(title: item.title ),), // image is passed as a parameter
                    // );
                  }
                        ),
            );
        },
      ),
    );
  }
}


class ListItem {
  final String title;
  final IconData icon;

  ListItem({required this.title, required this.icon});
}
