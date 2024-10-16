import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/api_calling.dart';
import 'assets.dart';

class Sites extends StatefulWidget{
  final bool isSite;

  const Sites({super.key, required this.isSite});

  @override
  _SitesState createState() => _SitesState();


}

class _SitesState extends State<Sites>{

  List<ListItem> sites = [];
  List<ListItem> fleets = [];
  bool isLoading = true;
  bool errorOccurred = false;
  late String title;


  @override
  void initState() {
    super.initState();
    if (widget.isSite) {
      title = "Sites";
      //_fetchSites(widget.isSite);
    }
  }


  // Widget _buildNavButton(String label, int index) {
  //   bool isSelected = _selectedIndex == index;
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 4.0),
  //     child: ElevatedButton(
  //       onPressed: () => _onNavButtonTapped(index),
  //       style: ElevatedButton.styleFrom(
  //         foregroundColor: isSelected ? Colors.white : Colors.grey[800],
  //         backgroundColor: isSelected ? Colors.black : Colors.grey[300],
  //         padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
  //         elevation: 0,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(200.0),
  //         ),
  //       ),
  //       child: Text(label),
  //     ),
  //   );
  // }

  // Widget _buildSelectedView() {
  //   final Map<String, List<FlSpot>> graphData =
  //   _prepareGraphData(recentTelemetryData);
  //   switch (_selectedIndex) {
  //     case 0:
  //       return _buildTelemetryView(latestTelemetryData);
  //     case 1:
  //     //return _buildRecentTelemetryView(recentTelemetryData);
  //       return _buildRecentTelemetryView(graphData);
  //     case 2:
  //       return _buildLiveEventsView(liveEventsData);
  //     default:
  //       return Center(child: Text('Select a View'));
  //   }
  // }



  // Future<void> _fetchSites(bool isSite) async {
  //   setState(() {
  //     isLoading = true;
  //     errorOccurred = false;
  //   });
  //
  //   const url = '/api/sites';
  //
  //   // const url = '/api/asset_models';
  //
  //
  //   print('Fetching assets : $url');
  //
  //
  //   final response = await get(url);
  //   print("Received assets: $response");
  //
  //
  //   if (response['success']) {
  //     final responseData = response['data'];
  //
  //
  //     if (responseData != null && responseData.isNotEmpty) {
  //       List<dynamic> data = responseData is List ? responseData : [];
  //
  //       final Sites = data.map((json) {
  //         return ListItem.fromJson(json is Map<String, dynamic> ? json : {});
  //       }).toList();
  //
  //
  //       // if (responseData != null && responseData is List) {
  //       //
  //       //   for (var asset in responseData) {
  //       //     if (asset is Map<String, dynamic> && asset.containsKey('short_code')) {
  //       //       final shortCode = asset['short_code'];
  //       //       print('Short Code: ${asset['short_code']}');
  //       //       fetchAssetss(shortCode);
  //       //     }
  //       //   }}
  //
  //       setState(() {
  //         allAssets = assets;
  //         filteredAssets = assets;
  //         isLoading = false;
  //       });
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //         errorOccurred = true;
  //       });
  //       _showErrorDialog('No data received from the server!');
  //     }
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //       errorOccurred = true;
  //     });
  //     _showErrorDialog( 'An unknown error occurred.');
  //
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title:
          //Text(currentAppName.isEmpty ? 'Assets' : currentAppName),
          Text( "Sites",
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
                onPressed: () async {
                  // showSearch(
                  //   context: context,
                  //   delegate: AssetSearchDelegate(sites: sites),
                  // );

                  const url = '/api/sites';
                  print('Fetching assets : $url');
                  final response = await get(url);
                  print("Received sites==============: $response");

                  const url1 = '/api/applications';
                  print("${url1}dsahdjsahdkjsa");
                  final response1 = await get(url1);
                  print("Received apps=======: $response1");

                  const url2 = '/api/fleets';
                  print('Fetching assets : $url2');
                  final response2 = await get(url2);
                  print("Received fleets==============: $response2");

                },
              ),
            ),
          ],
        ),
        // drawer: AppDrawer(),
        body:
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          // children: [
          //   Expanded(
          //     child: _buildSelectedView(),
          //   ),
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       _buildNavButton('Latest Telemetry', 0),
          //       _buildNavButton('Recent Telemetry', 1),
          //       _buildNavButton('Live Events', 2),
          //     ],
          //   ),
          // ],
        ),
      ),
    );
  }
}