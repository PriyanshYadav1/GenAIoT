
import 'package:flutter/material.dart';
import 'scr_5_asset_stats_representation.dart';
import '../controllers/asset_search.dart';
import 'hamburger_menu.dart';



class AssetsPage extends StatefulWidget {

  final String image;
  const AssetsPage({super.key, required this.image});

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
    ListItem(title: 'Police Car Monitoring System 8', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 9', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 10', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 11', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 12', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 13', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 14', icon: Icons.directions_car),
    ListItem(title: 'Police Car Monitoring System 15', icon: Icons.directions_car),
  ];

  List<ListItem> filteredAssets = [];


  @override
  void initState() {
    super.initState();
    filteredAssets = assets; // Initialize filtered assets with the full list
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text('Assets',
          style: TextStyle(fontWeight: FontWeight.bold),),

        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              icon: const Icon(Icons.search),
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


class ListItem {
  final String title;
  final IconData icon;

  ListItem({required this.title, required this.icon});
}
