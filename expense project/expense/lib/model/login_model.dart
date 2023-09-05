import 'dart:convert';

Login loginFromMap(String str) => Login.fromMap(json.decode(str));

String loginToMap(Login data) => json.encode(data.toMap());

class Login {
  Login({
    required this.uGmail,
    required this.uPassword,
  });

  String uGmail;
  String uPassword;

  factory Login.fromMap(Map<String, dynamic> json) => Login(
        uGmail: json["u_gmail"],
        uPassword: json["u_password"],
      );

  Map<String, dynamic> toMap() => {
        "u_gmail": uGmail,
        "u_password": uPassword,
      };
}
