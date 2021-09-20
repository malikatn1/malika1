import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test1/log_in.dart';
import 'package:test1/userdata.dart';
import 'package:test1/votes.dart';

void main() => runApp(AccountScreen());

class AccountScreen extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<AccountScreen> {
  bool isLogin = false;
  var flatBtnKey = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  UserModel user = new UserModel();
  String firstName = "", lastName = "", userImage = "";
  int userId = 0;
  Future<bool> userLogin() async {
    //
    // Getting value from Controller
    // String email = emailController.text;
    // String password = passwordController.text;
    //String firstName, lastName, userImage = "";
    //int userId;

    var url = Uri.parse(
        'http://q22.avocatar.tn/WebServices/login.php?login=${emailController.text}&password=${passwordController.text}'); //q22.avocatar.tn/WebServices/login.php?login=text_champs_login&password=text_champ_password
    var response = await http.post(url, body: {
      'id_user': '1',
      'nom': 'Malika',
      'prenom': 'Labidi',
      'img_user': ''
    });

    print('Response status: ${response.statusCode}'); //Response status: 200
    print('Response body: ${response.body}'); //Response body: {"Q22_Fan":[]}

    var responseObj = jsonDecode(response.body);
    print(responseObj);

    if (responseObj == 'success') {
      setState(() {
        isLogin = true;
        firstName = responseObj.prenom!;
        lastName = responseObj.nom!;
        userImage = responseObj.imguser!;
        userId = responseObj.id!;
      });
      return isLogin;
      // Navigator.pushNamed(context, '/home');
    } else {
      setState(() {
        isLogin = false;
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(),
            SizedBox(height: 10.0),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Enter Username or Email'),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Enter Password'),
              autofocus: false,
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            FlatButton(
              key: flatBtnKey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.green)),
              onPressed: () async {
                await userLogin();
                if (userLogin() == true) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Vote(firstName, lastName, userImage, userId)));
                } else
                  return;
              },
              child: Text('login'),
              color: Colors.green,
              minWidth: 300.0,
            ),
            SizedBox(height: 20.0),
            Text('Forgot Password?'),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.green)),
              onPressed: () {
                Navigator.pushNamed(context, '/resetpassword');
              },
              child: Text('Reset Password'),
              color: Colors.green,
              minWidth: 200.0,
            ),
            SizedBox(height: 20.0),
            Text('Do not have an account yet?'),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.green)),
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: Text('Sign Up'),
              color: Colors.green,
              minWidth: 200.0,
            ),
          ],
        ),
        // ],
      ),
      // ),
    );
  }
}
