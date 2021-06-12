import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:great_places/helpers/location_helper.dart';
import 'package:great_places/models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items {
    return [..._items];
  }

  addPlace(
      String pickeTitle, File pickedImage, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
      longitude: pickedLocation.longitude,
      latitude: pickedLocation.latitude,
    );
    final updatedLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: pickedImage,
        location: updatedLocation,
        title: pickeTitle);

    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location!.latitude,
      'loc_lon': newPlace.location!.longitude,
      'address': newPlace.location!.address!,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            image: File(item['image']),
            title: "title",
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lon'],
              address: item['address'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }
}
