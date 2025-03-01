import 'package:favoriate_place_app/models/place.dart';
import 'package:favoriate_place_app/providers/user_places.dart';
import 'package:favoriate_place_app/screeen/add_new_place.dart';
import 'package:favoriate_place_app/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});
  @override
  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> _placeFuture;
  @override
  void initState() {
    super.initState();
    _placeFuture = ref.read(userPlaceProvider.notifier).loadPlace();
  }

  @override
  Widget build(BuildContext context) {
    final plaseItems = ref.watch(userPlaceProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push<Place>(
                MaterialPageRoute(builder: (ctx) => const AddNewPlaseScreen()),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: _placeFuture,
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(child: CircularProgressIndicator())
                    : PlaceList(placesItems: plaseItems),
          )),
    );
  }
}

// class _YourPlaceState extends ConsumerState<PlacesScreen> {
//   final List<Place> _placesItems = [];

//   void _addNewItem() async {
//     final newItem = await Navigator.of(context).push<Place>(
//       MaterialPageRoute(builder: (ctx) => const AddNewPlaseScreen()),
//     );
//     if (newItem == null) {
//       return;
//     }
//     setState(() {
//       _placesItems.add(newItem);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your places'),
//         actions: [
//           IconButton(
//             onPressed: _addNewItem,
//             icon: Icon(Icons.add),
//           ),
//         ],
//       ),
//       body: PlaceList(placesItems: _placesItems),
//     );
//   }
// }
