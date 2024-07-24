import 'package:flutter/material.dart';
import 'package:swipet_mobile/components/profile/profile_button.dart';
import 'package:swipet_mobile/components/profile/tabs/addPet/tabPages/animal_info_image.dart';

class UploadAnimalPhoto extends StatefulWidget {
  final TabController tabController;

  const UploadAnimalPhoto(
      {super.key, required this.tabController});

  @override
  State<UploadAnimalPhoto> createState() =>
      _UploadAnimalPhotoState();
}

class _UploadAnimalPhotoState
    extends State<UploadAnimalPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom:
                      80.0), // Enough space for the floating button
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.0),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    AnimalBioImage(
                      image: '',
                      photoNum: 1,
                    ),
                    AnimalBioImage(
                      image: '',
                      photoNum: 2,
                    ),
                    AnimalBioImage(
                      image: '',
                      photoNum: 3,
                    ),
                    SizedBox(
                      height: 50,
                    ),
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
                  // NEXT BUTTON
                  ProfileButton(
                    backgroundColor:
                        const Color.fromRGBO(
                            242, 145, 163, 1),
                    svgAsset: '',
                    onPressed: () {
                      // Navigate to the next tab
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
