import 'package:flutter/material.dart';
import './screens/edit_screen.dart';
import './screens/products_screen.dart';
import './widgets/splash_screen.dart';
import './screens/orders_screen.dart';
import './providers/orders.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/cart_screen.dart';
import './providers/products.dart';
import 'package:provider/provider.dart';
import './providers/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        )
      ],
      //wrapping material app with a provider
      // create: (ctx) => Products(),
      //monitoring any changes in Products class
      child: MaterialApp(
        title: 'ecommerce_proj',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          accentColor: Colors.yellowAccent,
          unselectedWidgetColor: Colors.black,
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          ProductsScreen.routeName: (ctx) => ProductsScreen(),
          EditScreen.routeName: (ctx) => EditScreen()
        },
      ),
    );
  }
}
