// To parse this JSON data, do
//
//     final loginPostModel = loginPostModelFromJson(jsonString);

import 'dart:convert';

LoginPostModel loginPostModelFromJson(String str) =>
    LoginPostModel.fromJson(json.decode(str));

String loginPostModelToJson(LoginPostModel data) => json.encode(data.toJson());

class LoginPostModel {
  String email;
  String password;

  LoginPostModel({
    required this.email,
    required this.password,
  });

  factory LoginPostModel.fromJson(Map<String, dynamic> json) => LoginPostModel(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };

  @override
  String toString() {
    return 'LoginPostModel(email: $email, password: $password)';
  }
}
