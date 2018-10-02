import 'dart:async';
import 'Equipment.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class db {
  static List<Equipment> Equipments;

  static List<Equipment> DecodeEquipments(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Equipment>((json) => Equipment.fromJson(json)).toList();
  }

  static String EncodeEquipments() {
    final parsed = json.encode(Equipments);
    print("---------------data decoded-----------");
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
}
