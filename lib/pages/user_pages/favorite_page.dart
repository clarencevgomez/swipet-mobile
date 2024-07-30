import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:swipet_mobile/components/my_bottom_bar.dart';
import 'package:swipet_mobile/dbHelper/api_service.dart';
import 'package:swipet_mobile/pages/user_pages/FavUtils/favorite_pet.dart'; // Import the PetFavoriteInfo file

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
        print("Decoded Token: $decodedToken");
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
      if (kDebugMode) {
        print("API Response: $favResults");
      }

      if (favResults['message'] ==
          'Favorites retrieved successfully') {
        List<dynamic> favorites =
            favResults['favorites'] ?? [];
        if (kDebugMode) {
          print(
              "Favorites Length: ${favorites.length}");
        }
        setState(() {
          favoritePets = favorites;
          totalFavs = favorites.length;
        });
      } else {
        String message = favResults['message'] ??
            'Failed to retrieve favorites';
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(
        //         SnackBar(content: Text(message)));
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

  void _refreshFavorites() {
    _getFavorites(userName);
  }

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 50),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 50.0),
                child: Text(
                  "Matches ($totalFavs)",
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 24,
                    letterSpacing: -0.1,
                    decoration:
                        TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
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
                        id: pet['_id'].toString(),
                        username: userName,
                        image: petImg,
                        info: petName,
                        adoptionFee: petFee,
                        location: petLocation,
                        gender: petGender,
                        onRemove:
                            _refreshFavorites, // Pass the callback
                      );
                    },
                  ),
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
