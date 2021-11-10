import 'package:flutter/material.dart';
import '../screens/orders_screen.dart';
import '../screens/products_overview_screen.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // child: Column(
      //   children: <Widget>[
      //     AppBar(
      //       title: Text('Hello'),
      //       automaticallyImplyLeading: false,
      //     ),
      //     Divider(),
      //     ListTile(
      //       leading: Icon(Icons.home),
      //       title: Text('Products'),
      //       onTap: () {
      //         Navigator.of(context)
      //             .pushReplacementNamed(ProductsOverviewScreen.routeName);
      //       },
      //     ),
      //     Divider(),
      //     ListTile(
      //       leading: Icon(Icons.payment),
      //       title: Text('Orders'),
      //       onTap: () {
      //         Navigator.of(context)
      //             .pushReplacementNamed(OrdersScreen.routeName);
      //       },
      //     )
      //   ],
      // ),
      child: ListView(
        children: <Widget>[
          AppBar(
            title: Text('Hello xyz'),
            automaticallyImplyLeading: false,
          ),
          UserAccountsDrawerHeader(
            accountName: Text('Name:xyz'),
            accountEmail: Text('email:xyz.gmail.com'),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.orange,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home Page'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductsOverviewScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_basket),
            title: Text('My Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
