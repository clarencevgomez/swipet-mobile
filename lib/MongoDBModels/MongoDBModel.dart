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
  String firstName;
  String lastName;
  String username;
  String email;
  String address;
  String password;

  MongoDbModel({
    required this.firstName,
    required this.lastName,
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
        firstName: json["firstName"],
        lastName: json["lastName"],
        username: json["username"],
        email: json["email"],
        address: json["address"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "email": email,
        "address": address,
        "password": password,
      };
}

class AnimalModel {
  ObjectId id;
  String animalType;
  String bio;
  String breed;
  String contactEmail;
  String location;
  String petAge;
  String petName;
  String gender;
  String petId;
  String petSize;
  List<String> petImages;

  AnimalModel({
    required this.id,
    required this.animalType,
    required this.bio,
    required this.breed,
    required this.contactEmail,
    required this.location,
    required this.petAge,
    required this.petName,
    required this.gender,
    required this.petId,
    required this.petSize,
    required this.petImages,
  });

  factory AnimalModel.fromJson(
          Map<String, dynamic> json) =>
      AnimalModel(
        id: json['_id'],
        animalType: json['Animal Type'],
        bio: json['Bio'],
        breed: json['Breed'],
        contactEmail: json['Contact Email'],
        location: json['Location'],
        petAge: json['Pet Age'],
        petName: json['Pet Name'],
        gender: json['Gender'],
        petId: json['PetId'],
        petSize: json['Pet Size'],
        petImages:
            List<String>.from(json['Pet Images']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'Animal Type': animalType,
        'Bio': bio,
        'Breed': breed,
        'Contact Email': contactEmail,
        'Location': location,
        'Pet Age': petAge,
        'Pet Name': petName,
        'Gender': gender,
        'PetId': petId,
        'Pet Size': petSize,
        'Pet Images': petImages,
      };
}
