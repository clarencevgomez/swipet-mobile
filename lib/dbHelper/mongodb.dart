import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:swipet_mobile/MongoDBModels/MongoDBModel.dart';
import 'package:swipet_mobile/dbHelper/constant.dart';

class MongoDatabase {
  // ignore: prefer_typing_uninitialized_variables
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection =
        db.collection(USER_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>>
      getData() async {
    final arrData =
        await userCollection.find().toList();
    return arrData;
  }

// USER LOGIN
  static Future<String> loginUser(
      String username, String password) async {
    try {
      var result = await userCollection
          .find(where
              .eq('username', username)
              .and(
                  where.eq('password', password)))
          .toList();
      if (result.isNotEmpty) {
        return "User Found";
      } else {
        return "Cannot find User";
      }
    } catch (e) {
      print(e.toString());
      return "An error occurred";
    }
  }

  // USER SIGNUP
  static Future<String> addUser(
      MongoDbModel data) async {
    try {
      var result = await userCollection
          .insertOne(data.toJson());

      if (result.isSuccess) {
        return "User Added";
      } else {
        return "Something wrong while adding user";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
