import 'package:flume/Pages/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username;
  String pswd;

  @override
  Widget build(BuildContext context) {
    final email = TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
          labelText: 'Username', prefixIcon: Icon(Icons.person)),
      onChanged: (e) {
        username = e;
      },
    );

    final password = TextField(
      autofocus: false,
      obscureText: true,
      onChanged: (e) {
        pswd = e;
      },
      decoration: InputDecoration(
          labelText: "Password", prefixIcon: Icon(Icons.vpn_key)),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: MaterialButton(
        minWidth: 200.0,
        height: 42.0,
        onPressed: () {
          if (username.trim() == "admin" && pswd.trim() == "admin") {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext) => new HomePage()));
          }
        },
        color: Colors.blue,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
        backgroundColor: Colors.blue,
        body: Padding(
          padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                elevation: 20.0,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 24.0, right: 24.0),
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Image.asset(
                        'Images/logo.png',
                        height: 80.0,
                      ),
                      SizedBox(height: 10.0),
                      Center(
                        child: Text(
                          "ALMANSOORI WIRELINE SERVICES",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 15.0),
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Center(
                        child: Text(
                          "MWS OPERATIONS SUPPORT APP",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      email,
                      SizedBox(height: 20.0),
                      password,
                      SizedBox(height: 30.0),
                      loginButton,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
