import 'History.dart';

class ClientWay {
  int? id;
  int? solde;
  String? email;
  String? name;
  String? code;
  String? nombre;
  String? offert;
  List<int>? amounts = [];
  List<String>? fastFoodRepas;
  List<String>? pizza;
  List<String>? coiffeur;

  List<History>? history = [];

  ClientWay(
      {this.id,
      this.solde,
      this.email,
      this.name,
      this.code,
      this.nombre,
      this.offert,
      this.amounts,
      this.history});

  ClientWay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    solde = json['solde'];
    email = json['email'];
    name = json['name'];
    code = json['code'];
    offert = json['offert'];
    nombre = json['nombre'];
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history?.add(History.fromJson(v));
      });
    }
    amounts = json['amounts'].cast<int>();
    fastFoodRepas = json['fastFoodRepas'].cast<String>();
    pizza = json['pizza'].cast<String>();
    coiffeur = json['coiffeur'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['solde'] = solde;
    data['email'] = email;
    data['name'] = name;
    data['code'] = code;
    data['offert'] = offert;
    data['nombre'] = nombre;
    data['amounts'] = amounts;
    data['fastFoodRepas'] = fastFoodRepas;
    data['pizza'] = pizza;
    data['coiffeur'] = coiffeur;

    final history = this.history;
    if (history != null) {
      data['history'] = history.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'Client{id: $id, solde: $solde, email: $email, name: $name, code: $code,  nombre: $nombre,  offert: $offert, amounts: $amounts, history: $history}';
  }
}
