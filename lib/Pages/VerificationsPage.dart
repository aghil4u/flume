import 'package:flume/Model/Verification.dart';
import 'package:flume/Pages/VerificationDetailsPage.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flume/Services/db.dart';

//var refreshKey = GlobalKey<RefreshIndicatorState>();
GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
List<Verification> Verifications;

class VerificationsPage extends StatefulWidget {
  _VerificationsPageState createState() => _VerificationsPageState();
}

class _VerificationsPageState extends State<VerificationsPage> {
  final _SearchDemoSearchDelegate _delegate = new _SearchDemoSearchDelegate();
  Verification selectedEquipment;
  var _verificationsCount = 0;
  var _verifiedAssetsCount = 0;
  var _verifiedValue = 0;

  Future<List<Verification>> getList() async {
    await db.GetVerificationsFromServer();

    Verifications = db.Verifications;

    setState(() {
      _verificationsCount = Verifications.length;
      _verifiedAssetsCount =
          Verifications.map((f) => f.AssetNumber).toSet().length;
      _verifiedValue = 0;
    });

    return Verifications;
  }

  static void refreshList(BuildContext context) {
    //db.DeleteEqdb();
    //Navigator.pop(context);
    Verifications = null;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(" Verifications "),
        actions: <Widget>[
          new IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () async {
              final Verification selected = await showSearch<Verification>(
                context: context,
                delegate: _delegate,
              );
              if (selected != null && selected != selectedEquipment) {
                setState(() {
                  selectedEquipment = selected;
                });
              }
            },
          ),
        ],
      ),
      body: VerificationsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<Null>(
            context: context,
            builder: (BuildContext) => new DetailsDrawer(
                _verificationsCount, _verifiedAssetsCount, _verifiedValue),
          );
        },
        child: Icon(Icons.pie_chart),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: new CustomBottomAppBar(
        color: Colors.white,
        fabLocation: FloatingActionButtonLocation.endFloat,
        shape: CircularNotchedRectangle(),
      ),
    );
  }

  FutureBuilder<List<Verification>> VerificationsList() {
    return FutureBuilder<List<Verification>>(
      future: getList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var v = snapshot.data;
          return new ListView.builder(
            itemCount: v == null ? 0 : v.length,
            itemBuilder: (BuildContext context, int index) {
              return new ListTile(
                title: new Text(
                  v[index].AssetNumber + " | " + v[index].EquipmentNumber,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(v[index].AssetDescription),
                dense: true,
                leading: CircleAvatar(
                  child: AvtarIcon(v, index),
                ),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext) =>
                          new VerificationDetailsPage(verification: v[index])));
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
    );
  }

  Icon AvtarIcon(List<Verification> v, int index) {
    if (v[index].Type.substring(0, 1) == "P") {
      return new Icon(Icons.camera_alt);
    } else {
      return new Icon(Icons.person);
    }
  }
}

//------------------------------------  Search  ------------------

class _SearchDemoSearchDelegate extends SearchDelegate<Verification> {
  final List<Verification> _history = <Verification>[];

  @override
  Widget buildLeading(BuildContext context) {
    return new IconButton(
      tooltip: 'Back',
      icon: new AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Iterable<Verification> suggestions =
        query.isEmpty ? _history : SearchEquipments(query);
    return new _SuggestionList(
      query: query,
      suggestions: suggestions.toList(),
      onSelected: (String suggestion) {
        query = suggestion;
        showResults(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Verification> finalequip = SearchEquipments(query);

    if (finalequip == null || finalequip.length < 0) {
      return new Center(
        child: new Text(
          "Your Search Returned no Results",
          textAlign: TextAlign.center,
        ),
      );
    }
    final ThemeData theme = Theme.of(context);
    return new ListView.builder(
      itemCount: finalequip.length,
      itemBuilder: (BuildContext context, int i) {
        final Verification suggestion = finalequip[i];
        return new ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          title: new RichText(
            text: new TextSpan(
              text: suggestion.AssetNumber.substring(0, query.length),
              style:
                  theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                new TextSpan(
                  text: suggestion.AssetNumber.substring(query.length),
                  style: theme.textTheme.subhead,
                ),
              ],
            ),
          ),
          subtitle: Text(finalequip[i].AssetDescription),
          onTap: () {
            this.close(context, finalequip[i]);
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext) =>
                    new VerificationDetailsPage(verification: finalequip[i])));
          },
        );
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? new IconButton(
              tooltip: 'Voice Search',
              icon: const Icon(Icons.mic),
              onPressed: () {
                query = 'TODO: implement voice input';
              },
            )
          : new IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
    ];
  }

  List<Verification> SearchEquipments(String sq) {
    if (sq != null) {
      var ss = Verifications.where((Verification i) =>
          (i != null &&
              i.EquipmentNumber != null &&
              i.EquipmentNumber.toLowerCase().contains(sq.toLowerCase())) ||
          (i != null &&
              i.AssetDescription != null &&
              i.AssetDescription.toLowerCase().contains(sq.toLowerCase())) ||
          (i != null &&
              i.AssetNumber != null &&
              i.AssetNumber.toLowerCase().contains(sq.toLowerCase())));

      if (ss != null) {
        return ss.toList();
      }
    }
    return null;
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<Verification> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i].AssetNumber;
        return new ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          subtitle: Text(suggestions[i].AssetDescription),
          title: Text(suggestion),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}

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
      // new IconButton(
      //   icon: const Icon(Icons.menu),
      //   onPressed: () {
      //     showModalBottomSheet<Null>(
      //       context: context,
      //       builder: (BuildContext context) => const CustomSettingsDrawer(),
      //     );
      //   },
      // ),
    ];

    // if (kCenterLocations.contains(fabLocation)) {
    //   rowContents.add(
    //     const Expanded(child: SizedBox()),
    //   );
    // }

    // rowContents.addAll(<Widget>[
    //   new IconButton(
    //     icon: const Icon(Icons.refresh),
    //     onPressed: () {
    //       Scaffold.of(context).showSnackBar(
    //         const SnackBar(content: Text('Updating database....')),
    //       );
    //       Verifications.clear();
    //       _VerificationsPageState.refreshList(context);
    //     },
    //   ),
    // ]);

    return new BottomAppBar(
      color: color,
      child: new Row(children: rowContents),
      shape: shape,
    );
  }
}

class CustomSettingsDrawer extends StatelessWidget {
  const CustomSettingsDrawer();

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
    await db.DeleteEqdb();
    await db.GetEquipmentsFromServer();
    await db.SaveEquipmentToStorage();
  }
}

class DetailsDrawer extends StatelessWidget {
  final verificationCount;
  final verifiedAssetsCount;
  final verifiedValue;

  const DetailsDrawer(
      this.verificationCount, this.verifiedAssetsCount, this.verifiedValue);

  @override
  Widget build(BuildContext context) {
    return new Drawer(
        elevation: 10.0,
        child: Container(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "DETAILS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              Divider(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "NUMBER OF VERIFICATIONS :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      verificationCount.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "NUMBER OF ASSETS VERIFIED :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      verifiedAssetsCount.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
