import 'package:flutter/material.dart';
class Product {
  final String id;
  final String title;
  final String description;
  final String userId;
  final String detection;
  final String imagePath;


  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.userId,
      @required this.detection,
      this.imagePath = null
      });
}
