import 'package:flutter/material.dart';
import 'package:swipet_mobile/MongoDBModels/MongoDBModel.dart';
import 'package:swipet_mobile/dbHelper/mongodb.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({super.key});

  @override
  State<SwipePage> createState() =>
      _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(45.0),
          child: FutureBuilder(
            builder: (context,
                AsyncSnapshot snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                    child:
                        CircularProgressIndicator
                            .adaptive());
              } else {
                if (snapshot.hasData) {
                  var totalData =
                      snapshot.data.length;
                  print('Total Data' +
                      totalData.toString());
                  return ListView.builder(
                      itemCount:
                          snapshot.data.length,
                      itemBuilder:
                          (context, index) {
                        return displayCard(
                            MongoDbModel.fromJson(
                                snapshot.data[
                                    index]));
                      });
                } else {
                  return const Center(
                    child:
                        Text("no Data Available"),
                  );
                }
              }
            },
            future: MongoDatabase.getData(),
          ),
        )));
  }

  Widget displayCard(MongoDbModel data) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text('username: ${data.username}'),
            Text('email: ${data.email}'),
            Text('address: ${data.address}'),
            Text('password: ${data.password}')
          ],
        ),
      ),
    );
  }
}
