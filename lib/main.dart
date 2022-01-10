import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './screens/login.dart';
import './screens/welcomescreen.dart';
import './screens/signup.dart';
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
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

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
        home: WelcomeScreen(),
        // WelcomeScreen(),
        //     StreamBuilder(
        //   stream: FirebaseAuth.instance.authStateChanges(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return ProductsOverviewScreen();
        //     } else {
        //       return WelcomeScreen();
        //     }
        //   },
        // ),
        routes: {
          ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          ProductsScreen.routeName: (ctx) => ProductsScreen(),
          EditScreen.routeName: (ctx) => EditScreen(),
          Login.routeName: (ctx) => Login(),
          SignUp.routeName: (ctx) => SignUp(),
        },
      ),
    );
  }
}
