import 'package:flume/Model/Verification.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'Model/Equipment.dart';
import 'Model/db.dart';

GlobalKey<ScaffoldState> _assetDetailsScaffoldKey = new GlobalKey();

class VerificationDetailsPage extends StatefulWidget {
  final Verification verification;
  VerificationDetailsPage({this.verification});

  @override
  _AssetDetailsPageState createState() => _AssetDetailsPageState();
}

class _AssetDetailsPageState extends State<VerificationDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _assetDetailsScaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.delete),
        backgroundColor: Colors.blueAccent,
        label: Text("Delete"),
        onPressed: () async {
          Navigator.of(context).pop();
          db.DeleteVerficationFromServer(widget.verification.id);
        },
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
                  widget.verification.AssetNumber,
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
                              widget.verification.Date,
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
                                Text(widget.verification.Location,
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
                                Text(widget.verification.AssetNumber,
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
                              "IMAGE",
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
                        Image.network(
                          widget.verification.ImageUrl,
                          scale: 1.0,
                          repeat: ImageRepeat.noRepeat,
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
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: <Widget>[
                            //     Text("OPERATION ID",
                            //         style: TextStyle(
                            //             fontSize: 15.0, color: Colors.grey)),
                            //     Text(widget.verification.OperationId,
                            //         style: TextStyle(
                            //             fontSize: 15.0, color: Colors.black)),
                            //   ],
                            // ),
                            // Divider(
                            //   height: 10.0,
                            //   color: Colors.transparent,
                            // ),
//-------------------------------------------------------------------
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: <Widget>[
                            //     Text("EQUIPMENT TYPE",
                            //         style: TextStyle(
                            //             fontSize: 15.0, color: Colors.grey)),
                            //     Text(widget.verification.SubType,
                            //         style: TextStyle(
                            //             fontSize: 15.0, color: Colors.black)),
                            //   ],
                            // ),
                            // Divider(
                            //   height: 10.0,
                            //   color: Colors.transparent,
                            // ),
//-------------------------------------------------------------------
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: <Widget>[
                            //     Text("MODEL NUMBER",
                            //         style: TextStyle(
                            //             fontSize: 15.0, color: Colors.grey)),
                            //     Text(widget.verification.ModelNumber,
                            //         style: TextStyle(
                            //             fontSize: 15.0, color: Colors.black)),
                            //   ],
                            // ),
                            // Divider(
                            //   height: 10.0,
                            //   color: Colors.transparent,
                            // ),
//-------------------------------------------------------------------
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: <Widget>[
                            //     Text("SERIAL NUMBER",
                            //         style: TextStyle(
                            //             fontSize: 15.0, color: Colors.grey)),
                            //     Text(widget.verification.SerialNumber,
                            //         style: TextStyle(
                            //             fontSize: 15.0, color: Colors.black)),
                            //   ],
                            // ),
                            // Divider(
                            //   height: 10.0,
                            //   color: Colors.transparent,
                            // ),
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
