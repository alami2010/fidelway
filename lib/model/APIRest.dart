import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../local_storage_helper.dart';
import 'Client.dart';

const isLocal = false;
const baseUrl =
    isLocal ? "http://localhost:8080/api/" : "https://go-dance.fr/api/api/";

Map<String, String> buildHeader() {
  return <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };
}

class APIRest {
  static Future<ClientWay> scan(String code) async {
    var offert = LocalStorageHelper.readOffert();
    var count = LocalStorageHelper.readCountVisit();
    var url = '${baseUrl}fidel-way-client/$code';

    final response = await http.get(Uri.parse(url), headers: buildHeader());
    if (response.statusCode == 200) {
      return ClientWay.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erreur lors de get scan');
    }
  }

  static Future<ClientWay> create(String code, String name, String tel) async {
    var url = '${baseUrl}fidel-way-client/';

    Map data = {
      'email': tel,
      'name': name,
      'code': code,
      'solde': 0,
    };

    final response = await http.post(Uri.parse(url),
        body: json.encode(data), headers: buildHeader());
    if (response.statusCode == 201) {
      return ClientWay.fromJson(json.decode(response.body));
    } else {
      //Tools.show("Erreur lors de get agency");
      throw Exception('Erreur lors create carte');
    }
  }

  static Future<ClientWay> minus(String code, int points) async {
    var offert = LocalStorageHelper.readOffert();
    var count = LocalStorageHelper.readCountVisit();
    var url = '${baseUrl}fidel-way-client/$code/$points';

    final response = await http.get(Uri.parse(url), headers: buildHeader());
    if (response.statusCode == 200) {
      return ClientWay.fromJson(json.decode(response.body));
    } else {
      //Tools.show("Erreur lors de get agency");
      throw Exception('Erreur lors de get agency');
    }
  }
}
