import 'package:flutter/material.dart';
import 'package:swipet_mobile/MongoDBModels/MongoDBModel.dart'; // Import your MongoDBModel
import 'package:swipet_mobile/components/my_bottom_bar.dart';
import 'package:swipet_mobile/dbHelper/mongodb.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({super.key});

  @override
  State<SwipePage> createState() =>
      _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  bool _hasReachedEnd = false;

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Swipet"),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<
              List<Map<String, dynamic>>>(
            future: MongoDatabase
                .getData(), // Update this to fetch the relevant data
            builder: (context, snapshot) {
              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator
                      .adaptive(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                      "Error: ${snapshot.error}"),
                );
              } else if (snapshot.hasData &&
                  snapshot.data!.isNotEmpty) {
                var totalData =
                    snapshot.data!.length;
                print('Total Data: $totalData');
                return Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    if (!_hasReachedEnd)
                      Expanded(
                        child: AppinioSwiper(
                          cardCount: totalData,
                          cardBuilder:
                              (BuildContext
                                      context,
                                  int index) {
                            var animalModel =
                                AnimalModel.fromJson(
                                    snapshot.data![
                                        index]);
                            return displayAnimalCard(
                                animalModel);
                          },
                          onEnd: () {
                            setState(() {
                              _hasReachedEnd =
                                  true;
                            });
                          },
                        ),
                      )
                    else
                      const Center(
                        child: Padding(
                          padding:
                              EdgeInsets.all(8.0),
                          child: Text(
                            "You've reached the end!",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight:
                                    FontWeight
                                        .bold),
                          ),
                        ),
                      ),
                  ],
                );
              } else {
                return const Center(
                  child:
                      Text("No Data Available"),
                );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(
        onTap: _onItemTapped,
        currIndex: _selectedIndex,
      ),
    );
  }

  Widget displayAnimalCard(AnimalModel data) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                    'Animal Type: ${isEmpty(data.animalType)}'),
                Text('Bio: ${isEmpty(data.bio)}'),
                Text(
                    'Breed: ${isEmpty(data.breed)}'),
                Text(
                    'Contact Email: ${isEmpty(data.contactEmail)}'),
                Text(
                    'Location: ${isEmpty(data.location)}'),
                Text(
                    'Pet Age: ${isEmpty(data.petAge)}'),
                Text(
                    'Pet Name: ${isEmpty(data.petName)}'),
                Text(
                    'Gender: ${isEmpty(data.gender)}'),
                Text(
                    'Pet ID: ${isEmpty(data.petId)}'),
                Text(
                    'Pet Size: ${isEmpty(data.petSize)}'),
                const Text('Pet Images:'),
                for (var image in data.petImages)
                  Image.network(image,
                      height: 100, width: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget displayUserCard(MongoDbModel data) {
  //   return SizedBox(
  //     width: MediaQuery.of(context).size.width,
  //     child: Card(
  //       child: Padding(
  //         padding: const EdgeInsets.all(15.0),
  //         child: SingleChildScrollView(
  //           child: Column(
  //             crossAxisAlignment:
  //                 CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                   'Username: ${isEmpty(data.username)}'),
  //               Text(
  //                   'Email: ${isEmpty(data.email)}'),
  //               Text(
  //                   'Address: ${isEmpty(data.address)}'),
  //               Text(
  //                   'Password: ${isEmpty(data.password)}'),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

String isEmpty(String? data) {
  return data == null || data.isEmpty ? "" : data;
}
