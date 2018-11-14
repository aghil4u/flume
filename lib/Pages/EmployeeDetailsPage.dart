import 'package:flume/Model/Employee.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

GlobalKey<ScaffoldState> _empScaffoldKey = new GlobalKey();

class EmployeeDetailsPage extends StatefulWidget {
  final Employee employee;
  EmployeeDetailsPage({this.employee});

  @override
  _EmployeeDetailsPageState createState() => _EmployeeDetailsPageState();
}

class _EmployeeDetailsPageState extends State<EmployeeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _empScaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          launch("tel://" + widget.employee.ContactNumber);
        },
        icon: Icon(Icons.call),
        backgroundColor: Colors.blueAccent,
        label: Text("Call"),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.employee.EmployeeNumber,
                ),
              ),
            ),
          ];
        },
        body: ListView(
          children: <Widget>[
            new SizedBox(
              child: new Card(
                elevation: 2.0,
                margin:
                    const EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
                child: new Padding(
                    padding: new EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Text(
                              widget.employee.Name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Divider(),
                        //-------------------------------------------------------------------

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text("EMP NUMBER",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.grey)),
                                Divider(
                                  height: 5.0,
                                ),
                                Text(widget.employee.EmployeeNumber,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text("GLOBAL NUMBER",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.grey)),
                                Divider(
                                  height: 5.0,
                                ),
                                Text(widget.employee.GlobalNumber,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold))
                              ],
                            )
                          ],
                        )
                      ],
                    )),
              ),
            ),
            Divider(
              height: 20.0,
              color: Colors.transparent,
            ),

            //-------------------------------------------------------------------
            SizedBox(
              child: new Card(
                elevation: 2.0,
                margin:
                    const EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
                child: new Padding(
                    padding: new EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Text(
                              "ASSET DETAILS",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                        Divider(
                          height: 30.0,
                        ),
                        Column(
                          children: <Widget>[
//-------------------------------------------------------------------
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("JOINING DATE",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.grey)),
                                Text(widget.employee.JoiningDate,
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black)),
                              ],
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.transparent,
                            ),
//-------------------------------------------------------------------
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("DESIGNATION",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.grey)),
                                Text(widget.employee.Designation.toString(),
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black)),
                              ],
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.transparent,
                            ),
//-------------------------------------------------------------------
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("MOBILE",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.grey)),
                                Text(widget.employee.ContactNumber.toString(),
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black)),
                              ],
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.transparent,
                            ),
//-------------------------------------------------------------------
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("LANDLINE",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.grey)),
                                Text(widget.employee.Landline,
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black)),
                              ],
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.transparent,
                            ),
//-------------------------------------------------------------------
//-------------------------------------------------------------------
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("EMAIL",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.grey)),
                                Text(widget.employee.EmailAddress,
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black)),
                              ],
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.transparent,
                            ),
//-------------------------------------------------------------------
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            Divider(
              height: 20.0,
              color: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

//-----------------------------------------------------------------------------------------------------
// class VerificationDrawer extends StatelessWidget {
//   final Employee e;
//   VerificationDrawer(this.e);

//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       height: 150.0,
//       child: Drawer(
//         child: new Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             GridTile(
//                 child: InkWell(
//               onTap: () async {
//                 File image = await ImagePicker.pickImage(
//                   source: ImageSource.camera,
//                 );
//                 if (image != null && image.path != null) {
//                   Navigator.of(context).pop();
//                   print("---------------trying to upload-------------- ");
//                   var value = await db.compressAndUpload(image);

//                   if (value != null) {
//                     print(value);
//                     Verification v = new Verification(
//                         AssetNumber: e.AssetNumber,
//                         EmployeeNumber: e.EmployeeNumber,
//                         AssetDescription: e.AssetDescription,
//                         Date: DateTime.now().toString(),
//                         ImageUrl: value,
//                         Location: "",
//                         Type: "PhotoVerification",
//                         User: "DefaultUser");
//                     db.PostVerification(v).whenComplete(() {
//                       _empScaffoldKey.currentState.showSnackBar(SnackBar(
//                         content: Text('Yay! Verification Posted'),
//                       ));
//                     });
//                   }
//                 }
//               },
//               child: Column(
//                 children: <Widget>[
//                   Icon(
//                     Icons.camera_alt,
//                     color: Colors.blueAccent,
//                     size: 50.0,
//                   ),
//                   Divider(
//                     height: 5.0,
//                   ),
//                   Text(
//                     "Take Photo",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   )
//                 ],
//                 mainAxisAlignment: MainAxisAlignment.center,
//               ),
//             )),
//             GridTile(
//                 child: InkWell(
//               onTap: () async {
//                 File image = await ImagePicker.pickImage(
//                   source: ImageSource.gallery,
//                 );
//                 if (image != null && image.path != null) {
//                   Navigator.of(context).pop();
//                   print("---------------trying to upload-------------- ");
//                   var value = await db.compressAndUpload(image);

//                   if (value != null) {
//                     print(value);
//                     Verification v = new Verification(
//                         AssetNumber: e.AssetNumber,
//                         EmployeeNumber: e.EmployeeNumber,
//                         AssetDescription: e.AssetDescription,
//                         Date: DateTime.now().toString(),
//                         ImageUrl: value,
//                         Location: "",
//                         Type: "PhotoVerification",
//                         User: "DefaultUser");
//                     db.PostVerification(v).whenComplete(() {
//                       _empScaffoldKey.currentState.showSnackBar(SnackBar(
//                         content: Text('Yay! Verification Posted'),
//                       ));
//                     });
//                   }
//                 }
//               },
//               child: Column(
//                 children: <Widget>[
//                   Icon(
//                     Icons.image,
//                     color: Colors.blueAccent,
//                     size: 50.0,
//                   ),
//                   Divider(
//                     height: 5.0,
//                   ),
//                   Text(
//                     "Select Photo",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   )
//                 ],
//                 mainAxisAlignment: MainAxisAlignment.center,
//               ),
//               splashColor: Colors.pink,
//             )),
//             GridTile(
//                 child: InkWell(
//               onTap: () async {
//                 Verification v = new Verification(
//                     AssetNumber: e.AssetNumber,
//                     EmployeeNumber: e.EmployeeNumber,
//                     AssetDescription: e.AssetDescription,
//                     Date: DateTime.now().toString(),
//                     ImageUrl: "---",
//                     Location: "",
//                     Type: "PointVerification",
//                     User: "DefaultUser");
//                 db.PostVerification(v).whenComplete(() {
//                   _empScaffoldKey.currentState.showSnackBar(SnackBar(
//                     content: Text('Yay! Verification Posted'),
//                   ));
//                 });
//               },
//               child: Column(
//                 children: <Widget>[
//                   Icon(
//                     Icons.no_sim,
//                     color: Colors.blueAccent,
//                     size: 50.0,
//                   ),
//                   Divider(
//                     height: 5.0,
//                   ),
//                   Text(
//                     "No Photo",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   )
//                 ],
//                 mainAxisAlignment: MainAxisAlignment.center,
//               ),
//               splashColor: Colors.pink,
//             )),
//           ],
//         ),
//       ),
//     );
//   }
