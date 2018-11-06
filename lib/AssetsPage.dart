import 'package:flutter/material.dart';
import 'dart:async';
import 'AssetDetailsPage.dart';
import 'Model/Equipment.dart';
import 'Model/db.dart';

var refreshKey = GlobalKey<RefreshIndicatorState>();
List<Equipment> equipments;

class AssetsPage extends StatefulWidget {
  _AssetsPageState createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  final _SearchDemoSearchDelegate _delegate = new _SearchDemoSearchDelegate();
  Equipment selectedEquipment;

  static Future<List<Equipment>> getList() async {
    if (equipments == null) {
      await Future.delayed(Duration(seconds: 1));

      if (await db.GetEquipmentsFromStorage() == false) {
        await db.GetEquipmentsFromServer();
        await db.SaveEquipmentToStorage();
      }
      equipments = db.Equipments;
    }

    return equipments;
  }

  static void refreshList(BuildContext context) {
    db.DeleteEqdb();
    //Navigator.pop(context);
    equipments = null;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ASSET MASTER"),
        actions: <Widget>[
          new IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () async {
              final Equipment selected = await showSearch<Equipment>(
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
      body: FutureBuilder<List<Equipment>>(
        future: getList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var equipment = snapshot.data;
            return new ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: equipment == null ? 0 : equipment.length,
              itemBuilder: (BuildContext context, int index) {
                return new ListTile(
                  dense: true,
<<<<<<< HEAD
                  title: new Text(
                    equipment[index].EquipmentNumber +
                        " | " +
                        equipment[index].AssetNumber,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
=======
                  title: new Text(equipment[index].EquipmentNumber + " | " + equipment[index].AssetNumber, style: TextStyle( fontWeight: FontWeight.bold),),
>>>>>>> 75c61522f4522312b2b82fc9d22d0125015499d1
                  subtitle: Text(equipment[index].AssetDescription),
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
        onPressed: () {
          showModalBottomSheet<Null>(
            context: context,
            builder: (BuildContext context) => const FilterDrawer(),
          );
        },
        child: Icon(Icons.sort),
        backgroundColor: Colors.blueAccent,
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

//------------------------------------  Search  ------------------

class _SearchDemoSearchDelegate extends SearchDelegate<Equipment> {
  final List<Equipment> _history = <Equipment>[];

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
    final Iterable<Equipment> suggestions =
        query.isEmpty ? _history : SearchEquipments(query);
    return new _SuggestionList(
      query: query,
      suggestions: suggestions.toList(),
      onSelected: (Equipment suggestion) {
        close(context, suggestion);
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext) =>
                new AssetDetailsPage(equipment: suggestion)));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Equipment> finalequip = SearchEquipments(query);

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
        final Equipment suggestion = finalequip[i];
        return new ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          title: Text(suggestion.AssetDescription),
          subtitle: Text(
            suggestion.EquipmentNumber + " | " + suggestion.OperationId,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            this.close(context, finalequip[i]);
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext) =>
                    new AssetDetailsPage(equipment: finalequip[i])));
          },
        );
      },
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      new IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  List<Equipment> SearchEquipments(String sq) {
    if (sq != null) {
      List<Equipment> ss = equipments
          .where((Equipment i) =>
              (i != null &&
                  i.AssetDescription != null &&
                  i.AssetDescription.toLowerCase()
                      .contains(sq.toLowerCase())) ||
              (i != null &&
                  i.AssetNumber != null &&
                  i.AssetNumber.contains(sq)) ||
              (i != null &&
                  i.OperationId != null &&
                  i.OperationId.toLowerCase().contains(sq.toLowerCase())))
          .toList();

      if (ss != null) {
        return ss;
      }
    }
    return null;
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<Equipment> suggestions;
  final String query;
  final ValueChanged<Equipment> onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final Equipment suggestion = suggestions[i];
        return new ListTile(
          leading: query.isEmpty
              ? const Icon(Icons.history)
              : const Icon(Icons.history),
          title: Text(suggestion.AssetDescription),
          subtitle: Text(
            suggestion.EquipmentNumber + " | " + suggestion.OperationId,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            onSelected(suggestions[i]);
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
      new IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          showModalBottomSheet<Null>(
            context: context,
            builder: (BuildContext context) => const CustomSettingsDrawer(),
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
        icon: const Icon(Icons.refresh),
        onPressed: () {
          Scaffold.of(context).showSnackBar(
            const SnackBar(content: Text('Updating database....')),
          );
          equipments.clear();
          _AssetsPageState.refreshList(context);
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

class FilterDrawer extends StatelessWidget {
  const FilterDrawer();

  @override
  Widget build(BuildContext context) {
    return new Drawer(
        elevation: 1.0,
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            CheckboxListTile(
              title: Text("WINCH UNITS"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("POWER PACKS"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("TRUCKS"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("TOOL BOXES"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("TOOL BASKETS"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("LUBRICATORS"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("STUFFING BOXES"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("BLOW POUT PREVENTERS"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("INJECTION SUBS"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("WINCH UNITS"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("POWER PACKS"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("TRUCKS"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("TOOL BOXES"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("TOOL BASKETS"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("LUBRICATORS"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("STUFFING BOXES"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("BLOW POUT PREVENTERS"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("INJECTION SUBS"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
          ],
        ));
  }

  void TypeFilter(FilterDrawer searchDrawer) {}
}
