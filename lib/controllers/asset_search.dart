import 'package:flutter/material.dart';

import '../views/assets.dart';
import '../models/assets_model.dart';
import '../views/scr_5_asset_stats_representation.dart';

//SearchDelegate class to handle search functionality for assets
class AssetSearchDelegate extends SearchDelegate {
  final List<ListItem> assets;

  AssetSearchDelegate({required this.assets});


  // Actions for the appbar,such as clearing the query
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showResults(context);
            close(context, null);
          },
        ),
      ),
    ];
  }

//Leading widget for the appbar, here it is a back button
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

// Shows the search results based on the query(calls when users submit the query by pressing search button)
  @override
  Widget buildResults(BuildContext context) {
    final results = assets.where((asset) {
      return asset.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return Card(
          child: ListTile(
            leading: Icon(item.icon,color: _getIconColor(item.status),),
            title: Text(item.title),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StatRepresentation(title: item.title ),), // image is passed as a parameter
              );
            },
          ),
        );
      },
    );
  }

// Shows the suggestions as the user types in the search query(invoked whenever the search query changes, the real-time feedback.)
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = assets.where((asset) {
      return asset.title.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final item = suggestions[index];
        return Card(
          child: ListTile(
            leading: Icon(item.icon, color: _getIconColor(item.status),),
            title: Text(item.title),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StatRepresentation(title: item.title ),), // image is passed as a parameter
              );
            },
          ),
        );
      },
    );
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
}


