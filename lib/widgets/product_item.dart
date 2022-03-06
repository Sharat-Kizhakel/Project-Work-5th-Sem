import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import '../providers/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final num price;
  final String imageUrl;
  ProductItem(this.id, this.title, this.imageUrl, this.price);
  @override
  Widget build(BuildContext context) {
    // final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final products = Provider.of<Products>(context);
    var qty;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              width: 2,
              color: Colors.deepOrange,
              style: BorderStyle.solid,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.orangeAccent,
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(-5, 1), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    ProductDetailScreen.routeName,
                    arguments: id, //product.id,
                  );
                },
                child: Image.network(
                  imageUrl, //product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        footer: Container(
          height: 33,
          child: GridTileBar(
            leading: Consumer<Product>(
              builder: (ctx, product, _) => IconButton(
                onPressed: () {
                  product.toggleFavStatus();
                  products.updateFavStatus(id, product.isFavorite);
                },
                icon: Icon(product.isFavorite ? Icons.star : Icons.star_border),
                color: Theme.of(context).accentColor,
              ),
            ),
            backgroundColor: Colors.amberAccent,
            title: Text(
              title, //product.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.deepOrange),
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              onPressed: () {
                final product = Provider.of<Product>(context, listen: false);
                cart.addItem(
                    product.id, product.price, product.title, product.imageUrl);
                Scaffold.of(context)
                    .hideCurrentSnackBar(); //when adding items back to back to rapidly show item has been added removing current one
                //alerting user on adding cart item, and giving option to undo it
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Item added!'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        final product =
                            Provider.of<Product>(context, listen: false);
                        print(cart.itemCount);
                        if (cart.items.containsKey(product.id)) {
                          qty = cart.items[product.id].quantity;
                        }
                        cart.removeItem(product.id, qty);
                        print(cart.itemCount);
                      },
                    ),
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart),
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
        header: Container(
          height: 35,
          child: GridTileBar(
            backgroundColor: Colors.yellow.shade50.withOpacity(0.75),
            title: Text(
              "\u{20B9} " + price.toString(), //product.price.toString(),
              style: TextStyle(
                  fontFamily: 'Anton',
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ),
        ),
      ),
    );
  }
}

//this widget is used for every grid item in home screen