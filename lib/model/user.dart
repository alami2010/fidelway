import 'dart:convert';

class User {
  final int? id;
  final String login;
  final String? firstName;
  final String? lastName;
  final String email;
  final String? imageUrl;
  final bool activated;
  final String langKey;
  final String? createdBy;
  final DateTime? createdDate;
  final String? lastModifiedBy;
  final DateTime? lastModifiedDate;
  final Set<String> authorities;
  final String? password;

  User({
    this.id,
    required this.login,
    this.firstName,
    this.lastName,
    required this.email,
    this.imageUrl,
    this.activated = false,
    required this.langKey,
    this.createdBy,
    this.createdDate,
    this.lastModifiedBy,
    this.lastModifiedDate,
    required this.authorities,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      login: json['login'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      imageUrl: json['imageUrl'],
      activated: json['activated'] ?? false,
      langKey: json['langKey'],
      createdBy: json['createdBy'],
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : null,
      lastModifiedBy: json['lastModifiedBy'],
      lastModifiedDate: json['lastModifiedDate'] != null
          ? DateTime.parse(json['lastModifiedDate'])
          : null,
      authorities:
          (json['authorities'] as List<dynamic>).cast<String>().toSet(),
      password: json.containsKey('password') ? json['password'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'imageUrl': imageUrl,
      'activated': activated,
      'langKey': langKey,
      'createdBy': createdBy,
      'createdDate': createdDate?.toIso8601String(),
      'lastModifiedBy': lastModifiedBy,
      'lastModifiedDate': lastModifiedDate?.toIso8601String(),
      'authorities': authorities.toList(),
      'password': password != null ? password : null,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
