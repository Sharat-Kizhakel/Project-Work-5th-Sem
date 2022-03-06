import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './product.dart';
import '../models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Products with ChangeNotifier {
  int c = 0;
  List<UserModel> userModelList = [];
  List<Product> prodModelList = [];
  UserModel userModel;
  Product productData;
  //getting user data
  Future<void> getUserData() async {
    List<UserModel> newList = [];
    User currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot userSnapShot =
        await FirebaseFirestore.instance.collection("User").get();

    userSnapShot.docs.forEach(
      (element) {
        if (currentUser.uid == (element.data() as dynamic)["UserId"]) {
          userModel = UserModel(
              userImage: (element.data() as dynamic)["UserImage"],
              userEmail: (element.data() as dynamic)["UserEmail"],
              userName: (element.data() as dynamic)["UserName"],
              userPhoneNumber: (element.data() as dynamic)["Phone Number"]);
          newList.add(userModel);
        }
        userModelList = newList;
      },
    );
  }

  Future<void> getProductData() async {
    List<Product> prodList = [];

    QuerySnapshot prodSnapShot = await FirebaseFirestore.instance
        .collection("availableproducts")
        .doc("W6nYSQsDErlx93IHJicg")
        .collection("homescreen")
        .get();
    //adding a favorite fields to all docs
    if (c == 0) {
      prodSnapShot.docs.forEach((element) {
        element.reference.update({'isFavorite': false});
        c++;
      });
    }

    prodSnapShot.docs.forEach(
      (element) {
        print("Element id");
        print(element.id);
        // DocumentReference ref = FirebaseFirestore.instance
        //     .collection("availableproducts")
        //     .doc("W6nYSQsDErlx93IHJicg")
        //     .collection("homescreen")
        //     .doc(element.id);

        productData = Product(
            id: element.id,
            title: (element.data() as dynamic)["title"],
            price: (element.data() as dynamic)["price"],
            description: (element.data() as dynamic)["description"],
            imageUrl: (element.data() as dynamic)["imageurl"],
            isFavorite: (element.data() as dynamic)["isFavorite"]);
        print("Printing Product id:");
        print(productData.id);
        print("Printing Product imageurl:");
        print(productData.imageUrl);
        print("Printing Product description:");
        print(productData.description);
        print("Printing Product price:");
        print(productData.price);
        print("print isfavorite");
        print(productData.isFavorite);
        prodList.add(productData);
      },
    );

    print("products wala");

    prodModelList = prodList;
    print(prodModelList);
    print(prodModelList[0].price);
    print(prodModelList[1].price);

    // return prodModelList;
  }

  List<Product> get productModelList {
    print("Inside getter");
    print(prodModelList);
    return prodModelList;
  }

  List<UserModel> get getUserModelList {
    return userModelList;
  }

