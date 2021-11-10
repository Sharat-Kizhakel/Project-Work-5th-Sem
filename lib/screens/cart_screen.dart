import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart; //to avoid name clash with CartItem
import '../widgets/cart_item.dart';
import '../widgets/custom_appBar.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cartInfo = Provider.of<Cart>(context);
    return Scaffold(
      appBar: CustomAppBar('Your Cart'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Column(
          children: [
            // Card(
            //   margin: EdgeInsets.all(15),
            //   child: Padding(
            //     padding: EdgeInsets.all(8),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: <Widget>[
            //         Text(
            //           'Total',
            //           style: TextStyle(fontSize: 20),
            //         ),
            //         Spacer(), //TAKES UP MAXIMUM AVALAIBLE SPACE
            //         Chip(
            //           label: Text("\u{20B9} " +
            //               cartInfo.CartTotal.toStringAsFixed(2).toString()),
            //           backgroundColor: Theme.of(context).primaryColor,
            //         ),
            //         SizedBox(width: 10),
            //         FlatButton(
            //           onPressed: () {},
            //           child: Text('ORDER NOW'),
            //           color: Theme.of(context).primaryColor,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(height: 10),
            Expanded(
              //list of cart items
              child: ListView.builder(
                  itemBuilder: (_, i) => CartItem(
                      id: cartInfo.items.values.toList()[i].id,
                      productId: cartInfo.items.keys
                          .toList()[i], //the id of product to be deleted
                      price: cartInfo.items.values.toList()[i].price,
                      quantity: cartInfo.items.values.toList()[i].quantity,
                      title: cartInfo.items.values.toList()[i].title,
                      imageUrl: cartInfo.items.values.toList()[i].imageUrl),
                  itemCount: cartInfo.itemCount),
            ),
            //**************BOTTOM TOTAL AND SUBTOTAL CALC*****
            Divider(
              thickness: 2,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SUBTOTAL',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        "\u{20B9} " +
                            cartInfo.CartTotal.toStringAsFixed(2).toString(),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TAXES',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        "\u{20B9} " +
                            (0.18 * cartInfo.CartTotal)
                                .toStringAsFixed(2)
                                .toString(),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //****TOTAL****
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(color: Colors.black.withAlpha(50)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(5.0),
                  height: 50,
                  decoration: BoxDecoration(color: Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TOTAL',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          "\u{20B9} " +
                              cartInfo.CartTotalAfter.toStringAsFixed(2)
                                  .toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Provider.of<Orders>(context, listen: false).addOrder(
                    cartInfo.items.values.toList(),
                    cartInfo.CartTotalAfter,
                  );
                  cartInfo.clearCart();
                },
                child: Text('ORDER NOW'))
          ],
        ),
      ),
    );
  }
}

//Cart Screen before checkout
