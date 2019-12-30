import 'dart:convert';

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


Refrech refrechFromJson(String str) => Refrech.fromJson(json.decode(str));

String refrechToJson(Refrech data) => json.encode(data.toJson());

class Refrech {
    String refresh;

    Refrech({
        this.refresh,
    });

    factory Refrech.fromJson(Map<String, dynamic> json) => Refrech(
        refresh: json["refresh"],
    );

    Map<String, dynamic> toJson() => {
        "refresh": refresh,
    };
}
