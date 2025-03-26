import 'package:flutter/material.dart';

class ProductChip extends StatelessWidget {
  const ProductChip({
    super.key,
    required this.product,
  });

  final String product;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.blue;
    if (product == 'gasolina') {
      color = Colors.blue;
    } else if (product == 'diesel') {
      color = Colors.red;
    } else if (product == 'gnv') {
      color = Colors.green;
    }
    return ChoiceChip(
      label: Text(product),
      onSelected: (selected) {},
      selected: true,
      pressElevation: 0,
      selectedColor: color,
      labelStyle: const TextStyle(color: Colors.white),
      backgroundColor: Colors.grey,
    );
  }
}
