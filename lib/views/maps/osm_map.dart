import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movilizat/core/utils/maps/custom_map_options.dart';

class OsmMap extends StatefulWidget {
  const OsmMap({super.key});

  @override
  State<OsmMap> createState() => _OsmMapState();
}

class _OsmMapState extends State<OsmMap> {
  late CacheManager _mapCacheManager;
  late MapController _mapController;
  bool _isLoadingMap = true;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _initializeCacheManager();
  }

  @override
  void dispose() {
    super.dispose();
    _mapCacheManager.dispose();
    _mapController.dispose();
  }

  _initializeCacheManager() async {
    CacheManager mapCacheTmp =
        await CustomMapOptions().initializeCacheManager();

    setState(() {
      _mapCacheManager = mapCacheTmp;
      _isLoadingMap = false;
    });
  }

  //* Markers
  final List<CustomMarkerData> _markers = [
    CustomMarkerData(
      location: LatLng(4.7110, -74.0721),
      title: 'Bogotá',
      description: 'Capital de Colombia',
      icon: Icons.location_city,
      color: Colors.blue,
    ),
    CustomMarkerData(
      location: LatLng(3.4516, -76.5320),
      title: 'Cali',
      description: 'Ciudad del Valle',
      icon: Icons.place,
      color: Colors.green,
    ),
    CustomMarkerData(
      location: LatLng(6.2476, -75.5658),
      title: 'Medellín',
      description: 'Ciudad de la Eternal Primavera',
      icon: Icons.landscape,
      color: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (_isLoadingMap) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: CustomMapOptions().customMapOptions(
            const LatLng(-16.5217103519189, -68.1572745228186)),
        children: [
          CustomMapOptions().tileLayerOptions(_mapCacheManager),

          // Resto de capas como en el ejemplo anterior
          const MarkerLayer(
            markers: [
              Marker(
                point: LatLng(-16.549265841807, -68.2047145507413),
                width: 60,
                height: 60,
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     // Botón para hacer zoom
      //     FloatingActionButton(
      //       heroTag: 'zoomIn',
      //       child: Icon(Icons.add),
      //       onPressed: () {
      //         // Aumentar zoom
      //         _mapController.move(
      //             _mapController.camera.center, _mapController.camera.zoom + 1);
      //       },
      //     ),
      //     SizedBox(height: 10),
      //     FloatingActionButton(
      //       heroTag: 'zoomOut',
      //       child: Icon(Icons.remove),
      //       onPressed: () {
      //         // Disminuir zoom
      //         _mapController.move(
      //             _mapController.camera.center, _mapController.camera.zoom - 1);
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}

class CustomMarkerData {
  final LatLng location;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  CustomMarkerData({
    required this.location,
    required this.title,
    required this.description,
    this.icon = Icons.location_pin,
    this.color = Colors.red,
  });
}
