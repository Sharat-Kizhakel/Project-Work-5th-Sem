import 'package:flutter/material.dart';

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
    final products = Provider.of<Products>(context).items;

    final suggestionList = query.isEmpty
        ? "No result found"
        : products
            .where(
              (prod) => prod.title.contains(query), //matching query dynamically
            )
            .map((prod) => prod.title)
            .toList()
            .toString();
    final productByTitle =
        Provider.of<Products>(context).findByTitle(suggestionList);
    print(suggestionList);

    // return   SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           Container(
    //             height: 300,
    //             width: double.infinity,
    //             child: Image.network(
    //               loadedProduct.imageUrl,
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           Text(
    //             '${loadedProduct.price}',
    //             style: TextStyle(
    //               color: Colors.grey,
    //               fontSize: 20,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           Container(
    //             padding: EdgeInsets.symmetric(horizontal: 10),
    //             width: double.infinity,
    //             child: Text(
    //               loadedProduct.description,
    //               textAlign: TextAlign.center,
    //               softWrap: true,
    //             ),
    //           ),
    //         ],
    //       ),
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final products = Provider.of<Products>(context).items;
    final suggestionList = query.isEmpty
        ? products.sublist(0, 4)
        : products
            .where(
              (prod) =>
                  prod.title.startsWith(query), //matching query dynamically
            )
            .toList();
    return ListView.builder(
      itemBuilder: (ctx, i) => ListTile(
        onTap: () {
          showResults(context);
        },
        title: RichText(
          text: TextSpan(
            text: suggestionList[i].title.substring(0, query.length),
            //highlighting the query user types
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            //keeping the rest of suggestion faint
            children: [
              TextSpan(
                text: suggestionList[i].title.substring(
                      query.length,
                    ),
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}

//search implementation for product overview screen