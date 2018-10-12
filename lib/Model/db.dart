import 'dart:async';
import 'package:async/async.dart';
import 'package:flume/Model/Verification.dart';
import 'package:path/path.dart';

import 'Equipment.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class db {
  static List<Equipment> Equipments;
  static List<Verification> Verifications;

  static List<Equipment> DecodeEquipments(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Equipment>((json) => Equipment.fromJson(json)).toList();
  }

  static List<Verification> DecodeVerifications(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Verification>((json) => Verification.fromJson(json))
        .toList();
  }

  static String EncodeEquipments() {
    final parsed = json.encode(Equipments);
    print("---------------data decoded-----------");
    return parsed;
  }

  static String EncodeVerification(Verification verification) {
    final parsed = json.encode(verification);
    print("---------------data encoded-----------");
    return parsed;
  }

  static Future<bool> GetEquipmentsFromServer() async {
    print("---------------geting data from server-----------");
    http.Client client = new http.Client();
    final response = await client.get("http://xo.rs/api/Equipments",
        headers: {"Accept": "application/json"});
    // print(response.body.length);
    print("---------------data downloaded-----------");
    Equipments = DecodeEquipments(response.body);
    return true;
  }

  static Future<bool> GetVerificationsFromServer() async {
    print("---------------geting data from server-----------");
    http.Client client = new http.Client();
    final response = await client.get("http://xo.rs/api/Verifications",
        headers: {"Accept": "application/json"});
    // print(response.body.length);
    print("---------------data downloaded-----------");
    Verifications = DecodeVerifications(response.body);
    return true;
  }

  static Future<bool> DeleteVerficationFromServer(int id) async {
    print("---------------trying to delete verification-----------");
    http.Client client = new http.Client();
    final response = await client.delete(
      "http://xo.rs/api/Verifications/" + id.toString(),
    );
    print(response.reasonPhrase);
    print("---------------data deleted-----------");

    return true;
  }

  static Future<bool> GetEquipmentsFromStorage() async {
    try {
      print("---------------reding from storage-----------");
      final file = await _localFile;
      bool exists = await file.exists();
      if (exists) {
        try {
          String contents = await file.readAsString();
          Equipments = DecodeEquipments(contents);
        } catch (e) {
          print(e.toString());
          file.deleteSync();
          print("-------------deleted corrupted database--------------");
          return false;
        }
      } else {
        print("---------------no data in storage-----------");
        return false;
      }
    } catch (e) {}

    return true;
  }

  static Future<bool> SaveEquipmentToStorage() async {
    try {
      final file = await _localFile;
      file.writeAsString(EncodeEquipments().toString());
      print("---------------Local Database Updated-----------");
    } catch (e) {
      print(e.toString());
    }

    return true;
  }

  static Future<bool> PostVerification(Verification v) async {
    try {
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request =
          await httpClient.postUrl(Uri.parse("http://xo.rs/api/Verifications"));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(v)));
      HttpClientResponse response = await request.close();
      // todo - you should check the response.statusCode
      String reply = await response.transform(utf8.decoder).join();
      httpClient.close();
      print(reply);
      print("---------------Verification Uploaded-----------");
    } catch (e) {
      print(e.toString());
    }

    return true;
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return new File('$path/localStorage.db');
  }

  static Future<bool> DeleteRecords() async {
    try {
      final file = await _localFile;
      bool exists = await file.exists();
      print("---------------deleting File-----------");
      if (exists) {
        file.deleteSync();
      } else {
        return false;
      }
    } catch (e) {}

    return true;
  }

  static Future<String> UploadImage(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse("http://xo.rs/api/image/");

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));

    request.files.add(multipartFile);
    var response = await request.send();
    print(response.reasonPhrase);
    var data = await response.stream.transform(utf8.decoder).first;
    String msg = "http://xo.rs/" +
        json
            .decode(data.toString())["filePath"]
            .toString()
            .split('\\wwwroot\\')[2];
    return (msg);
  }
}
