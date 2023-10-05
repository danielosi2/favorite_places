import 'package:favorite_places/models/places.dart';
import 'package:favorite_places/screens/map.dart';
import 'package:flutter/material.dart';

class PlacesDetails extends StatelessWidget {
  const PlacesDetails({super.key, required this.place});

  final Places place;

  String get locationImage {
    final lat = place.location.latitude;
    final lng = place.location.longitute;

    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C$lat,$lng&key=AIzaSyBYoRZuoQOTJV5kNN2uUBUzjd_pL0o2qBM";
  }

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
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MapScreen(
                            location: place.location,
                            isSelecting: false,
                          ),
                        ));
                      },
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(locationImage),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black54],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                      alignment: Alignment.center,
                      child: Text(
                        place.location.address,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
