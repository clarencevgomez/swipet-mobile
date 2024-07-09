import 'package:flutter/material.dart';
import 'package:swipet_mobile/MongoDBModels/MongoDBModel.dart'; // Import your MongoDBModel
import 'package:swipet_mobile/dbHelper/mongodb.dart';
import 'package:swipet_mobile/pages/user_pages/favorite_page.dart'; // Import your MongoDatabaseImport your HomePage

class SwipePage extends StatefulWidget {
  const SwipePage({super.key});

  @override
  State<SwipePage> createState() =>
      _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  late ScrollController _scrollController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    print("ScrollController initialized");
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                return Stack(
                  children: [
                    SingleChildScrollView(
                      controller:
                          _scrollController,
                      scrollDirection:
                          Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            totalData, (index) {
                          return displayAnimalCard(
                            AnimalModel.fromJson(
                                snapshot.data![
                                    index]),
                          );
                        }),
                      ),
                    ),
                    Align(
                      alignment:
                          Alignment.bottomLeft,
                      child: Padding(
                        padding:
                            const EdgeInsets.all(
                                16.0),
                        child:
                            FloatingActionButton(
                          onPressed: () {
                            if (_scrollController
                                    .position
                                    .pixels <
                                _scrollController
                                    .position
                                    .maxScrollExtent) {
                              _scrollController
                                  .animateTo(
                                _scrollController
                                        .position
                                        .pixels +
                                    MediaQuery.of(
                                            context)
                                        .size
                                        .width,
                                duration: Duration(
                                    milliseconds:
                                        300),
                                curve:
                                    Curves.easeIn,
                              );
                            }
                          },
                          child:
                              Icon(Icons.close),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget displayAnimalCard(AnimalModel data) {
    return Container(
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
                Text('Pet Images:'),
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

  Widget displayUserCard(MongoDbModel data) {
    return Container(
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
                    'Username: ${isEmpty(data.username)}'),
                Text(
                    'Email: ${isEmpty(data.email)}'),
                Text(
                    'Address: ${isEmpty(data.address)}'),
                Text(
                    'Password: ${isEmpty(data.password)}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String isEmpty(String? data) {
  return data == null || data.isEmpty ? "" : data;
}
