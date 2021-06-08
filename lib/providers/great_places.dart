import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:great_places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get items {
    return [..._items];
  }

  addPlace(
    String pickeTitle,
    File pickedImage,
  ) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: pickedImage,
        location: null,
        title: pickeTitle);

    _items.add(newPlace);
    notifyListeners();
  }
}
