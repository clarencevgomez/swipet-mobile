import 'package:flutter/material.dart';
import 'package:swipet_mobile/components/animal_card_items/animal_images.dart';
import 'package:swipet_mobile/components/animal_card_items/info_section.dart';

class AnimalCard extends StatelessWidget {
  final Map<String, dynamic> pet;
  final List<dynamic> images;
  final String username;

  const AnimalCard({
    Key? key,
    required this.pet,
    required this.images,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(0),
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // PET NAME
                Text(
                  _safeString(pet['petName']),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),

                // FIRST IMAGE
                if (_isValidImage(images, 0))
                  AnimalImage(image: images[0]),

                const SizedBox(height: 10),

                // PET INFO COMPONENT
                AnimalInfoCard(
                  age: _safeString(pet['age']),
                  breed:
                      _safeString(pet['breed']),
                  gender:
                      _safeString(pet['gender']),
                  location: _safeString(
                      pet['location']),
                  color: List<String>.from(
                      pet['color'] ?? ['N/A']),
                  petType:
                      _safeString(pet['petType']),
                  bio: _safeString(pet['bio']),
                  contactEmail: _safeString(
                      pet['contactEmail']),
                  adoptionFee: _safeString(
                      pet['adoptionFee']),
                  username: _safeString(username),
                  p1: _safeString(pet['prompt1']),
                  p2: _safeString(pet['prompt2']),
                ),
                const SizedBox(height: 10),

                // SECOND IMAGE
                if (_isValidImage(images, 1))
                  AnimalImage(image: images[1]),

                const SizedBox(height: 10),

                // PROMPT 1
                if (_isValidString(
                    pet['prompt1']))
                  Prompt(
                    info:
                        pet['prompt1'].toString(),
                    question:
                        'Why should you adopt me',
                  ),
                const SizedBox(height: 10),

                // THIRD IMAGE
                if (_isValidImage(images, 2))
                  AnimalImage(image: images[2]),

                const SizedBox(height: 10),

                // PROMPT 2
                if (_isValidString(
                    pet['prompt2']))
                  Prompt(
                    info:
                        pet['prompt2'].toString(),
                    question:
                        'My favorite thing(s) to do are:',
                  ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _safeString(dynamic data) {
    return data?.toString() ?? 'N/A';
  }

  bool _isValidString(String? data) {
    return data != null &&
        data.isNotEmpty &&
        data != 'null';
  }

  bool _isValidImage(
      List<dynamic> images, int index) {
    return images.length > index &&
        _isValidString(images[index]?.toString());
  }
}
