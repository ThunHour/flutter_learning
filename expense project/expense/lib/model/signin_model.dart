import 'dart:convert';

Signin signinFromMap(String str) => Signin.fromMap(json.decode(str));

String signinToMap(Signin data) => json.encode(data.toMap());

class Signin {
  Signin({
    required this.uGmail,
    required this.uUsername,
    required this.uPassword,
  });

  String uGmail;
  String uUsername;
  String uPassword;

  factory Signin.fromMap(Map<String, dynamic> json) => Signin(
        uGmail: json["u_gmail"],
        uUsername: json["u_username"],
        uPassword: json["u_password"],
      );

  Map<String, dynamic> toMap() => {
        "u_gmail": uGmail,
        "u_username": uUsername,
        "u_password": uPassword,
      };
}
