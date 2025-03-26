import 'package:flutter/material.dart';
import 'package:movilizat/core/data/models/fuel_station.dart';

class ImageStation extends StatelessWidget {
  const ImageStation({super.key, required this.station});

  final FuelStation station;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
            aspectRatio: 1.33,
            child: Image.network(
              station.imagen,
              fit: BoxFit.cover,
            ))
      ],
    );
  }
}
