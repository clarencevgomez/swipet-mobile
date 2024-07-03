// To parse this JSON data, do
//
//     final mongoDbModel = mongoDbModelFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel mongoDbModelFromJson(String str) =>
    MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) =>
    json.encode(data.toJson());

class MongoDbModel {
  ObjectId
      id; // Generated with the creation of the user
  String username;
  String email;
  String address;
  String password;

  MongoDbModel({
    required this.id,
    required this.username,
    required this.email,
    required this.address,
    required this.password,
  });

  factory MongoDbModel.fromJson(
          Map<String, dynamic> json) =>
      MongoDbModel(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        address: json["address"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "address": address,
        "password": password,
      };
}
