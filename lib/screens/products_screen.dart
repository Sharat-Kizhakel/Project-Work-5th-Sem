import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/edit_screen.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/prod_screen_item.dart';
import '../widgets/side_drawer.dart';

//screen for editing or removing products
class ProductsScreen extends StatelessWidget {
  static const routeName = '/prod-screen';
  @override
  Widget build(BuildContext context) {
    final ProductData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange.shade100,
        elevation: 0,
        title: Container(
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          child: Text(
            'Your Products',
            style: TextStyle(
              color: Colors.yellow.shade50,
              fontSize: 24,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditScreen.routeName);
              },
              icon: Icon(Icons.add),
            ),
          ),
        ],
      ),
      drawer: SideDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: ProductData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              ProdScreenItem(
                ProductData.items[i].title,
                ProductData.items[i].imageUrl,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
