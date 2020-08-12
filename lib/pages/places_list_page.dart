import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_page.dart';
import '../providers/places.dart';

class PlacesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlacePage.routeName);
            },
          ),
        ],
      ),
      body: Consumer<Places>(
        child: const Center(
          child: const Text('No places!'),
        ),
        builder: (context, places, child) => places.items.length <= 0
            ? child
            : ListView.builder(
                itemCount: places.items.length,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(places.items[index].image),
                  ),
                  title: Text(places.items[index].title),
                  onTap: () {
                    // go to detail page
                  },
                ),
              ),
      ),
    );
  }
}
