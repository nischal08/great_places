import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: const Text("Got no places yet, start adding some!"),
                ),
                builder: (context, greatPlaces, ch) =>
                    greatPlaces.items.length <= 0
                        ? ch!
                        : ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (context, index) => ListTile(
                              onTap: () {
                                //go to detail page
                              },
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlaces.items[index].image),
                              ),
                              title: Text(
                                greatPlaces.items[index].title,
                              ),
                            ),
                          ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).primaryColorLight,
        onPressed: () {
          Navigator.pushNamed(context, AddPlaceScreen.routeName);
        },
      ),
    );
  }
}
