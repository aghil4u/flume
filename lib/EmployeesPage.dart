import 'EmployeeDetailsPage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'Model/Employee.dart';
import 'Model/db.dart';

var refreshKey = GlobalKey<RefreshIndicatorState>();
List<Employee> employees;

class EmployeesPage extends StatefulWidget {
  _EmployeesPageState createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  final _SearchDemoSearchDelegate _delegate = new _SearchDemoSearchDelegate();
  Employee selectedEmployee;

  static Future<List<Employee>> getList() async {
    if (employees == null) {
      await Future.delayed(Duration(seconds: 1));

      if (await db.GetEmployeesFromStorage() == false) {
        await db.GetEmployeesFromServer();
        await db.SaveEmployeesToStorage();
      }

      employees = db.Employees;
    }

    return employees;
  }

  static void refreshList(BuildContext context) {
    db.DeleteRecords();
    //Navigator.pop(context);
    employees = null;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("MWS EMPLOYEES"),
        actions: <Widget>[
          new IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search),
            onPressed: () async {
              final Employee selected = await showSearch<Employee>(
                context: context,
                delegate: _delegate,
              );
              if (selected != null && selected != selectedEmployee) {
                setState(() {
                  selectedEmployee = selected;
                });
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Employee>>(
        future: getList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var Employee = snapshot.data;
            return new ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: Employee == null ? 0 : Employee.length,
              itemBuilder: (BuildContext context, int index) {
                return new ListTile(
                  title: new Text(
                    Employee[index].Name,
                    style: new TextStyle(fontWeight: FontWeight.bold),
                  ),
                  dense: true,
                  isThreeLine: false,
                  subtitle: Text(Employee[index].EmployeeNumber +
                      " | " +
                      Employee[index].Designation),
                  leading: CircleAvatar(
                    child: Icon(Icons.perm_identity),
                  ),
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext) => new EmployeeDetailsPage(
                            employee: Employee[index])));
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

class _SearchDemoSearchDelegate extends SearchDelegate<Employee> {
  final List<Employee> _history = <Employee>[];

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
    final Iterable<Employee> suggestions =
        query.isEmpty ? _history : SearchEmployees(query);
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
    final List<Employee> finalequip = SearchEmployees(query);

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
        final Employee suggestion = finalequip[i];
        return new ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          title: new RichText(
            text: new TextSpan(
              text: suggestion.Name.substring(0, query.length),
              style:
                  theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                new TextSpan(
                  text: suggestion.Name.substring(query.length),
                  style: theme.textTheme.subhead,
                ),
              ],
            ),
          ),
          onTap: () {
            this.close(context, finalequip[i]);
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext) =>
                    new EmployeeDetailsPage(employee: finalequip[i])));
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

  List<Employee> SearchEmployees(String sq) {
    if (sq != null) {
      var ss = employees.where((Employee i) =>
          (i != null &&
              i.Name != null &&
              i.Name.toLowerCase().contains(sq.toLowerCase())) ||
          (i != null &&
              i.EmployeeNumber != null &&
              i.EmployeeNumber.toLowerCase().contains(sq.toLowerCase())));

      if (ss != null) {
        return ss.toList();
      }
    }
    return null;
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<Employee> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i].Name;
        return new ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          title: new RichText(
            text: new TextSpan(
              text: suggestion.substring(0, query.length),
              style:
                  theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                new TextSpan(
                  text: suggestion.substring(query.length),
                  style: theme.textTheme.subhead,
                ),
              ],
            ),
          ),
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
          employees.clear();
          _EmployeesPageState.refreshList(context);
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
    await db.DeleteRecords();
    await db.GetEmployeesFromServer();
    await db.SaveEmployeesToStorage();
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
              title: Text("ADCO"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("ADMA"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("ZADCO"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("TOTAL"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("BUNDUQ"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("INDIA"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("KUWAIT"),
              onChanged: (bool value) {
                TypeFilter(this);
              },
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              value: false,
            ),
            CheckboxListTile(
              title: Text("CALL OUT"),
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
