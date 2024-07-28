import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:swipet_mobile/components/animal_card_items/vertical_divider.dart';

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
  final String p1;
  final String p2;
  const AnimalInfoCard({
    super.key,
    this.age = 'N/A',
    this.breed = 'N/A',
    this.gender = 'N/A',
    this.location = 'N/A',
    this.color = const ['N/A'],
    this.petType = 'N/A',
    this.bio = 'N/A',
    this.contactEmail = 'N/A',
    this.adoptionFee = '0',
    this.username = 'N/A',
    required this.p1,
    required this.p2,
  });

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

    return Column(
      children: [
        Container(
          width:
              MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
            borderRadius:
                BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection:
                      Axis.horizontal,
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.start,
                      children: [
                        InfoText(
                          svgAsset:
                              'lib/assets/animalInfo/pet_age.svg',
                          info: isEmpty(age),
                        ),
                        const InfoDivider(),
                        InfoText(
                          svgAsset:
                              'lib/assets/animalInfo/gender-${getGender(gender)}.svg',
                          info: isEmpty(gender),
                        ),
                        const InfoDivider(),
                        InfoText(
                          svgAsset:
                              'lib/assets/animalInfo/map.svg',
                          info: isEmpty(location),
                        ),
                        const InfoDivider(),
                        InfoText(
                          svgAsset:
                              'lib/assets/animalInfo/breed.svg',
                          info: isEmpty(breed),
                        ),
                        const InfoDivider(),
                        ColorInfoText(
                          svgAsset:
                              'lib/assets/animalInfo/palette.svg',
                          info: color,
                        ),
                      ],
                    ),
                  ),
                ),
                const InfoHDivider(),
                InfoText(
                  svgAsset:
                      'lib/assets/animalInfo/pet_fee.svg',
                  info:
                      "\$${f.format(int.tryParse(adoptionFee) ?? 0)}",
                ),
                const InfoHDivider(),
                InfoText(
                  svgAsset:
                      'lib/assets/animalInfo/stars.svg',
                  info: isEmpty(petType),
                ),
                const InfoHDivider(),
                InfoText(
                  svgAsset:
                      'lib/assets/animalInfo/postage-heart.svg',
                  info: isEmpty(contactEmail),
                ),
                const InfoHDivider(),
                InfoText(
                  svgAsset:
                      'lib/assets/postcard-heart.svg',
                  info:
                      'Listed by ${isUserEmpty(username)}',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 25),
        if (bio.isNotEmpty == true &&
            bio.toString() != 'null')
          Prompt(
            info: bio,
            question: 'About Me',
          ),
      ],
    );
  }
}

class Prompt extends StatelessWidget {
  final String info;
  final String question;

  const Prompt({
    Key? key,
    this.info = 'N/A',
    this.question = 'N/A',
  }) : super(key: key);

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
              padding: const EdgeInsets.symmetric(
                  horizontal: 25),
              child: Text(
                '"$info"',
                style: const TextStyle(
                  fontSize: 24,
                  fontFamily: "Recoleta",
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Define the main component
class InfoText extends StatelessWidget {
  final String svgAsset;
  final String info;

  const InfoText({
    Key? key,
    required this.svgAsset,
    this.info = 'N/A',
  }) : super(key: key);

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
        const SizedBox(width: 7),
        Text(
          isEmpty(info),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String isEmpty(String? value) {
    return value?.isNotEmpty == true
        ? value!
        : 'N/A';
  }
}

class ColorInfoText extends StatelessWidget {
  final String svgAsset;
  final List<String> info;

  const ColorInfoText({
    Key? key,
    required this.svgAsset,
    this.info = const ['N/A'],
  }) : super(key: key);

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
        const SizedBox(width: 7),
        ..._buildColorTexts(),
      ],
    );
  }

  List<Widget> _buildColorTexts() {
    List<Widget> widgets = [];
    for (int i = 0; i < info.length; i++) {
      widgets.add(Text(
        isEmpty(info[i]),
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

  String isEmpty(String? value) {
    return value?.isNotEmpty == true
        ? value!
        : 'N/A';
  }
}
