import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'AssetsPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue
      ),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flume"),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: < Widget > [
            new UserAccountsDrawerHeader(
              accountName: new Text("Aghil"),
              accountEmail: new Text("amohandas@almansoori.biz"),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.white,
                child: new Text("A"),
              )
            ),
            new ListTile(
              title: new Text("Asset Master"),
              leading: new Icon(Icons.list),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext) => new AssetsPage()));
              },
            ),
            new ListTile(
              title: new Text("Page Two"),
              leading: new Icon(Icons.library_books),
            ),
            new Divider(),
            new ListTile(
              title: new Text("Close"),
              leading: new Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      body: new Container(
        child: new Center(
          child: new Text("Awesome")
        )
      ),
    );
  }
}