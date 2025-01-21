// To parse this JSON data, do
//
//     final signUpPostModel = signUpPostModelFromJson(jsonString);

import 'dart:convert';

SignUpPostModel signUpPostModelFromJson(String str) =>
    SignUpPostModel.fromJson(json.decode(str));

String signUpPostModelToJson(SignUpPostModel data) =>
    json.encode(data.toJson());

class SignUpPostModel {
  String fullname;
  String email;
  String password;

  SignUpPostModel({
    required this.fullname,
    required this.email,
    required this.password,
  });

  factory SignUpPostModel.fromJson(Map<String, dynamic> json) =>
      SignUpPostModel(
        fullname: json["fullname"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "email": email,
        "password": password,
      };
  @override
  String toString() {
    return 'PostModel(fullname: $fullname, email: $email, password: $password)';
  }
}
