import 'package:flutter/material.dart';

import '../views/home.dart';
import 'button_style.dart';
import 'image_card.dart';

generateImages(List imagesList, HomePageState home) {
  return Column(children: <Widget>[
    SizedBox(
      height: 400,
      width: 800,
      child: ListView(
        padding: const EdgeInsets.all(15),
        scrollDirection: Axis.horizontal,
        children: [
          for (final image in imagesList) ...[
            imageCard(image.path),
            const SizedBox(width: 20)
          ]
        ],
      ),
    ),
    SizedBox(
      width: 200,
      child: ElevatedButton.icon(
        style: setButtonStyle(),
        onPressed: () {
          imagesList.clear();
          home.updateHome();
        },
        icon: const Icon(Icons.clear, size: 22),
        label: const Text('Usuń zdjęcia'),
      ),
    ),
  ]
  );
}