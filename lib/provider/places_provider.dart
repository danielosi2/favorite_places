import 'dart:io';

import 'package:favorite_places/models/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceNotifier extends StateNotifier<List<Places>> {
  PlaceNotifier() : super([]);

  void add(String title, File image) {
    final addPlace = Places(title: title, image: image);
    state = [...state, addPlace];
  }
}

final placeProvider = StateNotifierProvider<PlaceNotifier, List<Places>>(
  (ref) {
    return PlaceNotifier();
  },
);
