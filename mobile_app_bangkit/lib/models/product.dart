import 'package:flutter/material.dart';

class Product {
  final int prediction;
  final String label;
  final String imagePath;
  final int userID;
  final String updatedAt;

  Product({
    @required this.prediction,
    @required this.label,
    @required this.imagePath,
    @required this.userID,
    @required this.updatedAt,
  });
}
