import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import './product_item.dart';
import '../providers/product.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFav;
  ProductsGrid(this.showFav);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(
        context); //an instance of our provider class here its products

    // final products = getFavsshowFav ? productsData. : productsData.items;
    print(productsData.getProductData().then((ele) {
      print("got product data");
    }));
    print("after print ll");
    // List<Product> products =
    //     showFav ? productsData.getFavs : productsData.prodModelList;]
    print(showFav);
    List<Product> products =
        showFav ? productsData.getFavs : productsData.prodModelList;
    print(productsData.prodModelList);
    print("grid wala");
    print(products);
    products.map((e) {
      //just debugging ignore
      print(e.id);
      print(e.imageUrl);
      print(e.price.toString());
      print(" data test" + e.description);
      return 0;
    }).toList();
    print("After trial");
    return GridView.builder(
        padding: const EdgeInsets.all(2.0),
        // itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 2.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemCount: products.length,
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
              value: products[index],
              //.value is better for widgets which reuse components like Grid
              //everytime we will instantiate a new product from the product list
              child: ProductItem(products[index].id, products[index].title,
                  products[index].imageUrl, products[index].price),
            ));
  }
}
