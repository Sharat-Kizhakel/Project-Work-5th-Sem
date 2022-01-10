import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/screens/login.dart';
import 'package:flutter_complete_guide/screens/products_overview_screen.dart';
import '../widgets/mytextformField.dart';
import '../widgets/mybutton.dart';
import '../widgets/changescreen.dart';
import '../widgets/passwordtextformfield.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  static const routeName = "/SignUp";
  @override
  _SignUpState createState() => _SignUpState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);
bool obserText = true;
String email;
String password;
String userName;
String phoneNumber;

class _SignUpState extends State<SignUp> {
  void validation() async {
    final FormState _form = _formKey.currentState;
    print(_form.validate());
    if (!_form.validate()) {
      try {
        UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(result.user.uid);
        FirebaseFirestore.instance
            .collection("User")
            .doc(result.user.uid)
            .set({
              "UserName": userName,
              "UserId": result.user.uid,
              "UserEmail": email,
              "Phone Number": phoneNumber
            })
            .then((value) => {
                  Fluttertoast.showToast(msg: "Account created successfully!"),
                  Navigator.pushAndRemoveUntil(
                      (context),
                      MaterialPageRoute(
                          builder: (context) => ProductsOverviewScreen()),
                      (route) => false)
                })
            .catchError((e) {
              Fluttertoast.showToast(msg: e.message);
            });
      } on PlatformException catch (e) {
        // print(e.message.toString());
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(e.message),
          ),
        );
      }
    } else {
      print("no");
    }
  }

  Widget _buildAllTextFormField() {
    return Container(
      // height: 305, //312
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MyTextFormField(
              name: "UserName",
              onChanged: (value) {
                setState(() {
                  userName = value;
                });
              },
              validator: (value) {
                if (value.length < 6) {
                  return "Username is too short";
                } else if (value == "") {
                  return "Please fill UserName";
                }
                return "";
              },
            ),
            SizedBox(
              height: 20,
            ),
            MyTextFormField(
              name: "Email",
              onChanged: (value) {
                setState(() {
                  email = value;
                  print(email);
                });
              },
              validator: (value) {
                if (value == "") {
                  return "Please Fill Email";
                } else if (!regExp.hasMatch(value)) {
                  return 'Invalid email';
                }

                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            PasswordTextFormField(
              obserText: obserText,
              name: "Password",
              onChanged: (value) {
                setState(() {
                  password = value;
                  print(password);
                });
              },
              validator: (value) {
                String pattern =
                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                RegExp regExp = new RegExp(pattern);
                if (value == "") {
                  return "Please Fill password";
                } else if (value.length < 8) {
                  return 'Password too short';
                } else if (!regExp.hasMatch(value)) {
                  return 'invalid Password';
                }

                return "";
              },
              onTap: () {
                FocusScope.of(context).unfocus();
                setState(() {
                  obserText = !obserText;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            MyTextFormField(
              name: "Phone Number",
              onChanged: (value) {
                setState(() {
                  phoneNumber = value;
                });
              },
              validator: (value) {
                String pattern =
                    r'(^(?:[+0]9)?[0-9]{10,12}$)'; //allowing length 12 for country code
                RegExp regExp = new RegExp(pattern);
                if (value.length == 0) {
                  return 'Please enter mobile number';
                } else if (!regExp.hasMatch(value)) {
                  return 'Please enter valid mobile number';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPart() {
    return Container(
      height: 480,
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildAllTextFormField(),
            SizedBox(
              height: 10,
            ),
            Column(
              children: <Widget>[
                MyButton(
                  name: "SignUp",
                  onPressed: () {
                    validation();
                  },
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            ChangeScreeen(
              name: "Login",
              whichAccount: "I already have an account",
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => Login(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 90,
                    width: double.infinity,
                    color: Colors.orange,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _buildBottomPart(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
