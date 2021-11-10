import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/custom_appBar.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = "/product-detail";
  // final bool searchDetail;
  // final String searchTitle;
  ProductDetailScreen();
  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false, //to avoid unecessary rebuild of widgets
    ).findById(productId);

    return Scaffold(
      appBar: CustomAppBar(loadedProduct.title),
      body: // SingleChildScrollView(
          // child: Column(
          //   children: [
          //     Container(
          //       height: 300,
          //       width: double.infinity,
          //       child: Image.network(
          //         loadedProduct.imageUrl,
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //     SizedBox(
          //       height: 10,
          //     ),
          //     Text(
          //       '${loadedProduct.price}',
          //       style: TextStyle(
          //         color: Colors.grey,
          //         fontSize: 20,
          //       ),
          //     ),
          //     SizedBox(
          //       height: 10,
          //     ),
          //     Container(
          //       padding: EdgeInsets.symmetric(horizontal: 10),
          //       width: double.infinity,
          //       child: Text(
          //         loadedProduct.description,
          //         textAlign: TextAlign.center,
          //         softWrap: true,
          //       ),
          //     ),
          //   ],
          // ),
          ListView(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Image.network(
            loadedProduct.imageUrl,
            width: MediaQuery.of(context).size.width * 0.95,
            height: 150,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  alignment: Alignment.bottomCenter,
                  color: Colors.black.withAlpha(50),
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  width: MediaQuery.of(context).size.width - 10,
                  height: 50,
                  alignment: Alignment.bottomCenter,
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          loadedProduct.title,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                        Text(
                          "\u{20B9} " + loadedProduct.price.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ExpansionTile(
              backgroundColor: Colors.yellow.shade50,
              collapsedBackgroundColor: Colors.yellow,
              title: Text(
                'Product Description',
                style: Theme.of(context).textTheme.headline6,
              ),
              iconColor: Colors.grey,
              initiallyExpanded: false,
              children: [
                ListTile(
                  title: Text(loadedProduct.description,
                      style: Theme.of(context).textTheme.bodyText1),
                )
              ],
              collapsedIconColor: Colors.black54,
            ),
          )
        ], //),
      ),
    );
  }
}

//Screen visible on clicking Product
