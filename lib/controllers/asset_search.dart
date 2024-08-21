import 'package:flutter/material.dart';

import '../views/assets.dart';

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
          icon: Icon(Icons.clear),
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
      icon: Icon(Icons.arrow_back),
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
            leading: Icon(item.icon),
            title: Text(item.title),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
            ),
            onTap: () {},
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
            leading: Icon(item.icon),
            title: Text(item.title),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
            ),
            onTap: () {
              query = suggestions[index].title;
              showResults(context);
            },
          ),
        );
      },
    );
  }
}
