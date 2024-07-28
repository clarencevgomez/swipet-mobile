import 'package:flutter/material.dart';
import 'dart:math';

class AnimalImage extends StatefulWidget {
  final String
      image; // Assuming it's a relative URL or a local asset path

  const AnimalImage(
      {super.key, required this.image});

  @override
  State<AnimalImage> createState() =>
      _AnimalImageState();
}

class _AnimalImageState
    extends State<AnimalImage> {
  int index = 0;
  final Random random = Random();
  final String baseUrl =
      'https://swipet-becad9ab7362.herokuapp.com/'; // Replace with your actual base URL

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
      const Color.fromRGBO(242, 216, 238, 1),
      Color.fromARGB(255, 159, 128, 125),
      const Color.fromRGBO(242, 142, 163, 1)
    ];
    String imageUrl =
        'lib/images/defaultLogo-pic.jpg';
    // Check if the image is a URL or a local asset

    if (widget.image.startsWith('http')) {
      imageUrl = widget.image;
    } else if (widget.image
        .startsWith('uploads/petImages')) {
      imageUrl = '$baseUrl${widget.image}';
    }

    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 15.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: 3, color: colors[index]),
            borderRadius:
                BorderRadius.circular(15),
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

class ListAnimalImage extends StatefulWidget {
  final String image;

  const ListAnimalImage(
      {super.key, required this.image});

  @override
  State<ListAnimalImage> createState() =>
      _ListAnimalImageState();
}

class _ListAnimalImageState
    extends State<ListAnimalImage> {
  int index = 0;
  final Random random = Random();
  final String baseUrl =
      'https://swipet-becad9ab7362.herokuapp.com/';

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl =
        'lib/images/defaultLogo-pic.jpg';

    if (widget.image.startsWith('http')) {
      imageUrl = widget.image;
    } else if (widget.image
        .startsWith('uploads/petImages')) {
      imageUrl = '$baseUrl${widget.image}';
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20.0),
        child: Container(
          width: 50, // Adjust the size as needed
          height: 50,
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
