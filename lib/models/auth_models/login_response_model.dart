// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String message;
  User user;

  LoginModel({
    required this.message,
    required this.user,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user": user.toJson(),
      };
}

class User {
  String email;
  String fullname;
  String token;
  String userid;

  User({
    required this.email,
    required this.fullname,
    required this.token,
    required this.userid,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        fullname: json["fullname"],
        token: json["token"],
        userid: json["userid"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "fullname": fullname,
        "token": token,
        "userid": userid,
      };
}
