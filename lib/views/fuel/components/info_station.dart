import 'package:flutter/material.dart';
import 'package:movilizat/core/data/models/fuel_station.dart';

class InfoStation extends StatelessWidget {
  const InfoStation({
    super.key,
    this.pressOnSeeMore,
    required this.station,
  });

  final FuelStation station;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            station.nombre,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            station.direccion,
            maxLines: 3,
          ),
          const SizedBox(height: 10),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...station.productos.map((producto) => Row(
                      children: [
                        buildSmallDot(context),
                        Text(producto,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding buildSmallDot(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        height: 4,
        width: 4,
        decoration: BoxDecoration(
          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.4),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
