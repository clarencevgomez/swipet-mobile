
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
      'https://swipet-becad9ab7362.herokuapp.com/'; 

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

class MatchImage extends StatefulWidget {
  final String
      image; // Assuming it's a relative URL or a local asset path

  const MatchImage(
      {super.key, required this.image});

  @override
  State<MatchImage> createState() =>
      _MatchImageState();
}

class _MatchImageState extends State<MatchImage> {
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

// // NOT WORKING YET
// class EditAnimalImage extends StatefulWidget {
//   final String
//       image; // Assuming it's a relative URL or a local asset path
//   final List<dynamic>
//       imagePaths; // List of existing image paths
//   final List<File>
//       animalImages; // List of existing image files

//   const EditAnimalImage({
//     super.key,
//     required this.image,
//     required this.imagePaths,
//     required this.animalImages,
//   });

//   @override
//   State<EditAnimalImage> createState() =>
//       _EditAnimalImageState();
// }

// class _EditAnimalImageState
//     extends State<EditAnimalImage> {
//   int index = 0;
//   final Random random = Random();
//   final ImagePicker _picker = ImagePicker();
//   final String baseUrl =
//       'https://swipet-becad9ab7362.herokuapp.com/'; // Heroku base URL

//   @override
//   void initState() {
//     super.initState();
//     changeIndex();
//     _loadExistingImages();
//   }

//   void changeIndex() {
//     setState(() => index = random.nextInt(3));
//   }

//   void _loadExistingImages() {
//     for (var imagePath in widget.imagePaths) {
//       if (imagePath is String) {
//         widget.animalImages.add(File(imagePath));
//       }
//     }
//   }

//   Future<void> _selectImage() async {
//     final XFile? img = await _picker.pickImage(
//         source: ImageSource.gallery);
//     if (img != null) {
//       setState(() {
//         widget.animalImages.add(File(img.path));
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Color> colors = [
//       const Color.fromRGBO(242, 216, 238, 1),
//       const Color.fromARGB(255, 159, 128, 125),
//       const Color.fromRGBO(242, 142, 163, 1),
//     ];
//     String imageUrl =
//         'lib/images/defaultLogo-pic.jpg';

//     if (widget.image.startsWith('http')) {
//       imageUrl = widget.image;
//     } else if (widget.image
//         .startsWith('uploads/petImages')) {
//       imageUrl = '$baseUrl${widget.image}';
//     }

//     return AspectRatio(
//       aspectRatio: 1 / 1,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//             vertical: 15.0),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(
//                     width: 3,
//                     color: colors[index]),
//                 borderRadius:
//                     BorderRadius.circular(15),
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   alignment:
//                       FractionalOffset.center,
//                   image: _getImageProvider(),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 10,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   foregroundColor: Colors.black,
//                   backgroundColor: Colors.white70,
//                 ),
//                 onPressed: _selectImage,
//                 child: Row(
//                   mainAxisAlignment:
//                       MainAxisAlignment.center,
//                   children: [
//                     const Text('Change Photo',
//                         style: TextStyle(
//                             fontSize: 16)),
//                     const SizedBox(width: 10),
//                     const Icon(
//                         Icons
//                             .file_upload_outlined,
//                         size: 24),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   ImageProvider _getImageProvider() {
//     if (widget.image.startsWith('http')) {
//       return NetworkImage(widget.image);
//     } else if (widget.image.startsWith(
//         'https://swipet-becad9ab7362.herokuapp.com/uploads/petImages')) {
//       return NetworkImage(
//           '$baseUrl${widget.image}');
//     } else {
//       return AssetImage(widget.image)
//           as ImageProvider;
//     }
//   }
// }
