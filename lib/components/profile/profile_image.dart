import 'package:flutter/material.dart';
import 'dart:math';

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
      const Color.fromRGBO(242, 142, 163, 1)
    ];
    List<Color> blurColors = [
      const Color.fromRGBO(255, 71, 227, 1),
      const Color.fromARGB(255, 255, 21, 0),
      const Color.fromARGB(255, 255, 4, 71)
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
            color: Colors
                .transparent, // Transparent color to show the border
            shape: BoxShape.circle,
            border: Border.all(
              color:
                  colors[index], // Border color
              width: 10, // Border width
            ),
            boxShadow: [
              BoxShadow(
                color: blurColors[index]
                    .withOpacity(
                        1), // Shadow color
                blurRadius: 200, // Blur radius
                offset: const Offset(0,
                    0), // Offset in x and y directions
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15.0),
            child: Container(
              width:
                  115, // Adjust the size as needed
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
        )
      ],
    );
  }
}
