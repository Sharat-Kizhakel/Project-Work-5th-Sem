import 'package:flutter/material.dart';
import '../providers/orders.dart' as ord;
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final ord.OrderItem order;
  OrderItem(this.order);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text(
                "\u{20B9}" + order.amount.toString(),
              ),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(order.dateTime),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.expand_more),
              )),
        ],
      ),
    );
  }
}
