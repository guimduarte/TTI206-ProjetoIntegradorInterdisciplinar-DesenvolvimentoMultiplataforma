import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

const minZoom = 0.5;
const maxZoom = 1000.0;
const apiUrl = String.fromEnvironment("apiUrl", defaultValue: "");

class ImageVisualizer extends StatefulWidget {
  const ImageVisualizer({
      super.key,
      required this.imageName,
      required this.espelhado,
  });
  final String imageName;
  final bool espelhado;
  @override
  ImageVisualizerState createState() => ImageVisualizerState();
}

class ImageVisualizerState extends State<ImageVisualizer> {
  final mapController = MapController();
  bool espelhado = false;

  var customMarkers = <Marker>[];
  Marker buildPin(LatLng point) => Marker(
    point: point,
    width: 60,
    height: 60,
    child: GestureDetector(
      child: const Icon(Icons.arrow_downward, size: 60, color: Colors.black),
    ),
  );
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialZoom: 1.0,
              maxZoom: 7,
              onTap: (_, p) => setState(() => customMarkers = [buildPin(p)]),
              crs: Epsg4326NoRepeat(),
              interactionOptions: InteractionOptions(),
              onMapReady: () {},
            ),
            children: [
              TileLayer(
                urlTemplate: 'http://localhost:8000/image/'+widget.imageName+'/{z}/{x}/{y}',
                tms: true,
                tileProvider: NetworkTileProvider(
                  cachingProvider: const DisabledMapCachingProvider()
                ),
                minZoom: 1,
                tileDimension: 256,
              ),
              MarkerLayer(
                markers: customMarkers,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Epsg4326NoRepeat extends Epsg4326 {
  const Epsg4326NoRepeat();

  @override
  bool get replicatesWorldLongitude => false;
}
