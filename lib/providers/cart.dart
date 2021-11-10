import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;
  CartItem({this.id, this.title, this.quantity, this.price, this.imageUrl});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get CartTotal {
    var itemTotal = 0.0;
    for (var item in _items.values) {
      itemTotal += (item.quantity * item.price);
    }
    return itemTotal;
  }

  double get CartTotalAfter {
    //cart total after tax
    var grandTotal = 0.0;
    grandTotal = CartTotal + (0.18 * CartTotal);
    return grandTotal;
  }

  void addItem(String productId, double price, String title, String imageUrl) {
    if (_items.containsKey(productId)) {
      //if present just increasing the quantity
      _items.update(
        productId,
        (existingItem) => CartItem(
            id: existingItem.id,
            title: existingItem.title,
            quantity: existingItem.quantity + 1,
            price: existingItem.price,
            imageUrl: existingItem.imageUrl),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            price: price,
            title: title,
            quantity: 1,
            imageUrl: imageUrl),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId, int quantity) {
    if (_items.containsKey(productId) && quantity > 1) {
      //reducing cart qty
      _items.update(
        productId,
        (existingItem) => CartItem(
            id: existingItem.id,
            imageUrl: existingItem.imageUrl,
            price: existingItem.price,
            quantity: existingItem.quantity - 1,
            title: existingItem.title),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
