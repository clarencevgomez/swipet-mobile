import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swipet_mobile/components/animal_card_items/animal_images.dart';
import 'package:swipet_mobile/components/animal_card_items/my_text_button.dart';
import 'package:swipet_mobile/components/animal_card_items/vertical_divider.dart';
import 'package:swipet_mobile/components/profile/tabs/editPet/edit_pet_page.dart';
import 'package:swipet_mobile/dbHelper/api_service.dart';
import 'package:flutter/cupertino.dart';

class PetListingInfo extends StatelessWidget {
  final Map<String, dynamic> pet;
  final VoidCallback onPetDeleted;

  const PetListingInfo({
    Key? key,
    required this.pet,
    required this.onPetDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // void _showDialog(String result, String info) {
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return CupertinoAlertDialog(
    //         title: Padding(
    //           padding: const EdgeInsets.all(16.0),
    //           child: Text(
    //             result,
    //             style: const TextStyle(
    //               fontFamily: 'Dm Sans',
    //               fontSize: 18,
    //             ),
    //           ),
    //         ),
    //         content: Text(
    //           info,
    //           style: const TextStyle(
    //             fontFamily: 'Dm Sans',
    //             fontSize: 16,
    //           ),
    //         ),
    //         actions: [
    //           CupertinoButton(
    //             child: const Icon(
    //               Icons.check_circle,
    //               color: Color.fromRGBO(
    //                   255, 106, 146, 1),
    //               size: 32,
    //             ),
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }

    Future<void> _deletePet(String userLogin,
        String petId, String petName) async {
      final apiService = ApiService();

      try {
        final deleteResult = await apiService
            .deletePet(userLogin, petId);

        if (deleteResult['message'] ==
            'Pet deleted successfully and removed from all favorites') {
          // _showDialog(
          //     '$petName has been deleted from your listings',
          //     deleteResult['message']);
          onPetDeleted(); // Call the callback function to refresh the listings
        } else {
          String deleteMsg =
              deleteResult['message'];
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(
                  content: Text(deleteMsg)));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
                content: Text(e.toString())));
      }
    }

    void _deletePetDialog(String userLogin,
        String petId, String petName) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            width:
                MediaQuery.of(context).size.width,
            child: CupertinoAlertDialog(
                title: Column(
                  children: [
                    // MatchImage(image: image),
                    Text(
                      "Are you SURE you want to delete $petName?",
                      style:
                          TextStyle(fontSize: 32),
                    ),
                  ],
                ),
                actions: <Widget>[
                  MyTextButton(
                      text: 'yes'.toUpperCase(),
                      function: () {
                        _deletePet(userLogin,
                            petId, petName);
                      }),
                  MyTextButton(
                      text: 'No'.toUpperCase(),
                      function: () {}),
                ]),
          );
        },
      );
    }

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
            ListAnimalImage(
              image: pet['Images'] != null &&
                      pet['Images'].isNotEmpty
                  ? pet['Images'][0].toString()
                  : 'lib/images/defaultLogo-pic.jpg',
            ),
            const SizedBox(width: 10),
            Text(
              pet['Pet_Name'] ?? 'Unknown',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.1,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditPetPage(
                                  pet: pet)),
                    );
                  },
                  icon: SvgPicture.asset(
                    'lib/assets/tabSvgs/edit.svg',
                    width: 24,
                    height: 24,
                    colorFilter:
                        const ColorFilter.mode(
                      Colors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _deletePetDialog(
                        pet['username'],
                        pet['_id'],
                        pet['Pet_Name']);
                    // _deletePet(
                    //     pet['username'],
                    //     pet['_id'],
                    //     pet['Pet_Name']);
                  },
                  icon: SvgPicture.asset(
                    'lib/assets/tabSvgs/delete.svg',
                    width: 20,
                    height: 20,
                    colorFilter:
                        const ColorFilter.mode(
                      Colors.black,
                      BlendMode.srcIn,
                    ),
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
        const ProfileInfoHDivider(),
      ],
    );
  }
}
