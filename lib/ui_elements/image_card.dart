import 'dart:io';
import 'package:flutter/material.dart';

imageCard(String imagePath) {
  return SizedBox(
    width: 250,
    height: 350,
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      shadowColor: Colors.blue,
      margin: const EdgeInsets.all(10),
      child: Image.file(
        File(imagePath),
        fit: BoxFit.fill,
      ),
    ),
  );
}