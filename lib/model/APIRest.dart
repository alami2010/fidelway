import 'dart:async';
import 'dart:convert';

import 'package:fidelway/model/category.dart';
import 'package:fidelway/model/user.dart';
import 'package:http/http.dart' as http;

import '../shared/local_storage_helper.dart';
import 'Client.dart';
import 'account.dart';
import 'choice_result.dart';
import 'jwt_response.dart';

const isLocal = true;
const baseUrl = isLocal ? "http://localhost:8080/api" : "https://fidelway.enovway.com/api/api";

class APIRest {
  static Map<String, String> buildHeader() {
    var token = LocalStorageHelper.readUserToken();
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  static Future<ChoiceResult> scan(String code) async {
    var idMarchand = LocalStorageHelper.getAccount()?.id ?? 0;
    var url = '$baseUrl/fidel-way-client/v2/$code/$idMarchand';

    final response = await http.get(Uri.parse(url), headers: buildHeader());
    if (response.statusCode == 200) {
      return ChoiceResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Erreur lors de get scan');
    }
  }

  static Future<JwtResponse> login(String email, String password) async {
    var url = "$baseUrl/authenticate";
    Map data = {
      'username': email,
      'password': password,
    };

    var response = await http.post(Uri.parse(url), headers: buildHeader(), body: jsonEncode(data));

    if (response.statusCode == 200) {
      return JwtResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login.');
    }
  }

  static Future<http.Response> signUp(User user) async {
    var url = "$baseUrl/register";
    var response = await http.post(Uri.parse(url), headers: buildHeader(), body: jsonEncode(user));
    if (response.statusCode != 201) {
      throw Exception('Failed to login.');
    }
    return response;
  }

  static Future<ClientWay> create(String code, String name, String tel) async {
    var url = '$baseUrl/fidel-way-client/';

    Map data = {
      'email': tel,
      'name': name,
      'code': code,
      'solde': 0,
    };

    final response = await http.post(Uri.parse(url), body: json.encode(data), headers: buildHeader());
    if (response.statusCode == 201) {
      return ClientWay.fromJson(json.decode(response.body));
    } else {
      //Tools.show("Erreur lors de get agency");
      throw Exception('Erreur lors create carte');
    }
  }

  static Future<ChoiceResult> minus(String code, int points) async {
    var idMarchand = LocalStorageHelper.getAccount()?.id ?? 0;

    var url = '$baseUrl/fidel-way-client/v2/$code/$points/$idMarchand';

    final response = await http.get(Uri.parse(url), headers: buildHeader());
    if (response.statusCode == 200) {
      return ChoiceResult.fromJson(json.decode(response.body));
    } else {
      //Tools.show("Erreur lors de get agency");
      throw Exception('Erreur lors de get minus');
    }
  }

  static Future<Account?> getAcount() async {
    var url = '$baseUrl/account';
    final response = await http.get(Uri.parse(url), headers: buildHeader());

    if (response.statusCode == 200) {
      return Account.fromJson(json.decode(response.body));
    } else {
      //Tools.show("Erreur lors de get agency");
      return null;
    }
  }

  static Future<http.Response> saveCategory(Category? selectedCategory) async {
    var url = "$baseUrl/categories";

    var response = await http.post(Uri.parse(url), headers: buildHeader(), body: jsonEncode(selectedCategory));
    if (response.statusCode != 200) {
      throw Exception('Failed to login.');
    }
    return response;
  }

  static Future<String?> generateFlyer() async {
    var url = '$baseUrl/flyer';
    final response = await http.get(Uri.parse(url), headers: buildHeader());

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<Category?> getCategory() async {
    var url = '$baseUrl/categories';
    final response = await http.get(Uri.parse(url), headers: buildHeader());

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return Category.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<JwtResponse> validateGoogleToken(String token) async {
    var url = '$baseUrl/verifyGoogleToken';

    final response = await http.post(
      Uri.parse(url),
      headers: buildHeader(),
      body: jsonEncode({'token': token}),
    );
    if (response.statusCode == 200) {
      return JwtResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login.');
    }
  }

  static Future<void> sendContact({
    required String subject,
    required String message,
    String? phone,
    String? email,
  }) async {
    var url = '$baseUrl/contact';

    final response = await http.post(
      Uri.parse(url),
      headers: buildHeader(),
      body: jsonEncode({
        "subject": subject,
        "message": message,
        if (phone != null && phone.isNotEmpty) "phone": phone,
        if (email != null && email.isNotEmpty) "email": email,
      }),
    );

    if (response.statusCode == 200) {} else {
      throw Exception("Échec de l'envoi du message");
    }
  }

  static Future<void> delete() async {
    var url = '$baseUrl/desactivate';

    final response = await http.delete(
      Uri.parse(url),
      headers: buildHeader(),
    );

    if (response.statusCode == 200) {
      // Suppression réussie, déconnecter l'utilisateur
      LocalStorageHelper.logOut();
    } else {
      throw Exception('Erreur lors de la suppression du compte');
    }
  }

  static Future<void> requestPasswordReset(String email) async {
    var url = '$baseUrl/account/reset-password/init';

    final response = await http.post(
      Uri.parse(url),
      headers: buildHeader(),
      body: email,
    );

    if (response.statusCode == 200) {} else {
      throw Exception('Failed to request password reset: ${response.statusCode}');
    }
  }

  static Future<void> finishPasswordReset(String key, String newPassword) async {
    var url = '$baseUrl/account/reset-password/finish';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'key': key,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode == 200) {} else {
      throw Exception('Failed to complete password reset: ${response.statusCode}');
    }
  }
}
