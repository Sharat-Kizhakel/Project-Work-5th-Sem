import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/screens/signup.dart';
import 'package:flutter_complete_guide/widgets/changescreen.dart';
import 'package:flutter_complete_guide/widgets/mytextformField.dart';
import 'package:flutter_complete_guide/widgets/passwordtextformfield.dart';
import '../widgets/mybutton.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../screens/products_overview_screen.dart';

class Login extends StatefulWidget {
  static const routeName = "/Login";
  @override
  _LoginState createState() => _LoginState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);
String email;
String password;
String errorMessage;
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
void validation(context) async {
  final FormState _form = _formKey.currentState;
  if (!_form.validate()) {
    try {
      // UserCredential result =
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ProductsOverviewScreen())),
              });
      // print(result);
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";

          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage);
      print(error.code);
    }
  } else {
    print("No");
  }
}

bool obserText = true;

class _LoginState extends State<Login> {
  Widget _buildAllPart() {
    return Container(
      height: 300,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "Login",
            style: TextStyle(
                fontSize: 50,
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold),
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
          PasswordTextFormField(
            obserText: obserText,
            onChanged: (value) {
              setState(() {
                password = value;
              });
            },
            name: "Password",
            validator: (value) {
              if (value == "") {
                return "Please Fill password";
              } else if (value.length < 5) {
                return 'password too short';
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
          MyButton(
            onPressed: () {
              validation(context);
            },
            name: "Login",
          ),
          ChangeScreeen(
            name: "SignUp",
            whichAccount: "New to greenoes?",
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => SignUp(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_buildAllPart()],
          ),
        ),
      ),
    );
  }
}
