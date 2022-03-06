import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/cart_item.dart' as cart;
import './cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderItem {
  final String id;
  final num amount;
  final List<dynamic>
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
  OrderItem orderitem;
  List<OrderItem> ordersList = [];
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> getOrderData() async {
    List<OrderItem> newList = [];
    List<CartItem> cartitems = [];
    User currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot userSnapShot = await FirebaseFirestore.instance
        .collection("Orders")
        .doc(currentUser.uid)
        .collection(currentUser.uid)
        .get();

    userSnapShot.docs.forEach(
      (element) {
        orderitem = OrderItem(
          id: element.id,
          amount: (element.data() as dynamic)["TotalPrice"],
          products: (element.data() as dynamic)["Product"],
          dateTime: DateTime.parse((element.data() as dynamic)["OrderTime"]),
        );
        newList.add(orderitem);

        ordersList = newList;
      },
    );
  }

  List<OrderItem> get getOrderList {
    return ordersList;
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    User currentUser = FirebaseAuth.instance.currentUser;
    var time = DateTime.now();
    FirebaseFirestore.instance
        .collection("Orders")
        .doc(currentUser.uid)
        .collection(currentUser.uid)
        .add({
      "Product": cartProducts
          .map((c) => {
                "ProductId": c.id,
                "ProductTitle": c.title,
                "ProductPrice": c.price,
                "ProductQuetity": c.quantity,
                "ProductImage": c.imageUrl,
              })
          .toList(),
      "OrderTime": time.toString(),
      "TotalPrice": total,
    });

    _orders.insert(
      0,
      OrderItem(
          id: DateTime.now()
              .toString(), //usind iff id here watch nnot foestore one!!
          amount: total,
          dateTime: time,
          products: cartProducts),
    );
    notifyListeners();
  }
}

//helper widget to keep track of all orders of given user
