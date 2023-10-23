class History {
  int? id;
  int? amout;
  String?  date;
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