import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:swipet_mobile/MongoDBModels/MongoDBModel.dart';
import 'package:swipet_mobile/dbHelper/constant.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_CONN_URL);
    await db.open();
    inspect(db);
    userCollection =
        db.collection(USER_COLLECTION);
  }

  static Future<String> addUser(
      MongoDbModel data) async {
    try {
      var result = await userCollection
          .insertOne(data.toJson());

      if (result.isSucces) {
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
