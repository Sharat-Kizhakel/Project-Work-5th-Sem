import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFav;
  ProductsGrid(this.showFav);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(
        context); //an instance of our provider class here its products

    final products = showFav ? productsData.getFavs : productsData.items;

    return GridView.builder(
      padding: const EdgeInsets.all(2.0),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        //.value is better for widgets which reuse components like Grid
        //everytime we will instantiate a new product from the product list
        child: ProductItem(),
      ),
    );
  }
}
