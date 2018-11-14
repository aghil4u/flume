import 'package:flume/Pages/AssetsPage.dart';
import 'package:flume/Pages/EmployeesPage.dart';
import 'package:flume/Pages/VerificationsPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("MWS ONLINE"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text("Aghil"),
                accountEmail: new Text("amohandas@almansoori.biz"),
                currentAccountPicture: new CircleAvatar(
                  backgroundColor: Colors.white,
                  child: new Text("A"),
                )),
          ],
        ),
      ),
      body: new Container(
          child: GridView.count(
        padding: EdgeInsets.all(15.0),
        crossAxisCount: 2,
        crossAxisSpacing: 1.0,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext) => new AssetsPage()));
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.dashboard,
                        size: 50.0,
                      ),
                    ),
                    Row(
                      children: <Widget>[Text("Assets")],
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                    )
                  ],
                ),
                elevation: 2.0,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext) => new VerificationsPage()));
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.check_circle,
                        size: 50.0,
                      ),
                    ),
                    Row(
                      children: <Widget>[Text("Verifications")],
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                    )
                  ],
                ),
                elevation: 2.0,
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.location_searching,
                        size: 50.0,
                      ),
                    ),
                    Row(
                      children: <Widget>[Text("Locations")],
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                    )
                  ],
                ),
                elevation: 2.0,
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.local_shipping,
                        size: 50.0,
                      ),
                    ),
                    Row(
                      children: <Widget>[Text("Movements")],
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                    )
                  ],
                ),
                elevation: 2.0,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext) => new EmployeesPage()));
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.people,
                        size: 50.0,
                      ),
                    ),
                    Row(
                      children: <Widget>[Text("Employees")],
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                    )
                  ],
                ),
                elevation: 2.0,
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.person_pin_circle,
                        size: 50.0,
                      ),
                    ),
                    Row(
                      children: <Widget>[Text("Attandance")],
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                    )
                  ],
                ),
                elevation: 2.0,
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.track_changes,
                        size: 50.0,
                      ),
                    ),
                    Row(
                      children: <Widget>[Text("Transactions")],
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                    )
                  ],
                ),
                elevation: 2.0,
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.cloud,
                        size: 50.0,
                      ),
                    ),
                    Row(
                      children: <Widget>[Text("System Status")],
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                    )
                  ],
                ),
                elevation: 2.0,
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.feedback,
                        size: 50.0,
                      ),
                    ),
                    Row(
                      children: <Widget>[Text("Feedback")],
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                    )
                  ],
                ),
                elevation: 2.0,
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Icon(
                        Icons.settings,
                        size: 50.0,
                      ),
                    ),
                    Row(
                      children: <Widget>[Text("Settings")],
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                    )
                  ],
                ),
                elevation: 2.0,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
