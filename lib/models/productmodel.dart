import 'package:flutter/material.dart';

class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  ProductModel(
      {@required this.imageUrl,
      @required this.id,
      @required this.price,
      @required this.title,
      @required this.description});
}
