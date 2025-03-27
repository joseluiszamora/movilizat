import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:movilizat/views/maps/osm_map.dart';

class ParkingPage extends StatelessWidget {
  const ParkingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("ParkingPage"),
        Expanded(
            child: OsmMap(
          pointCenter: LatLng(-16.549265841807, -68.2047145507413),
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
        )),
      ],
    );
  }
}
