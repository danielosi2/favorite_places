import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:favorite_places/models/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbPath, 'places.db'), onCreate: (db, version) {
    return db.execute(
      'CREATE TABLE usee_places(id TEXT PRIMARY KEY, title TEXT , image TEXT, lat REAL, lng REAL , address TEXT)',
    );
  }, version: 1);
  return db;
}

class PlaceNotifier extends StateNotifier<List<Places>> {
  PlaceNotifier() : super([]);

  loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final placess = data
        .map((row) => Places(
              id: row['id'] as String,
              title: row['title'] as String,
              image: File(row['image'] as String),
              location: PlaceLocation(latitude: row['lat'] as double, longitute: row['lng'] as double, address: row['address'] as String),
            ))
        .toList();

    state = placess;
  }

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
    final db = await _getDatabase();

    db.insert('user_places', {
      'id': addPlace.id,
      'title': addPlace.title,
      'image': addPlace.image.path,
      'lat': addPlace.location.latitude,
      'lng': addPlace.location.longitute,
      'address': addPlace.location.address,
    });
    state = [...state, addPlace];
  }
}

final placeProvider = StateNotifierProvider<PlaceNotifier, List<Places>>(
  (ref) {
    return PlaceNotifier();
  },
);
