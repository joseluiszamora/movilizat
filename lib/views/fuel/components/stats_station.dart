import 'package:flutter/material.dart';

class StatsStation extends StatelessWidget {
  const StatsStation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildStat(context, "Tiempo de fila:", "1h"),
        const SizedBox(height: 10),
        buildStat(context, "Vehiculos en fila:", "50"),
        const SizedBox(height: 10),
        buildStat(context, "Ultima actualización:", "24/03/2025 14:58")
      ],
    );
  }

  Row buildStat(BuildContext context, String value, String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
