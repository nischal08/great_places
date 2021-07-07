import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleTextController = TextEditingController();
  late File? _pickedImage;
  PlaceLocation? _pickedLocation;
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double lat, double lon) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lon);
  }

  void _savePlace() {
    if (_titleTextController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) {
      return;
    }

    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleTextController.text, _pickedImage!, _pickedLocation!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new place'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top -
              AppBar().preferredSize.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleTextController,
                      decoration: InputDecoration(labelText: "Title"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(onSelectImage: _selectImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(
                      onSelectPlace: _selectPlace,
                    )
                  ],
                ),
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).accentColor),
                  elevation: MaterialStateProperty.all(0),
                  tapTargetSize: MaterialTapTargetSize
                      .shrinkWrap, //remove the large button to take less area remove padding
                ),
                onPressed: _savePlace,
                icon: Icon(Icons.add),
                label: Text('Add Place'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
