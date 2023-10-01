import 'package:favorite_places/models/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceNotifier extends StateNotifier<List<Places>> {
  PlaceNotifier() : super([]);

  void add(String title) {
    final addPlace = Places(title: title);
    state = [...state, addPlace];
  }
}

final placeProvider = StateNotifierProvider<PlaceNotifier, List<Places>>(
  (ref) {
    return PlaceNotifier();
  },
);