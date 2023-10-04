import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  const PlaceLocation({required this.latitude, required this.longitute, required this.address});
  final double latitude;
  final double longitute;
  final String address;
}

class Places {
  Places({
    required this.title,
    required this.image,
    required this.location,
  }) : id = uuid.v4();
  final String title;
  final String id;
  final File image;
  final PlaceLocation location;
}
