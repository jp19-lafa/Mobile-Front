import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  String email;
  String password;

  Login({
    this.email,
    this.password,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}


Refresh refreshFromJson(String str) => Refresh.fromJson(json.decode(str));

String refreshToJson(Refresh data) => json.encode(data.toJson());

class Refresh {
  String refresh;

  Refresh({
    this.refresh,
  });

  factory Refresh.fromJson(Map<String, dynamic> json) => Refresh(
        refresh: json["refresh"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
      };
}


Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
  String jwt;
  String refresh;

  Token({
    this.jwt,
    this.refresh,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        jwt: json["jwt"],
        refresh: json["refresh"],
      );

  Map<String, dynamic> toJson() => {
        "jwt": jwt,
        "refresh": refresh,
      };
}
