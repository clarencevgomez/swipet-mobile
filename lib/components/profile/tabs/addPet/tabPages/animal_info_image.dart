import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swipet_mobile/utils/utils.dart';

class AnimalBioImage extends StatefulWidget {
  final String image;
  final int photoNum;

  const AnimalBioImage(
      {super.key,
      required this.image,
      required this.photoNum});

  @override
  _AnimalProfileImageState createState() =>
      _AnimalProfileImageState();
}

class _AnimalProfileImageState
    extends State<AnimalBioImage> {
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
        : '';

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
        AspectRatio(
          aspectRatio: 1 / 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                    255, 255, 162, 193),
                border: Border.all(
                    width: 3,
                    color: colors[index]),
                // color: Colors.black,
                borderRadius:
                    BorderRadius.circular(15),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment:
                        FractionalOffset.center,
                    image: imageProvider),
              ),
            ),
          ),
        ),
        Positioned(
          child: FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor:
                    Colors.transparent),
            onPressed: _selectImage,
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Text(
                  'Photo ${widget.photoNum}',
                  style: const TextStyle(
                      fontSize: 40),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  Icons.file_upload_outlined,
                  size: 60,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
