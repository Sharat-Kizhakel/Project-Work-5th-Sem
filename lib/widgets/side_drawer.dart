import 'package:flutter/material.dart';
import '../models/usermodel.dart';
import '../screens/products_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/products_overview_screen.dart';
import '../providers/products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../screens/login.dart';

class SideDrawer extends StatelessWidget {
  Widget _buildUserAccountsDrawerHeader(List<UserModel> userModel) {
    return Column(
        children: userModel.map((e) {
      print(e.userName);
      print(e.userEmail);
      return UserAccountsDrawerHeader(
        accountName: Text('name:' + e.userName),
        accountEmail: Text('email:' + e.userEmail),
        currentAccountPicture: GestureDetector(
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.orange,
        ),
      );
    }).toList());
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    // String check = 'sdfsd';
    print(productProvider.getUserData().then((ele) {
      print("got data");
    }));
    List<UserModel> userModel = productProvider.userModelList;

    return Drawer(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          AppBar(
            title: Text('WELCOME' +
                userModel.map((e) {
                  return e.userName;
                }).toString()),
            automaticallyImplyLeading: false,
          ),
          // SizedBox(height: 10),
          _buildUserAccountsDrawerHeader(userModel),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 12),
          //   child: Container(
          //     width: 160,
          //     height: 100,
          //     child: Column(
          //         children: userModel.map((e) {
          //       return UserAccountsDrawerHeader(
          //         accountName: Text(e.userName),
          //         accountEmail: Text('email:' + e.userEmail),
          //         currentAccountPicture: GestureDetector(
          //           child: CircleAvatar(
          //             backgroundColor: Colors.grey,
          //             child: Icon(
          //               Icons.person,
          //               color: Colors.white,
          //             ),
          //           ),
          //         ),
          //         decoration: BoxDecoration(
          //           color: Colors.orange,
          //         ),
          //       );
          //     }).toList()),
          //   ),
          // ),

          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home Page'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductsOverviewScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_basket),
            title: Text('My Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ProductsScreen.routeName);
            },
          ),
          ListTile(
            onTap: () {
              logout(context);
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