//this section not needed just dummy data
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Shoes',
      description: 'Cool Pair of Cnavas shoes',
      price: 700.0,
      imageUrl:
          'https://media.gettyimages.com/photos/canvas-shoes-picture-id171224469?k=20&m=171224469&s=612x612&w=0&h=-gCNzSsAb9abkuq2ZH3Dwr9uT-FV2AcCDGK7Q1qJ41E=',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'Great pair of trousers.',
      price: 550.0,
      imageUrl:
          'https://media.gettyimages.com/photos/closeup-of-beige-pants-over-white-background-picture-id1141883027?k=20&m=1141883027&s=612x612&w=0&h=KXsFJeywpNuJ-IB_8w2XBrGS-WUq8oGt6dtnQyD_bnw=',
    ),
    Product(
        id: 'p3',
        title: 'Blue Scarf',
        description: 'Great scarf for the winters',
        price: 400.0,
        imageUrl:
            'https://media.gettyimages.com/photos/scarf-picture-id183265914?k=20&m=183265914&s=612x612&w=0&h=AQc-Nny3qtypnmGFzIfCPQfeWNOhC2tzv7Bq9vALTvA='),
    Product(
        id: 'p4',
        title: 'Water bottle',
        description: 'Fits conveniently in a bag',
        price: 400.0,
        imageUrl:
            'https://media.gettyimages.com/photos/bottle-of-water-isolated-on-white-picture-id184860771?k=20&m=184860771&s=612x612&w=0&h=km9qf40gb2VpkwaQ_2CRmmOge5oF5u7fu6TvEoNO_eY='),
    Product(
        id: 'p4',
        title: 'Water bottle',
        description: 'Fits conveniently in a bag',
        price: 500.0,
        imageUrl:
            'https://media.gettyimages.com/photos/bottle-of-water-isolated-on-white-picture-id184860771?k=20&m=184860771&s=612x612&w=0&h=km9qf40gb2VpkwaQ_2CRmmOge5oF5u7fu6TvEoNO_eY='),
    Product(
        id: 'p5',
        title: 'Water bottle',
        description: 'Fits conveniently in a bag',
        price: 500.0,
        imageUrl:
            'https://media.gettyimages.com/photos/bottle-of-water-isolated-on-white-picture-id184860771?k=20&m=184860771&s=612x612&w=0&h=km9qf40gb2VpkwaQ_2CRmmOge5oF5u7fu6TvEoNO_eY='),
    Product(
        id: 'p6',
        title: 'Water bottle',
        description: 'Fits conveniently in a bag',
        price: 500.0,
        imageUrl:
            'https://media.gettyimages.com/photos/bottle-of-water-isolated-on-white-picture-id184860771?k=20&m=184860771&s=612x612&w=0&h=km9qf40gb2VpkwaQ_2CRmmOge5oF5u7fu6TvEoNO_eY='),
  ]; //list of items

  List<Product> get items {
    return [..._items];
  } //returning a copy

  // void filterfav() {
  //   showFavoritesOnly = true;
  //   notifyListeners(); //notifying product grid class which has a listener and has to be rebuilt
  // }

  // void showAll() {
  //   showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Product findById(String id) {
    print("Inside find by id");
    print(id);
    print(prodModelList.firstWhere((prod) => prod.id == id));
    return prodModelList.firstWhere((prod) => prod.id == id);
  }

  Product findByTitle(String title) {
    return prodModelList.firstWhere((prod) => prod.title == title);
  }

  List<Product> get getFavs {
    print("Inside get fav");
    print(prodModelList.where((prod) => prod.isFavorite).toList());
    return prodModelList.where((prod) => prod.isFavorite).toList();
  }

  Future<void> addProduct(Product product) async {
    //uploading after user adds product
    print("Inside add product");
    print(product.isFavorite);
    var docref = await FirebaseFirestore.instance
        .collection("availableproducts")
        .doc("W6nYSQsDErlx93IHJicg")
        .collection("homescreen")
        .add({
      "description": product.description,
      "imageurl": product.imageUrl,
      "title": product.title,
      "price": product.price,
      "isFavorite": product.isFavorite
    });
    final newProduct = Product(
        id: docref.id,
        title: product.title,
        price: product.price,
        description: product.description,
        imageUrl: product.imageUrl,
        isFavorite: product.isFavorite);
    prodModelList.add(newProduct);
    print("test");
    print(prodModelList);
    notifyListeners();
  }

  void updateFavStatus(String id, bool isfav) {
    var colref = FirebaseFirestore.instance
        .collection("availableproducts")
        .doc("W6nYSQsDErlx93IHJicg")
        .collection("homescreen");
    colref.doc(id) // <-- Doc ID where data should be updated.
        .update({"isFavorite": isfav});

    print("Inside toggle");
    print(isfav);
    // notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = prodModelList.indexWhere((prod) => prod.id == id);
    print("In update product");
    print(id);
    print(prodIndex);
    if (prodIndex >= 0) {
      prodModelList[prodIndex] = newProduct;
      var colref = FirebaseFirestore.instance
          .collection("availableproducts")
          .doc("W6nYSQsDErlx93IHJicg")
          .collection("homescreen");
      colref.doc(id) // <-- Doc ID where data should be updated.
          .update({
        "description": newProduct.description,
        "imageurl": newProduct.imageUrl,
        "title": newProduct.title,
        "price": newProduct.price,
      });

      notifyListeners();
    } else {
      print('...');
    }
  }

  List<Product> searchProduct(String query) {
    List<Product> searchprod = prodModelList.where((element) {
      return element.title.toUpperCase().contains(query) ||
          element.title.toLowerCase().contains(query);
    }).toList();
    return searchprod;
  }

  Future<void> deleteProduct(String id) async {
    print("Inside delete");
    prodModelList.removeWhere((prod) => prod.id == id);
    print("List check:");
    print(prodModelList);
    var colref = FirebaseFirestore.instance
        .collection("availableproducts")
        .doc("W6nYSQsDErlx93IHJicg")
        .collection("homescreen");
    print(colref);
    print(colref.doc(id));
    await colref.doc(id).delete();
    print("After delete");
    notifyListeners();
  }
}


//products class is a provider to ensure easier access of products across the screen