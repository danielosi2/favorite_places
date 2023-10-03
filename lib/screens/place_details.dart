import 'package:favorite_places/models/places.dart';
import 'package:flutter/material.dart';

class PlacesDetails extends StatelessWidget {
  const PlacesDetails({super.key, required this.place});

  final Places place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Places details"),
        ),
        body: Stack(
          children: [
            Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            )
          ],
        ));
  }
}
