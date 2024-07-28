import 'dart:math';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AnimalBioImage extends StatefulWidget {
  final String image;
  final List<int> photoNums;
  final List<File> animalImages;

  const AnimalBioImage({
    super.key,
    required this.image,
    required this.photoNums,
    required this.animalImages,
  });

  @override
  _AnimalBioImageState createState() =>
      _AnimalBioImageState();
}

class _AnimalBioImageState
    extends State<AnimalBioImage> {
  final Random random = Random();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectImage() async {
    XFile? img = await ImagePicker()
        .pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        widget.animalImages.add(File(img.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      const Color.fromARGB(255, 255, 159, 241),
      const Color.fromRGBO(242, 162, 155, 1),
      const Color.fromRGBO(242, 142, 163, 1),
    ];

    int colorIndex =
        random.nextInt(colors.length);

    return Column(
      children: [
        AnimalImageCard(
          imageProvider: _getImageProvider(0),
          animalImages: widget.animalImages,
          onSelectImage: _selectImage,
          photoNum: widget.photoNums[0],
          borderColor: colors[colorIndex],
        ),
        AnimalImageCard(
          imageProvider: _getImageProvider(1),
          animalImages: widget.animalImages,
          onSelectImage: _selectImage,
          photoNum: widget.photoNums[1],
          borderColor: colors[colorIndex],
        ),
        AnimalImageCard(
          imageProvider: _getImageProvider(2),
          animalImages: widget.animalImages,
          onSelectImage: _selectImage,
          photoNum: widget.photoNums[2],
          borderColor: colors[colorIndex],
        ),
      ],
    );
  }

  ImageProvider _getImageProvider(int index) {
    if (widget.animalImages.length > index) {
      return FileImage(
          widget.animalImages[index]);
    } else if (widget.image.startsWith('http')) {
      return NetworkImage(widget.image);
    } else {
      return AssetImage(widget.image);
    }
  }
}

class AnimalImageCard extends StatelessWidget {
  final ImageProvider imageProvider;
  final List<File> animalImages;
  final Future<void> Function() onSelectImage;
  final int photoNum;
  final Color borderColor;

  const AnimalImageCard({
    super.key,
    required this.imageProvider,
    required this.animalImages,
    required this.onSelectImage,
    required this.photoNum,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
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
                    width: 3, color: borderColor),
                borderRadius:
                    BorderRadius.circular(15),
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
          child: FilledButton(
            style: FilledButton.styleFrom(
                backgroundColor:
                    Colors.transparent),
            onPressed: onSelectImage,
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Text(
                  animalImages.isNotEmpty
                      ? 'Photo $photoNum'
                      : 'No Photo',
                  style: const TextStyle(
                      fontSize: 40),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.file_upload_outlined,
                  size: 60,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
