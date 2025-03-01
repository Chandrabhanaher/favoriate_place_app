import 'package:favoriate_place_app/models/place.dart';
import 'package:favoriate_place_app/screeen/place_details.dart';
import 'package:flutter/material.dart';

class PlaceList extends StatelessWidget {
  const PlaceList({super.key, required this.placesItems});

  final List<Place> placesItems;

  @override
  Widget build(BuildContext context) {
    if (placesItems.isEmpty) {
      return Center(
        child: Text(
          'No places added yet..!',
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
      );
    }
    return ListView.builder(
      itemCount: placesItems.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(placesItems[index].id),
        child: ListTile(
          leading: CircleAvatar(
            radius: 26,
            backgroundImage: FileImage(placesItems[index].image),
          ),
          title: Text(
            placesItems[index].title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
          subtitle: Text(placesItems[index].location.address,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface)),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => PlaceDetailsScreen(data: placesItems[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
