import 'package:favoriate_place_app/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
      address: '',
    ),
    this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapStateScreen();
}

class _MapStateScreen extends State<MapScreen> {
  late MapController _mapController;
  LatLng? _pickedLocation;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'Pick your locarion' : 'Your Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: Icon(Icons.save),
            ),
        ],
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          initialZoom: 18.0,
          maxZoom: 22.0,
          minZoom: 7.0,
          onTap: !widget.isSelecting
              ? null
              : (tapPosition, point) {
                  setState(() {
                    _pickedLocation = point;
                  });
                },
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            //subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: (_pickedLocation == null && widget.isSelecting)
                ? []
                : [
                    Marker(
                      width: 60.0,
                      height: 60.0,
                      point: _pickedLocation ??
                          LatLng(
                            widget.location.latitude,
                            widget.location.longitude,
                          ),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 30.0,
                      ),
                    ),
                  ],
          ),
        ],
      ),
      // body: GoogleMap(
      //   initialCameraPosition: CameraPosition(
      //     target: LatLng(widget.location.latitude, widget.location.latitude),
      //     zoom: 16,
      //   ),
      //   onTap: (latgog) {

      //   },
      //   markers: {
      //     Marker(
      //       markerId: MarkerId('M1'),
      //       position:
      //           LatLng(widget.location.latitude, widget.location.longitude),
      //     )
      //   },
      // ),
    );
  }
}
