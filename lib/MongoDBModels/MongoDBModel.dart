import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

// MongoDbModel class
MongoDbModel mongoDbModelFromJson(String str) =>
    MongoDbModel.fromJson(json.decode(str));

String mongoDbModelToJson(MongoDbModel data) =>
    json.encode(data.toJson());

class MongoDbModel {
  ObjectId id;
  String firstName;
  String lastName;
  String username;
  String email;
  String address;
  String password;

  MongoDbModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.address,
    required this.password,
  });

  factory MongoDbModel.fromJson(
          Map<String, dynamic> json) =>
      MongoDbModel(
        id: json["_id"] ?? ObjectId(),
        firstName: json["firstName"] ?? '',
        lastName: json["lastName"] ?? '',
        username: json["username"] ?? '',
        email: json["email"] ?? '',
        address: json["address"] ?? '',
        password: json["password"] ?? '',
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

// AnimalModel class
AnimalModel animalModelFromJson(String str) =>
    AnimalModel.fromJson(json.decode(str));

String animalModelToJson(AnimalModel data) =>
    json.encode(data.toJson());

class AnimalModel {
  ObjectId id;
  String bio;
  String breed;
  String location;
  String gender;
  String petId;
  String adoptionFee;
  String age;
  List<String> color;
  String contactEmail;
  String petName;
  String petType;
  String size;
  List<String> images;
  String? username;

  AnimalModel({
    required this.id,
    required this.bio,
    required this.breed,
    required this.location,
    required this.gender,
    required this.petId,
    required this.adoptionFee,
    required this.age,
    required this.color,
    required this.contactEmail,
    required this.petName,
    required this.petType,
    required this.size,
    required this.images,
    this.username,
  });

  factory AnimalModel.fromJson(
          Map<String, dynamic> json) =>
      AnimalModel(
        id: json["_id"] ?? ObjectId(),
        bio: json['Bio'] ?? '',
        breed: json['Breed'] ?? '',
        location: json['Location'] ?? '',
        gender: json['Gender'] ?? '',
        petId: json['PetId'] ?? '',
        adoptionFee: json['AdoptionFee'] ?? '',
        age: json['Age'] ?? '',
        color: (json['Color'] != null)
            ? List<String>.from(json['Color'])
            : [],
        contactEmail: json['Contact_Email'] ?? '',
        petName: json['Pet_Name'] ?? '',
        petType: json['Pet_Type'] ?? '',
        size: json['Size'] ?? '',
        images: (json['Images'] != null)
            ? List<String>.from(json['Images'])
            : [],
        username: json['username'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'Bio': bio,
        'Breed': breed,
        'Location': location,
        'Gender': gender,
        'PetId': petId,
        'AdoptionFee': adoptionFee,
        'Age': age,
        'Color': color,
        'Contact_Email': contactEmail,
        'Pet_Name': petName,
        'Pet_Type': petType,
        'Size': size,
        'Images': images,
        'Username': username,
      };
}
