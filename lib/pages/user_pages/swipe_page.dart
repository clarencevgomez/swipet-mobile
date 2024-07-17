import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swipet_mobile/MongoDBModels/MongoDBModel.dart'; // Import your MongoDBModel
import 'package:swipet_mobile/components/animal_card.dart';
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
        toolbarHeight: 80,
        leading: Padding(
          padding:
              const EdgeInsets.only(left: 25.0),
          child: SvgPicture.asset(
            'lib/assets/swipet.svg',
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: const Text(
          "SwiPet",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 5,
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
                            return AnimalCard(
                                data:
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
}
