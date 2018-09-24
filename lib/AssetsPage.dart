import 'package:flutter/material.dart';
import 'dart:async';
import 'AssetDetailsPage.dart';
import 'Model/Equipment.dart';
import 'Model/db.dart';

var refreshKey = GlobalKey<RefreshIndicatorState>();

class AssetsPage extends StatefulWidget {
  _AssetsPageState createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
 // @override
  // void initState() {
  //   super.initState();
  // }

  Future<List<Equipment>> refreshList() async {
    if (await db.GetEquipmentsFromStorage() == false) {
      await db.GetEquipmentsFromServer();
      await db.SaveEquipmentToStorage();
    }
    await Future.delayed(Duration(seconds: 1));
    return db.Equipments;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ASSET MASTER"),
        actions: <Widget>[
          new IconButton(
            tooltip: 'More (not implemented)',
            icon: new Icon(
              Theme.of(context).platform == TargetPlatform.iOS
                  ? Icons.more_horiz
                  : Icons.more_vert,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<Equipment>>(
        future: refreshList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var equipment = snapshot.data;
            return new ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: equipment == null ? 0 : equipment.length,
              itemBuilder: (BuildContext context, int index) {
                return new ListTile(
                  title: new Text(equipment[index].EquipmentNumber),
                  subtitle: Text(equipment[index].EquipmentDescription),
                  leading: CircleAvatar(
                    child: Text(index.toString()),
                  ),
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext) =>
                            new AssetDetailsPage(equipment: equipment[index])));
                  },
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: new CustomBottomAppBar(
        color: Colors.white,
        fabLocation: FloatingActionButtonLocation.endDocked,
        shape: CircularNotchedRectangle(),
      ),
    );
  }
}

//------------------------------------  SAVE AND RETRIVE JSON FILE  ------------------

//-----------------------------------------------------------------

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({this.color, this.fabLocation, this.shape});

  final Color color;
  final FloatingActionButtonLocation fabLocation;
  final NotchedShape shape;

  static final List<FloatingActionButtonLocation> kCenterLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> rowContents = <Widget>[
      new IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          showModalBottomSheet<Null>(
            context: context,
            builder: (BuildContext context) => const CustomBottomAppBarDrawer(),
          );
        },
      ),
    ];

    if (kCenterLocations.contains(fabLocation)) {
      rowContents.add(
        const Expanded(child: SizedBox()),
      );
    }

    rowContents.addAll(<Widget>[
      new IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          Scaffold.of(context).showSnackBar(
            const SnackBar(content: Text('This is a dummy search action.')),
          );
        },
      ),
      new IconButton(
        icon: new Icon(
          Theme.of(context).platform == TargetPlatform.iOS
              ? Icons.more_horiz
              : Icons.more_vert,
        ),
        onPressed: () {
          Scaffold.of(context).showSnackBar(
            const SnackBar(content: Text('This is a dummy menu action.')),
          );
        },
      ),
    ]);

    return new BottomAppBar(
      color: color,
      child: new Row(children: rowContents),
      shape: shape,
    );
  }
}

class CustomBottomAppBarDrawer extends StatelessWidget {
  const CustomBottomAppBarDrawer();

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Search'),
          ),
          ListTile(
            leading: Icon(Icons.threed_rotation),
            title: Text('Reset Database'),
            onTap: RefreshDatabase,
          ),
        ],
      ),
    );
  }

  Future<bool> RefreshDatabase() async {
    await db.DeleteRecords();
    await db.GetEquipmentsFromServer();
    await db.SaveEquipmentToStorage();
  }
}
