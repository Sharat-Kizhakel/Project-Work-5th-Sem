import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './product.dart';
import '../models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Products with ChangeNotifier {
  List<UserModel> userModelList = [];
  UserModel userModel;
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
              userEmail: (element.data() as dynamic)["UserEmail"],
              userName: (element.data() as dynamic)["UserName"],
              userPhoneNumber: (element.data() as dynamic)["Phone Number"]);
          newList.add(userModel);
        }
        userModelList = newList;
      },
    );
  }

  List<UserModel> get getUserModelList {
    return userModelList;
  }

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
    return _items.firstWhere((prod) => prod.id == id);
  }

  Product findByTitle(String title) {
    return _items.firstWhere((prod) => prod.title == title);
  }

  List<Product> get getFavs {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  void addProduct(Product product) {
    final newProduct = Product(
        id: DateTime.now().toString(),
        title: product.title,
        price: product.price,
        description: product.description,
        imageUrl: product.imageUrl);
    _items.add(newProduct);

    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}


//products class is a provider to ensure easier access of products across the screen