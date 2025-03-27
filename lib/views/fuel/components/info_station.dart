import 'package:flutter/material.dart';
import 'package:movilizat/core/data/models/fuel_station.dart';
import 'package:movilizat/views/fuel/components/product_station_info.dart';

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
          // Center(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       ...station.productos
          //           .map((producto) => ProductStationInfo(producto: producto)),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
