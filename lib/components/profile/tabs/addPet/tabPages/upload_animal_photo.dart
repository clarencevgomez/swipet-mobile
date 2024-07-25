import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swipet_mobile/components/profile/profile_button.dart';
import 'package:swipet_mobile/components/profile/tabs/addPet/tabPages/animal_info_image.dart';
import 'package:swipet_mobile/dbHelper/api_service.dart';
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

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? pickedFiles =
        await _picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        _images.addAll(pickedFiles.map(
            (pickedFile) =>
                File(pickedFile.path)));
      });
    }
  }

  Future<void> _uploadImages() async {
    final apiService = ApiService();
    if (_images.isNotEmpty) {
      try {
        final result = await apiService
            .uploadPetImages(_images);
        if (result['status'] == 'success') {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            const SnackBar(
                content: Text(
                    'Images uploaded successfully!')),
          );
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            SnackBar(
                content: Text(
                    'Upload failed: ${result['message']}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
              content:
                  Text('An error occurred: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('No images selected')),
      );
    }
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
                    AnimalBioImage(
                      image: '',
                      // animalImages:
                      //     widget.pet.images,
                      photoNum: 1,
                    ),
                    AnimalBioImage(
                      image: '',
                      // animalImages:
                      //     widget.pet.images,
                      photoNum: 2,
                    ),
                    AnimalBioImage(
                      image: '',
                      // animalImages:
                      //     widget.pet.images,
                      photoNum: 3,
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
                    onPressed: () async {
                      await _uploadImages();
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
}
