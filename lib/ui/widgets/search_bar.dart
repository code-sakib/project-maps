import 'package:flutter/material.dart';

searchBar(BuildContext context) {
  return Positioned(
    top: 30,
    child: SizedBox(
      width: 350,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          elevation: 2,
          child: ListTile(
            onTap: () => showSearch(
              context: context,
              delegate: MySearchDelegate(),
            ),
            title: const Text('Search'),
            leading: const Icon(
              (Icons.search_rounded),
            ),
            tileColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ),
    ),
  );
}

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () => query = '', icon: const Icon(Icons.clear_rounded))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.arrow_back_rounded));

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListTile(
      onTap: () {},
    );
  }
}
