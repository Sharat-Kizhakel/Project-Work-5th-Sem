import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  String title;
  CustomAppBar(this.title);
  @override
  Size get PreferredSize => Size.fromHeight(40.0);
  Widget build(BuildContext context) {
    return AppBar(
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
          title,
          style: TextStyle(
            color: Colors.yellow.shade50,
            fontSize: 24,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}
