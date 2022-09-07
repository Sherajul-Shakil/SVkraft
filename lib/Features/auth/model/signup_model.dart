// To parse this JSON data, do
//
//     final signupUser = signupUserFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SignupUser signupUserFromJson(String str) =>
    SignupUser.fromJson(json.decode(str));

String signupUserToJson(SignupUser data) => json.encode(data.toJson());

class SignupUser {
  SignupUser({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory SignupUser.fromJson(Map<String, dynamic> json) => SignupUser(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.token,
    required this.user,
  });

  String token;
  User user;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.username,
    required this.name,
    required this.email,
    required this.phone,
    required this.id,
  });

  String username;
  String name;
  String email;
  String phone;
  int id;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "email": email,
        "phone": phone,
        "id": id,
      };
}
