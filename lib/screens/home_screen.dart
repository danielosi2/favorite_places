import 'package:favorite_places/screens/new_place.dart';
import 'package:favorite_places/screens/place_details.dart';
import 'package:favorite_places/provider/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(placeProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placeProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const NewPlace(),
              ));
            },
            icon: const Icon(Icons.add),
          )
        ],
        title: const Text('Favorite Places'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: FutureBuilder(
              future: _placesFuture,
              builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: places.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlacesDetails(
                                place: places[index],
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 26,
                            backgroundImage: FileImage(places[index].image),
                          ),
                          title: Text(
                            places[index].title,
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                          ),
                          subtitle: Text(
                            places[index].location.address,
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: Theme.of(context).colorScheme.onBackground,
                                ),
                          ),
                        ),
                      ),
                    ))),
    );
  }
}
