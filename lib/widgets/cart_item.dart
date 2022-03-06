import 'dart:ui';

import 'package:flutter/material.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId; //item to be deleted
  final num price;
  final int quantity;
  final String title;
  final String imageUrl;
  CartItem(
      {this.id,
      this.price,
      this.productId,
      this.quantity,
      this.title,
      this.imageUrl});
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          //confirming deletion
          context: context,
          builder: (ctx) => AlertDialog(
            backgroundColor: Colors.redAccent,
            title: Text('Remove item from Cart?'),
            content: Text('Confirm delete', style: TextStyle(fontSize: 16)),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      'No',
                    ),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(ctx).pop(false);
                    },
                  ),
                  RaisedButton(
                    child: Text(
                      'Yes',
                    ),
                    color: Colors.white,
                    textColor: Colors.redAccent,
                    onPressed: () {
                      Navigator.of(ctx).pop(true);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        cartData.removeItem(productId, quantity);
      },
      child: Container(
        height: 90,
        child: Card(
          margin: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 4,
          ),
          child: ListTile(
            // leading: CircleAvatar(
            //   child: Padding(
            //     padding: EdgeInsets.all(5),
            //     child: FittedBox(
            //       child: Text(
            //         '\u{20B9} ${price}',
            //       ),
            //     ),
            //   ),
            // ),
            leading: Image.network(
              imageUrl,
              width: 80.0,
              height: 80.0,
            ),
            // alignment: Alignment.center,
            //     CircleAvatar(
            //   radius: 40,
            //   backgroundImage: NetworkImage(imageUrl),
            // ),

            title: Text(
              title,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                      'Total: \u{20B9} ${(price * quantity).toStringAsFixed(2)}'),
                ),
                SizedBox(
                  height: 4,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '\u{20B9} ${price}',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),

            trailing: //Text('${quantity} x'),

                //padding: const EdgeInsets.only(top: 0, bottom: 11),

                FittedBox(
              fit: BoxFit.fill,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      cartData.addItem(productId, price, title, imageUrl);
                    },
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.arrow_drop_up,
                      size: 50,
                    ),
                  ),
                  Text(
                    quantity.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  IconButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      cartData.removeItem(productId, quantity);
                    },
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 50,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
