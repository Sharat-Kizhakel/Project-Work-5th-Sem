// import 'dart:html';

import 'package:flutter/material.dart';
import '../widgets/side_drawer.dart';
import '../screens/cart_screen.dart';
import '../widgets/products_grid.dart';
import 'package:carousel_pro/carousel_pro.dart';
import '../widgets/badge.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../widgets/data_search.dart';
import '../providers/products.dart';
import '../models/usermodel.dart';
import '../models/slider_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum FilterMenu {
  wishlist,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = "/product-overview";

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var showOnlyfav = false;
  Widget image_carousel;
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade100,
        title: // Text(
            //   'Greenoes',
            //   style: TextStyle(
            //     color: Colors.yellow.shade50,
            //     fontSize: 24,
            //     fontFamily: 'Roboto',
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            Container(
          // margin: EdgeInsets.only(right: 2),
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          child: Text(
            'HOME',
            style: TextStyle(
              color: Colors.yellow.shade50,
              fontSize: 22,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            //**********SEARCH BAR*************
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
          PopupMenuButton(
            padding: EdgeInsets.all(1.0),
            color: Colors.yellow,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
                borderSide: BorderSide(
                  color: Colors.deepOrange,
                )),
            onSelected: (FilterMenu selectedValue) {
              setState(() {
                //managing favs in widget itself since its local to the app
                if (selectedValue == FilterMenu.wishlist) {
                  showOnlyfav = true;
                } else {
                  showOnlyfav = false;
                }
              });
            },
            icon: Icon(Icons.filter_alt_outlined),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Card(
                  elevation: 6,
                  margin: EdgeInsets.all(2.5),
                  child: ListTile(
                    tileColor: Colors.yellowAccent,
                    title: Text(
                      'Wishlist',
                      style: TextStyle(
                        fontFamily: 'BebasNeue',
                        fontWeight: FontWeight.w200,
                        letterSpacing: 1.4,
                        color: Colors.deepOrange,
                      ),
                    ),
                    trailing: Icon(
                      Icons.favorite,
                      // color: Colors.redAccent,
                    ),
                  ),
                ),
                value: FilterMenu.wishlist,
              ),
              PopupMenuItem(
                child: Card(
                  elevation: 6,
                  margin: EdgeInsets.all(2.5),
                  child: ListTile(
                    tileColor: Colors.yellowAccent,
                    title: Text(
                      'See all',
                      style: TextStyle(
                          fontFamily: 'BebasNeue',
                          fontWeight: FontWeight.w200,
                          color: Colors.deepOrange,
                          letterSpacing: 1.4),
                    ),
                    trailing: Icon(
                      Icons.grid_view,
                      // color: Colors.black54,
                    ),
                  ),
                ),
                value: FilterMenu.All,
              )
            ],
          ),
          Consumer<Cart>(
            builder: (ctx, cart, ch) => Badge(
              //wrapping only badge in consumer since it is the only one which needs the changes in cart
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              //making it child to avoid unnescessary rebuild
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      drawer: SideDrawer(),
      body: new ListView(
        children: <Widget>[
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("products")
                .doc("HaHPxggDDZkSwJqGOpro")
                .collection("featureproduct")
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else {
                image_carousel = new Container(
                  height: 150.0,
                  child: new Carousel(
                    boxFit: BoxFit.cover,
                    images: [
                      Image.network(snapshot.data.docs[0]["image"]),
                      Image.network(snapshot.data.docs[1]["image"]),
                      Image.network(snapshot.data.docs[2]["image"]),
                      Image.network(snapshot.data.docs[3]["image"]),
                    ],
                    autoplay: true,
                    animationCurve: Curves.fastOutSlowIn,
                    animationDuration: Duration(milliseconds: 1000),
                    dotSize: 6.0,
                    indicatorBgPadding: 3,
                  ),
                );
                return image_carousel;
              }
            },
          ),
          new Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Available Products',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'BebasNeue',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 300,
            child: FutureBuilder(
                future: productsData.getProductData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  else {
                    return ProductsGrid(showOnlyfav);
                  }
                }),
          ),
        ],
      ),
    );
  }
}

//This is the homescreen which displays all the products
