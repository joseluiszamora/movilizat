import 'package:flutter/material.dart';

class ImageStation extends StatelessWidget {
  const ImageStation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
            aspectRatio: 1.33,
            child: Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVriUJlkvPVgX8lqYokR0lOn73Ijhx7DOmVA&s",
              fit: BoxFit.cover,
            ))
      ],
    );
  }
}
