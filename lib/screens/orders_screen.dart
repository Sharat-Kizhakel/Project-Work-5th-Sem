import 'package:flutter/material.dart';
import '../widgets/side_drawer.dart';
import '../widgets/custom_appBar.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart' as ord; //OrderItem not required
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders-screen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<ord.Orders>(context);
    List<ord.OrderItem> finalorders = orderData.ordersList;
    print(orderData.getOrderData().then((ele) {
      print("got order data");
      setState(() {});
    }));

    return Scaffold(
        appBar: CustomAppBar('YOUR ORDERS'),
        drawer: SideDrawer(),
        body: ListView.builder(
          itemBuilder: (ctx, i) => OrderItem(finalorders[i]),
          itemCount: finalorders.length,
        ));
  }
}



//Screen for previous orders