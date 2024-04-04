class Tokens {
  String token;
  Tokens({required this.token});

  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(token: json['token']);
  }

  Map<String, dynamic> toJson() {
    return {'token': token};
  }

  factory Tokens.empty() {
    return Tokens(token: "");
  }
}
