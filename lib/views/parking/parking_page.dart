import 'package:flutter/material.dart';
import 'package:movilizat/views/maps/osm_map.dart';

class ParkingPage extends StatelessWidget {
  const ParkingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("ParkingPage"),
        Expanded(child: OsmMap()),
      ],
    );
  }
}
