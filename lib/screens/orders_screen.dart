import 'package:flutter/material.dart';
import '../widgets/side_drawer.dart';
import '../widgets/custom_appBar.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' show Orders; //OrderItem not required
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders-screen';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: CustomAppBar('YOUR ORDERS'),
        drawer: SideDrawer(),
        body: ListView.builder(
          itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
          itemCount: orderData.orders.length,
        ));
  }
}



//Screen for previous orders