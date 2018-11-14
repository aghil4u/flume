import 'package:flume/Model/Equipment.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'AssetDetailsPage.dart';
import 'package:flume/Services/db.dart';

var refreshKey = GlobalKey<ScaffoldState>();

List<String> FilterOptions;
List<bool> FilterStatus;
List<String> SelectedFilters;

List<Equipment> equipmentsMasterList;
List<Equipment> equipmentsFilterdList;

class AssetsPage extends StatefulWidget {
  _AssetsPageState createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  final _SearchDemoSearchDelegate _delegate = new _SearchDemoSearchDelegate();
  Equipment selectedEquipment;

  @override
  void initState() {
    super.initState();
    getList().then((onValue) {
      setState(() {
        equipmentsFilterdList = onValue;
      });
    });
    InitializeFilters();
  }

  Future<List<Equipment>> getList() async {
    if (equipmentsMasterList == null) {
      await Future.delayed(Duration(seconds: 1));

      if (await db.GetEquipmentsFromStorage() == false) {
        await db.GetEquipmentsFromServer();
        await db.SaveEquipmentToStorage();
      }
      equipmentsMasterList = db.Equipments;
    }

    DoFilter();

    return equipmentsFilterdList;
  }

  static void refreshList(BuildContext context) {
    db.DeleteEqdb();
    //Navigator.pop(context);

    equipmentsMasterList = null;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: refreshKey,
      appBar: new AppBar(
        title: new Text("ASSETS"),
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
                  title: new Text(
                    equipment[index].EquipmentNumber +
                        " | " +
                        equipment[index].AssetNumber,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
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
            builder: (BuildContext) => new FilterDrawer(),
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

  static void DoFilter() {
    if (SelectedFilters.length > 0) {
      equipmentsFilterdList = equipmentsMasterList
          .where((e) => e.SubType == SelectedFilters[0])
          .toList();
    } else {
      equipmentsFilterdList = equipmentsMasterList;
    }
  }

  static void InitializeFilters() {
    FilterOptions = [
      "ROPE SOCKETS",
      "STEM BARS",
      "KNUCKLE JOINTS",
      "SWIVEL JOINTS",
      "HIGH DEVEIATION TOOLS",
      "ACCELERATORS",
      "SHOCK ABSORVERS",
      "CENTRALIZERS",
      "STRING X.OVER",
      "MECHANICAL JARS",
      "HYD JARS",
      "KNUCKLE JARS",
      "TUBULAR JARS ",
      "SPRING JARS",
      "PLUG SUBS AND PRONGS",
      "TESTING VALVES",
      "SAFETY VALVES",
      "SEPERATION SLEVES",
      "LOCKS",
      "HANGERS",
      "GAS LIFT VALVES",
      "KICK OVER TOOLS",
      "SPACERS",
      "PULLING & RUNNING TOOLS",
      "GO DEVIL",
      "WIRE CUTTER",
      "OVERSHOT",
      "SPEARS",
      "BLIND BOX",
      "IMPRESSION BLOCK",
      "WIRE FINDERS",
      "GRABS",
      "MAGNETS ",
      "SELECTIVE SHIFTING TOOLS",
      "NON SELECTIVE SHIFTING TOOLS",
      "GAUGE CUTTERS",
      "TUBING BROACHES",
      "SCRATCHERS",
      "SWAGGING TOOLS",
      "BAILERS AND DUMBERS",
      "TUBING END LOCATORS",
      "TUUBING PERFORATORS ",
      "ANTI BLOW OUT TOOLS",
      "OFFSHORE UNITS",
      "ONSHORE UNITS",
      "PUMPING UNITS",
      "SPOOLING UNITS",
      "HYD GINPOLE",
      "MANUAL GINPOLE",
      "PRESSURE TEST PANELS",
      "BOP AND VALVES CONTROL PANELS",
      "GRASE AND HYD CONTROL PANELS",
      "POWERPACK",
      "TOOL BOX",
      "BASKETS",
      "CRANES",
      "SLINGS ",
      " MANUAL HYDRAULIC FORK LIFTS",
      "TROLLEYS",
      "WIRELINE ACCESSORIES",
      "STUFFING BOX",
      "LUBRICATOR",
      "GREASE INJECTION HEAD ",
      "INJECTION SUB",
      "QUICK TEST SUB",
      "LINE WIPER",
      "TOOL CATCHER",
      "BOP",
      "WELL HEAD ADAPTERS",
      "TOOL TRAP",
      "INHIBITOR SUB",
      "PUMP IN SUB ",
      "COMPUTERS",
      "PROJECTORS ",
      "TELEVESIONS",
      "MOBILE PHONES",
      "LOAD CELLS ",
      "CRANE PANELS",
      "OFFICE - CAMP FURNITURES",
      "WORKSHOP RELATED FURNITURES",
      "KITCHEN FIXTURES",
      "SEDAN CARS",
      "4X4 CARS",
      "PICKUPS",
      "TRUCK UNIT",
      "TRUCK CRANE",
      "FLAT BED TRUCK ",
      "TANKER TRUCK",
      "FORKLIFT",
      "BREATHING APPARATUS",
      "GAS DETECTORS",
      "IVMS-VMD",
      "SCAFFOLDING",
      "DIESEL FUEL TANK",
      "PERTOL FUEL TANK",
      "WATER TANKS",
      "CHIMICAL TANKS ",
      "GENERATORS",
      "COMPRESSORS",
      "FUEL PUMP",
      "WATER PUMP",
      "FUEL STATIONS",
      "FANS",
      "OTHERS"
    ];
    FilterStatus = List.filled(104, false);
    ;
    SelectedFilters = new List<String>();
  }
}
//----------------------------------filter------------------------

class FilterDrawer extends StatefulWidget {
  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: FilterOptions.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return CheckboxListTile(
            dense: false,
            title: Text(FilterOptions[index]),
            value: FilterStatus[index],
            onChanged: (bool newValue) {
              setState(() {
                FilterStatus[index] = newValue;
                if (newValue) {
                  SelectedFilters.add(FilterOptions[index]);
                } else {
                  if (SelectedFilters.contains(FilterOptions[index])) {
                    SelectedFilters.remove(FilterOptions[index]);
                  }
                }
                print(SelectedFilters.length);
                refreshKey?.currentState.setState(() {});
              });
            },
          );
        },
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
      suggestions: suggestions,
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
      List<Equipment> ss = equipmentsMasterList
          .where((Equipment i) =>
              (i != null &&
                  i.AssetDescription != null &&
                  i.AssetDescription.toLowerCase()
                      .contains(sq.toLowerCase())) ||
              (i != null &&
                  i.AssetNumber != null &&
                  i.AssetNumber.contains(sq)) ||
              (i != null &&
                  i.EquipmentNumber != null &&
                  i.EquipmentNumber.contains(sq)) ||
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
          equipmentsMasterList.clear();
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
