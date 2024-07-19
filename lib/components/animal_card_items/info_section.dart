import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swipet_mobile/components/animal_card.dart';
import 'package:swipet_mobile/components/animal_card_items/vertical_divider.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Define the main component
class AnimalInfoCard extends StatelessWidget {
  final String age;
  final String breed;
  final String gender;
  final String location;
  final List<String> color;
  final String petType;
  final String bio;
  final String contactEmail;
  final String adoptionFee;
  final String username;

  const AnimalInfoCard(
      {super.key,
      required this.age,
      required this.breed,
      required this.gender,
      required this.location,
      required this.color,
      required this.petType,
      required this.bio,
      required this.contactEmail,
      required this.adoptionFee,
      required this.username});

  String isEmpty(String? value) {
    return value?.isNotEmpty == true
        ? value!
        : 'N/A';
  }

  String getGender(String gender) {
    return gender.toLowerCase() == 'male'
        ? 'male'
        : 'female';
  }

  String isUserEmpty(String owner) {
    return owner.toLowerCase() == 'null'
        ? 'N/A'
        : owner;
  }

  @override
  Widget build(BuildContext context) {
    var f = NumberFormat.decimalPatternDigits(
      locale: 'en_us',
      decimalDigits: 0,
    );

    return Column(children: [
      Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.start,
                    children: [
                      InfoText(
                          svgAsset:
                              'lib/assets/animalInfo/pet_age.svg',
                          info: age),
                      const InfoDivider(),

                      InfoText(
                          svgAsset:
                              'lib/assets/animalInfo/gender-${getGender(breed)}.svg',
                          info: gender),

                      const InfoDivider(),
                      // Location
                      InfoText(
                          svgAsset:
                              'lib/assets/animalInfo/map.svg',
                          info: location),
                      const InfoDivider(),
                      InfoText(
                          svgAsset:
                              'lib/assets/animalInfo/breed.svg',
                          info: breed),
                      const InfoDivider(),
                      ColorInfoText(
                          svgAsset:
                              'lib/assets/animalInfo/palette.svg',
                          info: color)
                    ],
                  ),
                ),
              ),
              const InfoHDivider(),
              InfoText(
                  svgAsset:
                      'lib/assets/animalInfo/pet_fee.svg',
                  info:
                      "\$${f.format(int.parse(adoptionFee))}"),
              const InfoHDivider(),
              InfoText(
                  svgAsset:
                      'lib/assets/animalInfo/stars.svg',
                  info: petType),
              const InfoHDivider(),
              InfoText(
                  svgAsset:
                      'lib/assets/animalInfo/postage-heart.svg',
                  info: contactEmail),
              const InfoHDivider(),
              InfoText(
                  svgAsset:
                      'lib/assets/postcard-heart.svg',
                  info:
                      'Listed by ${isUserEmpty(username)}')
            ],
          ),
        ),
      ),
      const SizedBox(
        height: 25,
      ),
      Prompt(
          info: bio,
          question: 'Why should you adopt me?'),
    ]);
  }
}

class Prompt extends StatelessWidget {
  final String info;
  final String question;

  const Prompt(
      {super.key,
      required this.info,
      required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 30.0, horizontal: 20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, bottom: 15.0),
                  child: Text(
                    question,
                    style: const TextStyle(
                        fontSize: 14,
                        letterSpacing: -0.4),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(
                          horizontal: 25),
                  child: Text(
                    '"$info"',
                    style: const TextStyle(
                        fontSize: 24,
                        fontFamily: "Recoleta",
                        fontWeight:
                            FontWeight.w500,
                        letterSpacing: -0.4),
                  ),
                )
              ],
            )));
  }
}

// Information Displayed
class InfoText extends StatelessWidget {
  final String svgAsset;
  final String info;

  const InfoText(
      {super.key,
      required this.svgAsset,
      required this.info});

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment:
            CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgAsset,
            width: 15,
            height: 15,
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          Text(
            isEmpty(info),
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ]);
  }
}

class ColorInfoText extends StatelessWidget {
  final String svgAsset;
  final List<String> info;

  const ColorInfoText({
    super.key,
    required this.svgAsset,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          svgAsset,
          width: 15,
          height: 15,
          colorFilter: const ColorFilter.mode(
            Colors.black,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(
          width: 7,
        ),
        ..._buildColorTexts(),
      ],
    );
  }

  List<Widget> _buildColorTexts() {
    List<Widget> widgets = [];
    for (int i = 0; i < info.length; i++) {
      widgets.add(Text(
        info[i],
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ));
      if (i < info.length - 1) {
        widgets.add(const Text(
          ', ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ));
      }
    }
    return widgets;
  }
}
