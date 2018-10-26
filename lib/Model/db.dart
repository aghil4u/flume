import 'dart:async';
import 'package:async/async.dart';
import 'package:flume/Model/Verification.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'Employee.dart';
import 'Equipment.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'dart:math' as Math;

class db {
  static List<Equipment> Equipments;
  static List<Verification> Verifications;
  static List<Employee> Employees;

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

  static List<Employee> DecodeEmployees(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Employee>((json) => Employee.fromJson(json)).toList();
  }

  static String EncodeEquipments() {
    final parsed = json.encode(Equipments);
    print("---------------data decoded-----------");
    return parsed;
  }

  static String EncodeEmployees() {
    final parsed = json.encode(Employees);
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
    print(response.body.length);
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

  static Future<bool> GetEmployeesFromServer() async {
    print("---------------geting data from server-----------");
    http.Client client = new http.Client();
    final response = await client.get("http://xo.rs/api/Employees",
        headers: {"Accept": "application/json"});
    // print(response.body.length);
    print("---------------data downloaded-----------");
    Employees = DecodeEmployees(response.body);
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
      final file = await EquipmentsFile;
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

  static Future<bool> GetEmployeesFromStorage() async {
    try {
      print("---------------reding from storage-----------");
      final file = await EmployeesFile;
      bool exists = await file.exists();
      if (exists) {
        try {
          String contents = await file.readAsString();
          Employees = DecodeEmployees(contents);
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
      final file = await EquipmentsFile;
      file.writeAsString(EncodeEquipments().toString());
      print("---------------Local Database Updated-----------");
    } catch (e) {
      print(e.toString());
    }

    return true;
  }

  static Future<bool> SaveEmployeesToStorage() async {
    try {
      final file = await EmployeesFile;
      file.writeAsString(EncodeEmployees().toString());
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

  static Future<File> get EquipmentsFile async {
    final path = await _localPath;
    return new File('$path/EquipmentStorage.db');
  }

  static Future<File> get EmployeesFile async {
    final path = await _localPath;
    return new File('$path/EmployeeStorage.db');
  }

  static Future<bool> DeleteRecords() async {
    try {
      final file = await EquipmentsFile;
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

  static Future<String> compressAndUpload(File imageFile) async {
    final tempDir = await getTemporaryDirectory();
    int rand = new Math.Random().nextInt(10000);
    CompressObject compressObject =
        new CompressObject(imageFile, tempDir.path, rand);
    String filePath = await _compressImage(compressObject);
    File file = new File(filePath);
    return UploadImage(file);
  }

  static String decodeImage(CompressObject object) {
    Im.Image image = Im.decodeImage(object.imageFile.readAsBytesSync());
    Im.Image smallerImage = Im.copyResize(
        image, 1024); // choose the size here, it will maintain aspect ratio
    var decodedImageFile = new File(object.path + '/img_${object.rand}.jpg');
    decodedImageFile.writeAsBytesSync(Im.encodeJpg(smallerImage, quality: 85));
    return decodedImageFile.path;
  }

  static Future<String> _compressImage(CompressObject object) async {
    return compute(decodeImage, object);
  }
}

class CompressObject {
  File imageFile;
  String path;
  int rand;

  CompressObject(this.imageFile, this.path, this.rand);
}
