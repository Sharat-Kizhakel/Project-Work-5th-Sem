import 'package:flutter/material.dart';
import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem>
      products; // all items that were ordered with their resp details
  final DateTime dateTime; //time order was placed
  OrderItem({
    this.id,
    this.amount,
    this.products,
    this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
          id: DateTime.now().toString(),
          amount: total,
          dateTime: DateTime.now(),
          products: cartProducts),
    );
    notifyListeners();
  }
}

//helper widget to keep track of all orders of given user