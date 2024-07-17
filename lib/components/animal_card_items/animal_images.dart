import 'package:flutter/material.dart';
import 'dart:math';

class AnimalImage extends StatefulWidget {
  final String image;

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
      const Color.fromRGBO(242, 162, 155, 1),
      const Color.fromRGBO(242, 142, 163, 1)
    ];

    // Commenting out changeIndex() in build method to prevent infinite loop
    // changeIndex();

    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 15.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                width: 3, color: colors[index]),
            color: Colors.black,
            borderRadius:
                BorderRadius.circular(15),
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: FractionalOffset.center,
              image: NetworkImage(widget.image),
            ),
          ),
        ),
      ),
    );
  }
}
