import 'package:flutter/material.dart';

class PlacesDetails extends StatelessWidget {
  const PlacesDetails(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Places details"),
      ),
      body: Center(
        child: Text(title),
      ),
    );
  }
}
