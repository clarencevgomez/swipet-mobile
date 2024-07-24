// ignore_for_file: library_private_types_in_public_api

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math';

import 'package:swipet_mobile/utils/utils.dart';

class ProfileImage extends StatefulWidget {
  final String image;

  const ProfileImage(
      {super.key, required this.image});

  @override
  State<ProfileImage> createState() =>
      _ProfileImageState();
}

class _ProfileImageState
    extends State<ProfileImage> {
  int index = 0;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    changeIndex();
  }

  void changeIndex() {
    setState(() => index = random.nextInt(3));
  }

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      const Color.fromARGB(255, 255, 159, 241),
      const Color.fromRGBO(242, 162, 155, 1),
      const Color.fromRGBO(242, 142, 163, 1),
    ];
    List<Color> blurColors = [
      const Color.fromRGBO(255, 71, 227, 1),
      const Color.fromARGB(255, 255, 21, 0),
      const Color.fromARGB(255, 255, 4, 71),
    ];
    String imageUrl = widget.image.isNotEmpty
        ? widget.image
        : 'lib/images/defaultLogo-pic.jpg';

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 125,
          height: 125,
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: colors[index],
              width: 10,
            ),
            boxShadow: [
              BoxShadow(
                color: blurColors[index]
                    .withOpacity(1),
                blurRadius: 200,
                offset: const Offset(0, 0),
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15.0),
            child: Container(
              width: 115,
              height: 115,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 3,
                    color: colors[index]),
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment:
                      FractionalOffset.center,
                  image:
                      imageUrl.startsWith('http')
                          ? NetworkImage(imageUrl)
                          : AssetImage(imageUrl)
                              as ImageProvider,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AnimalProfileImage extends StatefulWidget {
  final String image;

  const AnimalProfileImage(
      {super.key, required this.image});

  @override
  _AnimalProfileImageState createState() =>
      _AnimalProfileImageState();
}

class _AnimalProfileImageState
    extends State<AnimalProfileImage> {
  int index = 0;
  final Random random = Random();
  Uint8List? _animalImage;

  @override
  void initState() {
    super.initState();
    changeIndex();
  }

  Future<void> _selectImage() async {
    Uint8List img =
        await pickImage(ImageSource.gallery);
    setState(() {
      _animalImage = img;
    });
  }

  void changeIndex() {
    setState(() => index = random.nextInt(3));
  }

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      const Color.fromARGB(255, 255, 159, 241),
      const Color.fromRGBO(242, 162, 155, 1),
      const Color.fromRGBO(242, 142, 163, 1),
    ];
    String imageUrl = widget.image.isNotEmpty
        ? widget.image
        : 'lib/images/defaultLogo-pic.jpg';

    ImageProvider imageProvider;
    if (_animalImage != null) {
      imageProvider = MemoryImage(_animalImage!);
    } else if (imageUrl.startsWith('http')) {
      imageProvider = NetworkImage(imageUrl);
    } else {
      imageProvider = AssetImage(imageUrl);
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: colors[index],
              width: 10,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15.0),
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 3,
                    color: colors[index]),
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment:
                      FractionalOffset.center,
                  image: imageProvider,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -8,
          right: -11,
          child: IconButton(
            onPressed: _selectImage,
            icon: const Icon(
              Icons.add_a_photo_rounded,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
