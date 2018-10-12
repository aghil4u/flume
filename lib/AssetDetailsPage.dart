import 'package:flume/Model/Verification.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'Model/Equipment.dart';
import 'Model/db.dart';

GlobalKey<ScaffoldState> _assetDetailsScaffoldKey = new GlobalKey();

class AssetDetailsPage extends StatefulWidget {
  final Equipment equipment;
  AssetDetailsPage({this.equipment});

  @override
  _AssetDetailsPageState createState() => _AssetDetailsPageState();
}

class _AssetDetailsPageState extends State<AssetDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _assetDetailsScaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet<Null>(
            builder: (BuildContext context) =>
                VerificationDrawer(widget.equipment),
            context: context,
          );
        },
        icon: Icon(Icons.verified_user),
        backgroundColor: Colors.blueAccent,
        label: Text("Verify"),
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
                  widget.equipment.EquipmentNumber,
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
                              widget.equipment.EquipmentDescription,
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
                                Text("SAP EIN",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.grey)),
                                Divider(
                                  height: 5.0,
                                ),
                                Text(widget.equipment.EquipmentNumber,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text("ASSET",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.grey)),
                                Divider(
                                  height: 5.0,
                                ),
                                Text(widget.equipment.AssetNumber,
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
                                Text("ACQUISITION DATE",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.grey)),
                                Text(widget.equipment.AcquisitionDate,
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
                                Text("ACQUISITION VALUE",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.grey)),
                                Text(
                                    widget.equipment.AcquisitionValue
                                            .toString() +
                                        " AED",
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
                                Text("BOOK VALUE",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.grey)),
                                Text(
                                    widget.equipment.BookValue.toString() +
                                        " AED",
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
                                Text("ASSET LOCATION",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.grey)),
                                Text(widget.equipment.AssetLocation,
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
                        //-------------------------------------------------------------------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Text(
                              "EQUIPMENT DETAILS",
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
                                Text("OPERATION ID",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.grey)),
                                Text(widget.equipment.OperationId,
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
                                Text("EQUIPMENT TYPE",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.grey)),
                                Text(widget.equipment.SubType,
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
                                Text("MODEL NUMBER",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.grey)),
                                Text(widget.equipment.ModelNumber,
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
                                Text("SERIAL NUMBER",
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.grey)),
                                Text(widget.equipment.SerialNumber,
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
          ],
        ),
      ),
    );
  }
}

//-----------------------------------------------------------------------------------------------------
class VerificationDrawer extends StatelessWidget {
  final Equipment e;
  VerificationDrawer(this.e);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 150.0,
      child: Drawer(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GridTile(
                child: InkWell(
              onTap: () async {
                File image = await ImagePicker.pickImage(
                  source: ImageSource.camera,
                );
                if (image.path != null) {
                  Navigator.of(context).pop();
                  print("---------------trying to upload-------------- ");
                  var value = await db.UploadImage(image);

                  if (value != null) {
                    print(value);
                    Verification v = new Verification(
                        AssetNumber: e.AssetNumber,
                        Date: DateTime.now().toString(),
                        ImageUrl: value,
                        Location: "",
                        Type: "PhotoVerification",
                        User: "DefaultUser");
                    db.PostVerification(v).whenComplete(() {
                      _assetDetailsScaffoldKey.currentState
                          .showSnackBar(SnackBar(
                        content: Text('Yay! Verification Posted'),
                      ));
                    });
                  }
                }
              },
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.camera_alt,
                    color: Colors.blueAccent,
                    size: 50.0,
                  ),
                  Divider(
                    height: 5.0,
                  ),
                  Text(
                    "Take Photo",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            )),
            GridTile(
                child: InkWell(
              onTap: () async {
                File image = await ImagePicker.pickImage(
                  source: ImageSource.gallery,
                );
                if (image.path != null) {
                  Navigator.of(context).pop();
                  print("---------------trying to upload-------------- ");
                  db.UploadImage(image).then((value) {
                    if (value != null) {
                      Verification v = new Verification(
                          AssetNumber: e.AssetNumber,
                          Date: DateTime.now().toString(),
                          ImageUrl: value,
                          Location: "",
                          Type: "PhotoVerification",
                          User: "DefaultUser");
                      db.PostVerification(v).whenComplete(() {
                        _assetDetailsScaffoldKey.currentState
                            .showSnackBar(SnackBar(
                          content: Text('Yay! Verification Posted'),
                        ));
                      });
                    }
                  });
                }
              },
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.image,
                    color: Colors.blueAccent,
                    size: 50.0,
                  ),
                  Divider(
                    height: 5.0,
                  ),
                  Text(
                    "Select Photo",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              splashColor: Colors.pink,
            )),
            GridTile(
                child: InkWell(
              onTap: () async {
                Verification v = new Verification(
                    AssetNumber: e.AssetNumber,
                    Date: DateTime.now().toString(),
                    ImageUrl: "---",
                    Location: "",
                    Type: "PointVerification",
                    User: "DefaultUser");
                db.PostVerification(v).whenComplete(() {
                  _assetDetailsScaffoldKey.currentState.showSnackBar(SnackBar(
                    content: Text('Yay! Verification Posted'),
                  ));
                });
              },
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.no_sim,
                    color: Colors.blueAccent,
                    size: 50.0,
                  ),
                  Divider(
                    height: 5.0,
                  ),
                  Text(
                    "No Photo",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              splashColor: Colors.pink,
            )),
          ],
        ),
      ),
    );
  }
}
