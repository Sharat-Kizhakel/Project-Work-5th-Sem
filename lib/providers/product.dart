import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final num price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {this.id,
      //@required
      this.title,
      //@required
      this.price,
      //@required
      this.description,
      //@required
      this.imageUrl,
      this.isFavorite = false});

  void toggleFavStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}

//to notify listeners on changing fav status
