class ChoiceResult {
  int? id;
  int? solde;
  String? email;
  String? name;
  String? code;
  List<Choices>? choices;
  List<History>? history;

  ChoiceResult(
      {this.id,
      this.solde,
      this.email,
      this.name,
      this.code,
      this.choices,
      this.history});

  ChoiceResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    solde = json['solde'];
    email = json['email'];
    name = json['name'];
    code = json['code'];
    if (json['choices'] != null) {
      choices = <Choices>[];
      json['choices'].forEach((v) {
        choices!.add(new Choices.fromJson(v));
      });
    }
    if (json['history'] != null) {
      history = <History>[];
      json['history'].forEach((v) {
        history!.add(new History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['solde'] = this.solde;
    data['email'] = this.email;
    data['name'] = this.name;
    data['code'] = this.code;
    if (this.choices != null) {
      data['choices'] = this.choices!.map((v) => v.toJson()).toList();
    }
    if (this.history != null) {
      data['history'] = this.history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Choices {
  int? id;
  String? choice;
  int? points;
  String? image;

  Choices({this.id, this.choice, this.points, this.image});

  Choices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    choice = json['choice'];
    points = json['points'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['choice'] = this.choice;
    data['points'] = this.points;
    data['image'] = this.image;
    return data;
  }
}

class History {
  int? id;
  int? amout;
  String? date;
  int? idClient;

  History({this.id, this.amout, this.date, this.idClient});

  History.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amout = json['amout'];
    date = json['date'];
    idClient = json['idClient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amout'] = this.amout;
    data['date'] = this.date;
    data['idClient'] = this.idClient;
    return data;
  }
}
