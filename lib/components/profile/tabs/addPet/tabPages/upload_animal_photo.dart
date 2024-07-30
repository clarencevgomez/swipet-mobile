import 'package:flutter/material.dart';
import 'package:swipet_mobile/components/profile/profile_button.dart';
import 'package:swipet_mobile/components/profile/tabs/addPet/tabPages/animal_info_image.dart';
import 'dart:io';

import 'package:swipet_mobile/objects/newPetModel.dart';

class UploadAnimalPhoto extends StatefulWidget {
  final NewPet pet;
  final TabController tabController;

  const UploadAnimalPhoto({
    Key? key,
    required this.pet,
    required this.tabController,
  }) : super(key: key);

  @override
  State<UploadAnimalPhoto> createState() =>
      _UploadAnimalPhotoState();
}

class _UploadAnimalPhotoState
    extends State<UploadAnimalPhoto> {
  final List<File> _images = [];

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
                    AnimalBioImage(
                      image:
                          'lib/images/default-image.jpg',
                      animalImages: _images,
                      photoNums: [1, 2, 3],
                    ),
                    const SizedBox(height: 50),
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
                      setState(() {
                        // add to new pet once done
                        widget.pet.images =
                            _images;
                      });
                      // debugPrintPetData(context);
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
                    actionText: 'Next',
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//   void debugPrintPetData(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Pet Data'),
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment:
//                   CrossAxisAlignment.start,
//               children: [
//                 Text(
//                     'User Login: ${widget.pet.userLogin}'),
//                 Text(
//                     'Pet Name: ${widget.pet.petName}'),
//                 Text('Type: ${widget.pet.type}'),
//                 Text(
//                     'Pet Age: ${widget.pet.petAge}'),
//                 Text(
//                     'Pet Gender: ${widget.pet.petGender}'),
//                 Text(
//                     'Colors: ${widget.pet.colors.join(', ')}'),
//                 Text(
//                     'Breed: ${widget.pet.breed}'),
//                 Text(
//                     'Pet Size: ${widget.pet.petSize}'),
//                 Text('Bio: ${widget.pet.bio}'),
//                 Text(
//                     'Prompt 1: ${widget.pet.prompt1}'),
//                 Text(
//                     'Prompt 2: ${widget.pet.prompt2}'),
//                 Text(
//                     'Contact Email: ${widget.pet.contactEmail}'),
//                 Text(
//                     'Location: ${widget.pet.location}'),
//                 Text('Images:'),
//                 Row(
//                   children: widget.pet.images
//                       .map((file) {
//                     return Image.file(file,
//                         height: 100, width: 100);
//                   }).toList(),
//                 ),
//                 Text(
//                     'Adoption Fee: ${widget.pet.adoptionFee}'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
}
