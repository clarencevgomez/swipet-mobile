import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:swipet_mobile/components/animal_card_items/animal_images.dart';
import 'package:swipet_mobile/components/animal_card_items/vertical_divider.dart';
import 'package:swipet_mobile/dbHelper/api_service.dart';

class PetFavoriteInfo extends StatelessWidget {
  final String id;
  final String username;
  final String image;
  final String info;
  final String location;
  final String adoptionFee;
  final String gender;
  final VoidCallback
      onRemove; // Add callback parameter

  const PetFavoriteInfo({
    super.key,
    required this.image,
    required this.info,
    required this.location,
    required this.adoptionFee,
    required this.gender,
    required this.id,
    required this.username,
    required this.onRemove, // Initialize callback parameter
  });

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat.decimalPatternDigits(
        locale: 'en_us', decimalDigits: 0);

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
            actions: [
              CupertinoButton(
                child: const Icon(
                  Icons.check_circle,
                  color: Color.fromRGBO(
                      255, 106, 146, 1),
                  size: 32,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
    }

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
          String inquireMsg =
              inquireResult['message'];
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(
          //         content: Text(inquireMsg)));
        }
      } catch (e) {
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(
        //         content: Text(e.toString())));
      }
    }

    Future<void> _removeMatch(
        String userLogin,
        String petId,
        String petName,
        String image) async {
      final apiService = ApiService();

      try {
        final removedResult = await apiService
            .removeFavorite(userLogin, petId);

        if (removedResult['message'] ==
            'Pet removed from favorites') {
          _showDialog(
              '$petName has been removed from your matches',
              removedResult['message']);
          onRemove(); // Call the callback to refresh the page
        } else {
          String removeMsg =
              removedResult['message'];
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(
          //         content: Text(removeMsg)));
        }
      } catch (e) {
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(
        //         content: Text(e.toString())));
      }
    }

    return Column(
      children: [
        Slidable(
          startActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  backgroundColor:
                      const Color.fromARGB(
                          255, 255, 106, 96),
                  onPressed: (context) {
                    _removeMatch(username, id,
                        info, image);
                  },
                  icon: Icons.cancel_outlined,
                  label: 'Remove Match',
                )
              ]),
          child: Row(
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
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    info,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.1,
                    ),
                  ),
                  Text(
                    gender,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.1,
                    ),
                  ),
                  Text(
                    "Fee: \$${f.format(int.tryParse(adoptionFee) ?? 0)}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.1,
                    ),
                  ),
                  Text(
                    location,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.1,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                    right: 30.0),
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        _sendInquiry(username, id,
                            info, image);
                      },
                      icon: SvgPicture.asset(
                        'lib/assets/heart-mail.svg',
                        width: 40,
                        height: 40,
                        colorFilter:
                            const ColorFilter
                                .mode(
                          Color.fromRGBO(
                              242, 162, 155, 1),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const Text(
                      "Inquire Now",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            FontWeight.bold,
                        letterSpacing: -0.1,
                        fontFamily: 'Recoleta',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const ProfileInfoHDivider(),
      ],
    );
  }
}
