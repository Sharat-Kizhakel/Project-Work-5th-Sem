import 'package:flutter/material.dart';
import '../widgets/side_drawer.dart';
import '../screens/cart_screen.dart';
import '../widgets/products_grid.dart';
import 'package:carousel_pro/carousel_pro.dart';
import '../widgets/badge.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../widgets/data_search.dart';

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

  @override
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 150.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          Image.network(
              'https://media.gettyimages.com/photos/close-up-of-a-white-mens-shirts-picture-id157567639?k=20&m=157567639&s=612x612&w=0&h=r5oyOHpJjtuNUWBi3nuuliHVDVhyaevCkr-ml1bhTDk='),
          Image.network(
              'https://media.gettyimages.com/photos/elegant-black-leather-shoes-picture-id172417586?k=20&m=172417586&s=612x612&w=0&h=DDjvQhRgSYcH2F5rVt8iohGvkqCIteYuTCq3wpJuUi4='),
          Image.network(
              'https://media.gettyimages.com/photos/skinny-tight-blue-jeans-on-white-background-picture-id173239968?k=20&m=173239968&s=612x612&w=0&h=PjNPntBEnEjhFD2CYzaiCfSAmiapQVqPZWfOz-iD8kk='),
          Image.network(
              'https://media.gettyimages.com/photos/baseball-jersey-on-coat-hanger-picture-id163514652?k=20&m=163514652&s=612x612&w=0&h=Id6678y-NhIz4xot0CMEauFCZcGYmMHWtK-hijKOxIA='),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 6.0,
        indicatorBgPadding: 3,
      ),
    );
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
          image_carousel,
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
            child: ProductsGrid(showOnlyfav),
          ),
        ],
      ),
    );
  }
}

//This is the homescreen which displays all the products
