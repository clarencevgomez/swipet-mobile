import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:swipet_mobile/components/animal_card.dart';
import 'package:swipet_mobile/components/animal_card_items/animal_images.dart';
import 'package:swipet_mobile/components/animal_card_items/my_text_button.dart';
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
  String msg = '';
  final ApiService apiService = ApiService();

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

  // Show Dialog Function
  void _showDialog(String result, String info) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              result,
              style: const TextStyle(
                  fontFamily: 'Dm Sans',
                  fontSize: 18),
            ),
          ),
          content: Text(info,
              style: const TextStyle(
                  fontFamily: 'Dm Sans',
                  fontSize: 16)),
          // actions: [
          //   CupertinoButton(
          //       child: const Icon(
          //         Icons.check_circle,
          //         color: Color.fromRGBO(
          //             255, 106, 146, 1),
          //         size: 32,
          //       ),
          //       onPressed: () {
          //         Navigator.pop(context);
          //       })
          // ],
        );
      },
    );
  }

  // Function to add pet to favorites when matching
  Future<void> _petMatch(
      String userLogin, String petId) async {
    try {
      final result = await apiService.addFavorite(
          userLogin, petId);
      String msg = result['message'];
      print(msg);
    } catch (e) {
      print(e.toString());
    }
  }

// Send Pet Inquiry
  Future<void> _sendInquiry(
      String userLogin,
      String petId,
      String petName,
      String image) async {
    final apiService = ApiService();

    try {
      final inquireResult = await apiService
          .sendInquiry(userLogin, petId);

      if (inquireResult['message'] ==
          'Inquiry email sent') {
        _showDialog(
            'Congrats! you inquired about $petName',
            inquireResult['message']);
      } else {
        String InquireMsg =
            inquireResult['message'];
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(
        //         content: Text(InquireMsg)));
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text(e.toString())));
    }
  }

// Find the pets to display
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
        msg = searchResults['message'];
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(
        //         SnackBar(content: Text(msg)));
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text(e.toString())));
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
      String petName,
      String petId,
      String userLogin,
      String image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width:
              MediaQuery.of(context).size.width,
          child: CupertinoAlertDialog(
              title: Column(
                children: [
                  MatchImage(image: image),
                  Text(
                    "It's a Match!",
                    style:
                        TextStyle(fontSize: 32),
                  ),
                ],
              ),
              content: Text(
                  'You matched with $petName!\nCheck $petName out in your matches page!'),
              actions: <Widget>[
                MyTextButton(
                    text: 'Send Inquiry',
                    function: () {
                      _sendInquiry(userLogin,
                          petId, petName, image);
                    }),
                MyTextButton(
                    text: 'Not now',
                    function: () {}),
              ]),
        );
      },
    );
    // Add pet to favorite after showing dialog
    _petMatch(userLogin, petId);
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
              // Pet Name
              displayPets[previousIndex]
                      ['Pet_Name']
                  .toString(),
              // pet ID
              displayPets[previousIndex]['_id']
                  .toString(),
              // your username
              searchCriteria['userLogin'],
              displayPets[previousIndex]['Images']
                      [0]
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
                                          .length +
                                      1,
                              cardBuilder:
                                  (BuildContext
                                          context,
                                      int index) {
                                if (index <
                                        displayPets
                                            .length &&
                                    msg !=
                                        'No pets found') {
                                  var pet =
                                      displayPets[
                                          index];

                                  return AnimalCard(
                                    username: pet[
                                            'username']
                                        .toString(),
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
                                      // 'username':
                                      //     pet['username']
                                      //         .toString(),
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
                                  return const Center(
                                      child: Text(
                                          "No more pets available"));
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
                        child: EndPage());
                  }
                },
              ),
            ),
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
