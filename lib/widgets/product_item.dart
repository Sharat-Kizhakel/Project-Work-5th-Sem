import 'package:flutter/material.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final double price;
  // final String imageUrl;
  // ProductItem(this.id, this.title, this.imageUrl, this.price);
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
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
                    arguments: product.id,
                  );
                },
                child: Image.network(
                  product.imageUrl,
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
                },
                icon: Icon(product.isFavorite ? Icons.star : Icons.star_border),
                color: Theme.of(context).accentColor,
              ),
            ),
            backgroundColor: Colors.amberAccent,
            title: Text(
              product.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.deepOrange),
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              onPressed: () {
                cart.addItem(product.id, product.price, product.title,product.imageUrl);
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
              "\u{20B9} " + product.price.toString(),
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