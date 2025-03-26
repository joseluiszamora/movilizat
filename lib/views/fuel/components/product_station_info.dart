import 'package:flutter/material.dart';

class ProductStationInfo extends StatelessWidget {
  const ProductStationInfo({super.key, required this.producto});

  final String producto;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildSmallDot(context),
        Text(producto, style: Theme.of(context).textTheme.bodyMedium),
      ],
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
