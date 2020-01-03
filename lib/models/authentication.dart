import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

UserDetails userDetailsFromJson(String str) => UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
    String firstname;
    String lastname;
    String email;
    String password;

    UserDetails({
        this.firstname,
        this.lastname,
        this.email,
        this.password,
    });

    factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "firstname": firstname == null ? null : firstname,
        "lastname": lastname == null ? null : lastname,
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

  Future<void> store() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', jwt);
    prefs.setString('refresh', refresh);
  }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    jwt = prefs.getString('token');
    refresh = prefs.getString('refresh');
  }

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        jwt: json["jwt"],
        refresh: json["refresh"],
      );

  Map<String, dynamic> toJson() => {
        "jwt": jwt,
        "refresh": refresh,
      };
}
