import 'package:flutter/material.dart';
import '../providers/product.dart';
import '../widgets/product_item.dart';
import '../screens/product_detail_screen.dart';
import '../widgets/custom_appBar.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ""; //clearing the query in search
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //back arrow on search
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //results
    final test = Provider.of<Products>(context);
    final suggestionList = test.searchProduct(query);
    print(suggestionList);
    // List<Product> suggestionList = products
    //     .where(
    //       (prod) => prod.title.contains(query), //matching query dynamically
    //     )
    //     .toList();
    return GridView.count(
        padding: const EdgeInsets.all(2.0),
        crossAxisCount: 2,
        childAspectRatio: 2 / 2.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: suggestionList
            .map((e) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (ctx) => ProductDetailScreen(),
                          settings: RouteSettings(arguments: e.id)),
                    );
                  },
                  child: ProductItem(
                    e.id,
                    e.title,
                    e.imageUrl,
                    e.price,
                  ),
                ))
            .toList());
    // print("in build results");
    // // print(suggestionList[0].id);
    // // var SearchedProduct = test.findByTitle(suggestionList);
    // print("id");
    // // print(suggestionList[0].id);
    // Future<void> ProdDetail() async {
    //   // await Navigator.of(context).pushNamed(
    //   //   ProductDetailScreen.routeName,
    //   //   arguments: suggestionList[0].id, //product.id,
    //   // );
    //   await Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => ProductDetailScreen(),
    //     settings: RouteSettings(arguments: suggestionList[0].id),
    //   ));
    // }

    // if (suggestionList.isNotEmpty) {
    //   ProdDetail();
    // } else {
    //   return Center(
    //     child: Container(
    //       height: MediaQuery.of(context).size.height * 0.60,
    //       width: MediaQuery.of(context).size.width * 0.60,
    //       child: Text(
    //         "PLEASE ENTER A QUERY!!",
    //         style: TextStyle(fontWeight: FontWeight.bold),
    //       ),
    //     ),
    //   );
    // }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final test = Provider.of<Products>(context);
    final products = test.searchProduct(query);
    List tempsuggestion = [];
    List newtempsuggestion = [];
    return GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: products
            .map((e) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (ctx) => ProductDetailScreen(),
                          settings: RouteSettings(arguments: e.id)),
                    );
                  },
                  child: ProductItem(
                    e.id,
                    e.title,
                    e.imageUrl,
                    e.price,
                  ),
                ))
            .toList());
    // for (int i = 0; i < products.length; i++) {
    //   tempsuggestion.add(products[i].title);
    // }
    // print(tempsuggestion);
    // final suggestionList = query.isEmpty
    //     ? products
    //     : products
    //         .where(
    //           (prod) =>
    //               prod.title.startsWith(query), //matching query dynamically
    //         )
    //         .toList();
    // print("in buildsuggestions");
    // print(suggestionList);
    // return ListView.builder(
    //   itemBuilder: (ctx, i) => ListTile(
    //     onTap: () {
    //       showResults(context);
    //     },
    //   title: RichText(
    //       text: TextSpan(
    //         text: suggestionList[i].title.substring(0, query.length),
    //         //highlighting the query user types
    //         style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    //         //keeping the rest of suggestion faint
    //         children: [
    //           TextSpan(
    //             text: suggestionList[i].title.substring(
    //                   query.length,
    //                 ),
    //             style: TextStyle(color: Colors.grey),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    //   itemCount: suggestionList.length,
    // );
  }
}

//search implementation for product overview screen