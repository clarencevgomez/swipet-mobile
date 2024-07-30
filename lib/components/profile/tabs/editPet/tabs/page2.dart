import 'dart:io';

import 'package:flutter/material.dart';
import 'package:swipet_mobile/components/animal_card_items/animal_images.dart';
import 'package:swipet_mobile/components/profile/profile_button.dart';
import 'package:swipet_mobile/components/profile/tabs/editPet/tabs/page3.dart';
import 'package:swipet_mobile/objects/newPetModel.dart';

class EditAnimalPhoto extends StatefulWidget {
  final Map<String, dynamic> oldPet;
  final NewPet pet;
  final TabController tabController;

  const EditAnimalPhoto({
    Key? key,
    required this.pet,
    required this.tabController,
    required this.oldPet,
  }) : super(key: key);

  @override
  State<EditAnimalPhoto> createState() =>
      _EditAnimalPhotoState();
}

class _EditAnimalPhotoState
    extends State<EditAnimalPhoto> {
  final List<String> _imageUrls = [];
  final String baseUrl =
      'https://swipet-becad9ab7362.herokuapp.com/'; // Your network base URL

  @override
  void initState() {
    super.initState();
    // Load existing image URLs if available
    if (widget.oldPet['Images'] != null) {
      for (var imagePath
          in widget.oldPet['Images']) {
        String fullPath = imagePath
                .startsWith('http')
            ? imagePath // Use the full URL if it starts with http
            : '$baseUrl$imagePath'; // Prepend the base URL if it's a relative path

        _imageUrls.add(fullPath);
      }
    }
  }

  bool _isValidImage(
      List<dynamic> images, int index) {
    return images.length > index &&
        _isValidString(images[index]?.toString());
  }

  bool _isValidString(String? data) {
    return data != null &&
        data.isNotEmpty &&
        data != 'null';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(
                  bottom: 80.0),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(
                        horizontal: 16.0),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    // EditAnimalImage(
                    //   image:
                    //       'lib/images/default-image.jpg',
                    //   imagePaths: _imageUrls,
                    //   animalImages: [], // Pass empty for now if not using local images
                    // ),
                    PromptBanner(
                        title: 'Coming Soon'
                            .toUpperCase(),
                        description:
                            'this feature only Available on the website for now!'),
                    if (_isValidImage(
                        widget.oldPet['Images'],
                        0))
                      AnimalImage(
                          image: widget.oldPet[
                              'Images'][0]),
                    if (_isValidImage(
                        widget.oldPet['Images'],
                        1))
                      AnimalImage(
                          image: widget.oldPet[
                              'Images'][1]),
                    if (_isValidImage(
                        widget.oldPet['Images'],
                        2))
                      AnimalImage(
                          image: widget.oldPet[
                              'Images'][2]),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 16,
              right: 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileButton(
                      backgroundColor:
                          const Color.fromRGBO(
                              242, 145, 163, 1),
                      svgAsset: '',
                      onPressed: () {
                        debugPrintPetData(
                            context);
                        if (widget.tabController
                                .index <
                            widget.tabController
                                    .length -
                                1) {
                          widget.tabController
                              .animateTo(widget
                                      .tabController
                                      .index +
                                  1);
                        }
                      },
                      actionText:
                          'Next'.toUpperCase()),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void debugPrintPetData(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pet Data'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                    'User Login: ${widget.pet.userLogin}'),
                Text(
                    'Pet Name: ${widget.pet.petName}'),
                Text('Type: ${widget.pet.type}'),
                Text(
                    'Pet Age: ${widget.pet.petAge}'),
                Text(
                    'Pet Gender: ${widget.pet.petGender}'),
                Text(
                    'Colors: ${widget.pet.colors.join(', ')}'),
                Text(
                    'Breed: ${widget.pet.breed}'),
                Text(
                    'Pet Size: ${widget.pet.petSize}'),
                Text('Bio: ${widget.pet.bio}'),
                Text(
                    'Prompt 1: ${widget.pet.prompt1}'),
                Text(
                    'Prompt 2: ${widget.pet.prompt2}'),
                Text(
                    'Contact Email: ${widget.pet.contactEmail}'),
                Text(
                    'Location: ${widget.pet.location}'),
                Text('Images:'),
                Row(
                  children: widget.pet.images
                      .map((url) {
                    return Image.file(url,
                        height: 100, width: 100);
                  }).toList(),
                ),
                Text(
                    'Adoption Fee: ${widget.pet.adoptionFee}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
