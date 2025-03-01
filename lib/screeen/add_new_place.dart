//import 'package:favoriate_place_app/models/place.dart';
import 'dart:io';

import 'package:favoriate_place_app/models/place.dart';
import 'package:favoriate_place_app/providers/user_places.dart';
import 'package:favoriate_place_app/widgets/image_input.dart';
import 'package:favoriate_place_app/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewPlaseScreen extends ConsumerStatefulWidget {
  const AddNewPlaseScreen({super.key});

  @override
  ConsumerState<AddNewPlaseScreen> createState() => _AddNewPlaceState();
}

class _AddNewPlaceState extends ConsumerState<AddNewPlaseScreen> {
  final _formKey = GlobalKey<FormState>();
  var _placeName = '';
  File? _selectedImage;
  PlaceLocation? _selectedLocation;
  void _addNewItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_placeName.isEmpty ||
          _selectedImage == null ||
          _selectedLocation == null) {
        return;
      }
      ref
          .watch(userPlaceProvider.notifier)
          .addPlace(_placeName, _selectedImage!, _selectedLocation!);
      // Navigator.of(context).pop(
      //   Place(
      //     title: _placeName,
      //   ),
      // );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new place'),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    label: Text('place'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your favorite place name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _placeName = value!;
                  },
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                ImageInput(onPickImage: (image) {
                  _selectedImage = image;
                }),
                const SizedBox(height: 8),
                LocationInput(onSelectedLocation: (location) {
                  _selectedLocation = location;
                }),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: _addNewItem,
                  icon: Icon(Icons.add),
                  label: Text('Add item'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
