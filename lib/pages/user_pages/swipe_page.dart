import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:swipet_mobile/components/animal_card.dart';
import 'package:swipet_mobile/components/my_bottom_bar.dart';
import 'package:swipet_mobile/dbHelper/api_service.dart';
import 'package:swipet_mobile/dbHelper/mongodb.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({super.key});

  @override
  State<SwipePage> createState() =>
      _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  bool _hasReachedEnd = false;
  int _selectedIndex = 0;
  bool _isSearchFormVisible = false;
  int totalPets = 0;

  Map<String, dynamic> searchCriteria = {
    'userLogin': '',
    'type': '',
    'petAge': '',
    'petGender': '',
    'colors': <String>[],
    'breed': '',
    'petSize': '',
    'location': ''
  };

  final AppinioSwiperController
      _swiperController =
      AppinioSwiperController();
  List<dynamic> displayPets = [];

  Future<void> loadUserData() async {
    const FlutterSecureStorage storage =
        FlutterSecureStorage();
    String? token =
        await storage.read(key: 'jwtToken');
    if (token != null) {
      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(token);
      setState(() {
        searchCriteria['userLogin'] =
            decodedToken['username'] ??
                'Unknown User';
      });
      _getPets(searchCriteria);
    }
  }

  Future<void> _getPets(
      Map<String, dynamic> s) async {
    final apiService = ApiService();

    try {
      final searchResults =
          await apiService.searchPet(
        s['userLogin'],
        s['type'],
        s['petAge'],
        s['petGender'],
        s['breed'],
        s['petSize'],
        s['location'],
      );

      if (searchResults['message'] ==
          'Pets retrieved successfully') {
        List<dynamic> pets =
            searchResults['pets'] ?? [];
        setState(() {
          displayPets = pets;
          totalPets = pets.length;
        });
      } else {
        String message =
            searchResults['message'] ??
                'Failed to retrieve pets';
        ScaffoldMessenger.of(context)
            .showSnackBar(
                SnackBar(content: Text(message)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())));
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _changeCard() {
    _swiperController.swipeLeft();
  }

  void _toggleSearchForm() {
    setState(() {
      _isSearchFormVisible =
          !_isSearchFormVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void _showMatchDialog(
      String petName, String petId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.pink[100],
            title: Column(
              children: [
                Image.asset(
                    'lib/images/cat-playing.png'),
                Text("It's a Match!"),
              ],
            ),
            content: Text(
                'You matched with $petName! $petId'),
            actions: <Widget>[
              TextButton(
                child: Text('Send Inquiry'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: Text('Not Now'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ]);
      },
    );
  }

  void _swipeEnd(int previousIndex,
      int targetIndex, SwiperActivity activity) {
    switch (activity.runtimeType) {
      case Swipe:
        print(
            'The card was swiped to the: ${activity.direction}');
        print(
            'previous index: $previousIndex, target index: $targetIndex');
        if (activity.direction ==
            AxisDirection.right) {
          _showMatchDialog(
              displayPets[previousIndex]
                      ['Pet_Name']
                  .toString(),
              displayPets[previousIndex]['_id']
                  .toString());
        }
        break;
      case Unswipe:
        print(
            'A ${activity.direction.name} swipe was undone.');
        print(
            'previous index: $previousIndex, target index: $targetIndex');
        break;
      case CancelSwipe:
        print('A swipe was cancelled');
        break;
      case DrivenActivity:
        print('Driven Activity');
        break;
    }
  }

  void _onEnd() {
    setState(() {
      _hasReachedEnd = true;
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
              fontFamily: 'Recoleta'),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 5,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _toggleSearchForm,
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16.0),
              child: FutureBuilder<
                  List<Map<String, dynamic>>>(
                future: MongoDatabase.getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator
                                .adaptive());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text(
                            "Error: ${snapshot.error}"));
                  } else if (snapshot.hasData &&
                      snapshot.data!.isNotEmpty) {
                    return Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,
                      children: [
                        if (!_hasReachedEnd)
                          Expanded(
                            child: AppinioSwiper(
                              controller:
                                  _swiperController,
                              cardCount:
                                  displayPets
                                      .length,
                              cardBuilder:
                                  (BuildContext
                                          context,
                                      int index) {
                                if (index <
                                    displayPets
                                        .length) {
                                  var pet =
                                      displayPets[
                                          index];
                                  return AnimalCard(
                                    pet: {
                                      'petName': pet[
                                              'Pet_Name']
                                          .toString(),
                                      'age': pet[
                                              'Age']
                                          .toString(),
                                      'breed': pet[
                                              'Breed']
                                          .toString(),
                                      'gender': pet[
                                              'Gender']
                                          .toString(),
                                      'location':
                                          pet['Location']
                                              .toString(),
                                      'color': [
                                        'White'
                                      ],
                                      'petType': pet[
                                              'Pet_Type']
                                          .toString(),
                                      'bio': pet[
                                              'Bio']
                                          .toString(),
                                      'contactEmail':
                                          pet['Contact_Email']
                                              .toString(),
                                      'adoptionFee':
                                          pet['AdoptionFee']
                                              .toString(),
                                      'username':
                                          pet['userLogin']
                                              .toString(),
                                      'prompt1': pet[
                                              'Prompt1']
                                          .toString(),
                                      'prompt2': pet[
                                              'Prompt2']
                                          .toString(),
                                    },
                                    images: pet[
                                        'Images'],
                                  );
                                } else {
                                  return Center(
                                      child: Text(
                                          'No more pets available.'));
                                }
                              },
                              onSwipeEnd:
                                  _swipeEnd,
                              onEnd: _onEnd,
                            ),
                          )
                        else
                          const Center(
                            child: Padding(
                              padding:
                                  EdgeInsets.all(
                                      8.0),
                              child: EndPage(),
                            ),
                          ),
                      ],
                    );
                  } else {
                    return const Center(
                        child: Text(
                            "No Data Available"));
                  }
                },
              ),
            ),
            // if (_isSearchFormVisible)
            //   SearchForm(
            //     onSearch: (criteria) {
            //       setState(() {
            //         searchCriteria = criteria;
            //         _isSearchFormVisible = false;
            //       });
            //       _getPets(searchCriteria);
            //     },
            //     onClose: () {
            //       setState(() {
            //         _isSearchFormVisible = false;
            //       });
            //     },
            //   ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(
        onTap: _onItemTapped,
        currIndex: _selectedIndex,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation
              .startDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
            left: 16, bottom: 80),
        child: ClipOval(
          child: Container(
            color: Colors.white,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              elevation: 2,
              onPressed: _changeCard,
              tooltip: 'Change Card',
              shape: const CircleBorder(
                side: BorderSide(
                    color: Colors.black,
                    width: 1),
              ),
              child: const Icon(Icons.close,
                  color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

class EndPage extends StatelessWidget {
  const EndPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'lib/images/cat-stretch.png',
          height: (MediaQuery.of(context)
                  .size
                  .height /
              3),
        ),
        const Text(
          "You've reached the end!",
          style: TextStyle(
            fontSize: 32,
            fontFamily: 'Recoleta',
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "It looks like you've swiped through all the available pets.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
