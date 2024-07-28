import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:swipet_mobile/components/animal_card_items/animal_images.dart';
import 'package:swipet_mobile/components/animal_card_items/vertical_divider.dart';
import 'package:swipet_mobile/components/my_bottom_bar.dart';
import 'package:swipet_mobile/dbHelper/api_service.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() =>
      _FavoritePageState();
}

class _FavoritePageState
    extends State<FavoritePage> {
  int _selectedIndex = 1;
  String userName = '';
  int totalFavs = 0;
  List<dynamic> favoritePets = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    const FlutterSecureStorage storage =
        FlutterSecureStorage();
    String? token =
        await storage.read(key: 'jwtToken');
    if (token != null) {
      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(token);
      if (kDebugMode) {
        print(": $decodedToken");
      }
      setState(() {
        userName = decodedToken['username'] ??
            'Unknown User';
      });
      _getFavorites(userName);
    }
  }

  Future<void> _getFavorites(
      String userLogin) async {
    final apiService = ApiService();

    try {
      final favResults = await apiService
          .getUserFavorites(userLogin);
      print("API Response: $favResults");

      if (favResults['message'] ==
          'Favorites retrieved successfully') {
        List<dynamic> favorites =
            favResults['favorites'] ?? [];
        print(
            "Favorites Length: ${favorites.length}"); // Check length
        setState(() {
          favoritePets = favorites;
          totalFavs = favorites.length;
        });
      } else {
        String message = favResults['message'] ??
            'Failed to retrieve favorites';
        ScaffoldMessenger.of(context)
            .showSnackBar(
                SnackBar(content: Text(message)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Number formatting

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: Padding(
          padding:
              const EdgeInsets.only(left: 25.0),
          child: SvgPicture.asset(
            'lib/assets/appheaders/balloon-heart.svg',
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: const Text(
          "Your Matches",
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Recoleta',
          ),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 10,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 50.0),
                child: Text(
                  "Matches ($totalFavs)",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontSize: 24,
                      letterSpacing: -0.1,
                      decoration: TextDecoration
                          .underline,
                      fontWeight:
                          FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: favoritePets.isEmpty
                ? const Text(
                    'No matches yet\n Get to Swiping!',
                    textAlign: TextAlign.center,
                  )
                : ListView.builder(
                    itemCount:
                        favoritePets.length,
                    itemBuilder:
                        (context, index) {
                      var pet =
                          favoritePets[index];
                      var petName =
                          pet['Pet_Name']
                              .toString();
                      var petImg = pet['Images']
                              [0]
                          .toString();
                      var petLocation =
                          pet['Location']
                              .toString();
                      var petFee =
                          pet['AdoptionFee']
                              .toString();

                      var petGender =
                          pet['Gender']
                              .toString();

                      return PetFavoriteInfo(
                        image: petImg,
                        info: petName,
                        adoptionFee: petFee,
                        location: petLocation,
                        gender: petGender,
                      );
                    }),
          ),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(
        onTap: _onItemTapped,
        currIndex: _selectedIndex,
      ),
    );
  }
}

// Information Displayed
class PetFavoriteInfo extends StatelessWidget {
  final String image;
  final String info;
  final String location;
  final String adoptionFee;
  final String gender;

  const PetFavoriteInfo(
      {super.key,
      required this.image,
      required this.info,
      required this.location,
      required this.adoptionFee,
      required this.gender});

  @override
  Widget build(BuildContext context) {
    // Number Formatting
    var f = NumberFormat.decimalPatternDigits(
      locale: 'en_us',
      decimalDigits: 0,
    );

    return Column(
      children: [
        Row(
          crossAxisAlignment:
              CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context)
                        .size
                        .width /
                    20),
            ListAnimalImage(image: image),
            const SizedBox(width: 10),
            // Pet Name

            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  info,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.1),
                ),
                Text(
                  gender,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.1),
                ),
                Text(
                  "Fee: \$${f.format(int.tryParse(adoptionFee) ?? 0)}",
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.1),
                ),
                Text(
                  location,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.1),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(
                  right: 30.0),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'lib/assets/heart-mail.svg',
                    width: 40,
                    height: 40,
                    colorFilter:
                        const ColorFilter.mode(
                      Color.fromRGBO(
                          242, 162, 155, 1),
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Inquire Now",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight:
                            FontWeight.bold,
                        letterSpacing: -0.1,
                        fontFamily: 'Recoleta'),
                  )
                ],
              ),
            ),
          ],
        ),
        const ProfileInfoHDivider()
      ],
    );
  }
}

class ListImage extends StatefulWidget {
  final String image;
  const ListImage(
      {super.key, required this.image});

  @override
  State<ListImage> createState() =>
      _ListImageState();
}

class _ListImageState extends State<ListImage> {
  @override
  Widget build(BuildContext context) {
    String imageUrl = widget.image.isNotEmpty
        ? widget.image
        : 'lib/images/defaultLogo-pic.jpg';

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20.0),
        child: Container(
          width: 70, // Adjust the size as needed
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: FractionalOffset.center,
              image: imageUrl.startsWith('http')
                  ? NetworkImage(imageUrl)
                  : AssetImage(imageUrl)
                      as ImageProvider,
            ),
          ),
        ),
      ),
    );
  }
}
