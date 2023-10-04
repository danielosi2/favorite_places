import 'dart:io';

import 'package:favorite_places/models/places.dart';
import 'package:favorite_places/provider/places_provider.dart';
import 'package:favorite_places/widget/image_input.dart';
import 'package:favorite_places/widget/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewPlace extends ConsumerStatefulWidget {
  const NewPlace({super.key});

  @override
  ConsumerState<NewPlace> createState() => _NewPlaceState();
}

class _NewPlaceState extends ConsumerState<NewPlace> {
  final titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selctedLocation;

  void _savePlace() {
    final entredTitle = titleController.text;
    if (entredTitle.isEmpty || _selectedImage == null || _selctedLocation == null) {
      return;
    }
    ref.read(placeProvider.notifier).add(titleController.text, _selectedImage!, _selctedLocation!);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    titleController.clear();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Place"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              const SizedBox(height: 12),
              //image input
              ImageInput(
                onPickImage: (image) {
                  _selectedImage = image;
                },
              ),
              const SizedBox(height: 12),
              LocationInput(
                onSelectLocation: (location) {
                  _selctedLocation = location;
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () {
                  _savePlace();
                },
                icon: const Icon(Icons.add),
                label: const Text("Add"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
