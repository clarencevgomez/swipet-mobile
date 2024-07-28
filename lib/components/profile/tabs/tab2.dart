import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:swipet_mobile/components/animal_card_items/animal_images.dart';
import 'package:swipet_mobile/components/animal_card_items/vertical_divider.dart';
import 'package:swipet_mobile/components/profile/profile_button.dart';
import 'package:swipet_mobile/dbHelper/api_service.dart';

class UserListings extends StatefulWidget {
  const UserListings({super.key});

  @override
  State<UserListings> createState() =>
      _UserListingsState();
}

class _UserListingsState
    extends State<UserListings> {
  String userName = '';
  int totalListings = 0;
  List<dynamic> listings = [];

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
      _getListings(userName);
    }
  }

  Future<void> _getListings(
      String userLogin) async {
    final apiService = ApiService();

    try {
      final listResults = await apiService
          .getUserListings(userLogin);
      print("API Response: $listResults");

      if (listResults['message'] ==
          'Listings retrieved successfully') {
        List<dynamic> fetchedListings =
            listResults['listings'] ?? [];
        print(
            "Listings Length: ${fetchedListings.length}");
        setState(() {
          listings = fetchedListings;
          totalListings = listings.length;
        });
      } else {
        String message = listResults['message'] ??
            'Failed to retrieve Listings';
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
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.all(12.0),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        const Color.fromRGBO(
                            242, 196, 179, 0.7),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Here you can view all the pets you're listing!",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight:
                            FontWeight.w500),
                  ),
                ),
              ),
              Expanded(
                child: listings.isEmpty
                    ? const Center(
                        child: Text(
                            "No listings available"))
                    : SingleChildScrollView(
                        child: Column(
                          children:
                              listings.map((pet) {
                            var petName = pet[
                                        'Pet_Name']
                                    ?.toString() ??
                                'Unnamed Pet';
                            var petImg = pet[
                                            'Images'] !=
                                        null &&
                                    pet['Images']
                                        .isNotEmpty
                                ? pet['Images'][0]
                                    .toString()
                                : 'lib/images/defaultLogo-pic.jpg';
                            return PetListingInfo(
                                image: petImg,
                                info: petName);
                          }).toList(),
                        ),
                      ),
              ),
            ],
          ),
          Positioned(
            bottom: 50,
            right: MediaQuery.of(context)
                    .size
                    .width /
                10,
            child: ProfileButton(
              backgroundColor:
                  const Color.fromRGBO(
                      242, 216, 238, 1),
              svgAsset:
                  'lib/assets/profileSvgs/listPet.svg',
              onPressed: () {
                Navigator.pushNamed(
                    context, '/listpetpage');
              },
              actionText: 'List a new animal',
            ),
          ),
        ],
      ),
    );
  }
}

// Information Displayed
class PetListingInfo extends StatelessWidget {
  final String image;
  final String info;

  const PetListingInfo({
    super.key,
    required this.image,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
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
            Text(
              info,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.1),
            ),
            const Spacer(),
            Row(
              children: [
                SvgPicture.asset(
                  'lib/assets/tabSvgs/edit.svg',
                  width: 24,
                  height: 24,
                  colorFilter:
                      const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 25),
                SvgPicture.asset(
                  'lib/assets/tabSvgs/delete.svg',
                  width: 20,
                  height: 20,
                  colorFilter:
                      const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(
                    width: MediaQuery.of(context)
                            .size
                            .width /
                        20),
              ],
            ),
          ],
        ),
        const ProfileInfoHDivider()
      ],
    );
  }
}
