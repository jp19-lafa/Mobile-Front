import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

UserDetails userDetailsFromJson(String str) =>
    UserDetails.fromJson(json.decode(str));

String userDetailsToLoginJson(UserDetails data) =>
    json.encode(data.toLoginJson());

String userDetailsToRegisterJson(UserDetails data) =>
    json.encode(data.toRegisterJson());

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

  Map<String, dynamic> toLoginJson() => {
        "email": email,
        "password": password,
      };

  Map<String, dynamic> toRegisterJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
      };
}

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

String tokenToRefreshJson(Token data) => json.encode(data.toRefreshJson());

class Token {
  String jwt;
  String refresh;

  Token({this.jwt = '', this.refresh = ''});

  Future<void> store() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString('token', jwt);
    preferences.setString('refresh', refresh);
  }

  Future<void> load() async {
    final preferences = await SharedPreferences.getInstance();
    jwt = preferences.getString('token');
    refresh = preferences.getString('refresh');
    if (jwt == null) {
      jwt = '';
      refresh = '';
    }
  }

  Future<void> clear() async {
    jwt = '';
    refresh = '';
    store();
  }

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        jwt: json["jwt"],
        refresh: json["refresh"],
      );

  Map<String, dynamic> toJson() => {
        "jwt": jwt,
        "refresh": refresh,
      };

  Map<String, dynamic> toRefreshJson() => {
        "refresh": refresh,
      };
}
