import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:favorite_places/models/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class PlaceNotifier extends StateNotifier<List<Places>> {
  PlaceNotifier() : super([]);

  void add(
    String title,
    File image,
    PlaceLocation location,
  ) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$filename');

    final addPlace = Places(
      title: title,
      image: copiedImage,
      location: location,
    );

    final dbPath = await sql.getDatabasesPath();
    sql.openDatabase(path.join(dbPath, ''));
    state = [...state, addPlace];
  }
}

final placeProvider = StateNotifierProvider<PlaceNotifier, List<Places>>(
  (ref) {
    return PlaceNotifier();
  },
);
