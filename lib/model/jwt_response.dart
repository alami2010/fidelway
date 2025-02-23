class JwtResponse {
  String? token;

  JwtResponse({this.token});

  JwtResponse.fromJson(Map<String, dynamic> json) {
    token = json['id_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_token'] = token;

    return data;
  }

  @override
  String toString() {
    return 'JwtResponse{token: $token}';
  }
}
