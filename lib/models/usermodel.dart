import 'package:flutter/material.dart';

class UserModel {
  String userName, userEmail, userPhoneNumber, userImage;
  UserModel(
      {@required this.userEmail,
      @required this.userName,
      this.userImage,
      @required this.userPhoneNumber});
}
