import 'package:flutter/material.dart';
import 'package:swipet_mobile/components/animalBioItems/animal_text_field.dart';
import 'package:swipet_mobile/components/profile/profile_image.dart';

// ignore: must_be_immutable
class PetNameArea extends StatelessWidget {
  final String petImage;
  final String fName;
  String? lName;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  PetNameArea({
    super.key,
    required this.petImage,
    required this.fName,
    this.lName,
    required this.firstNameController,
    required this.lastNameController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: [
              AnimalProfileImage(image: petImage),
              const SizedBox(width: 50),
              Expanded(
                child: Column(
                  children: [
                    // First Name
                    MyAnimalTextField(
                      placeholder: 'First Name*',
                      controller:
                          firstNameController,
                      obscureText: false,
                      height: 50,
                      horizontal: 0,
                      width:
                          MediaQuery.of(context)
                                  .size
                                  .width -
                              20,
                    ),
                    // Last Name
                    MyAnimalTextField(
                      placeholder:
                          "Pet's Last Name (Optional)",
                      controller:
                          lastNameController,
                      obscureText: false,
                      height: 50,
                      horizontal: 0,
                      width:
                          MediaQuery.of(context)
                                  .size
                                  .width -
                              20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must be immutable
class AdoptionFeeField extends StatelessWidget {
  final String feeAmnt;
  final TextEditingController feeController;

  const AdoptionFeeField({
    super.key,
    required this.feeAmnt,
    required this.feeController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 0.0),
        child: Column(
          children: [
            Row(
              children: [
                const PetFieldTitle(
                    title: 'Adoption Fee*: \$ '),
                SizedBox(
                  width: MediaQuery.of(context)
                          .size
                          .width /
                      3,
                ),
                Expanded(
                  child: MyAnimalTextField(
                      placeholder: 'Adoption Fee',
                      controller: feeController,
                      obscureText: false,
                      height: 50,
                      horizontal: 0,
                      width:
                          MediaQuery.of(context)
                              .size
                              .width),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
