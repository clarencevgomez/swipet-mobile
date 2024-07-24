import 'package:flutter/material.dart';
import 'package:swipet_mobile/components/animalBioItems/animal_text_field.dart';
import 'package:swipet_mobile/components/animal_card_items/vertical_divider.dart';
import 'package:swipet_mobile/components/profile/profile_button.dart';
import 'package:swipet_mobile/components/profile/tabs/addPet/tabPages/animalFields/animal_bio.dart';
import 'package:swipet_mobile/components/profile/tabs/addPet/tabPages/animalFields/animal_chip_filters.dart';
import 'package:swipet_mobile/components/profile/tabs/addPet/tabPages/animalFields/animal_name_field.dart';
import 'package:swipet_mobile/components/profile/tabs/addPet/tabPages/animalFields/pet_fields.dart';
import 'package:swipet_mobile/components/profile/tabs/addPet/tabPages/color_dropdown.dart';
import 'package:swipet_mobile/dbHelper/api_service.dart';

class NewAnimalInfo extends StatefulWidget {
  final TabController tabController;

  const NewAnimalInfo(
      {super.key, required this.tabController});

  @override
  State<NewAnimalInfo> createState() =>
      _NewAnimalInfoState();
}

class _NewAnimalInfoState
    extends State<NewAnimalInfo> {
  // Name
  final firstNameController =
      TextEditingController();
  final lastNameController =
      TextEditingController();
  // Age
  final ageYearController =
      TextEditingController();
  final ageMonthController =
      TextEditingController();
  // Fee
  final feeController = TextEditingController();
  // Location
  final cityLocController =
      TextEditingController();
  final stateLocController =
      TextEditingController();
  final zipLocController =
      TextEditingController();
  // Pet Story
  final petStoryController =
      TextEditingController();
  // Breed
  final breedController = TextEditingController();

  final ApiService apiService = ApiService();

  // WITH API SERVICE
  Future<void> _addPet() async {
    // Here you should add the logic to send data to your API service
    // For example:
    // await apiService.addPet(...);
    _clearAll();
  }

  void _clearAll() {
    firstNameController.clear();
    lastNameController.clear();
    ageYearController.clear();
    ageMonthController.clear();
    feeController.clear();
    cityLocController.clear();
    stateLocController.clear();
    zipLocController.clear();
    petStoryController.clear();
    breedController.clear();
  }

  String petType = '';
  String petSize = '';
  double space = 12.0;

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> petTypes = [
      {
        'type': 'Dog',
        'asset':
            'lib/assets/animalProfile/animalChipSvgs/Dog.svg'
      },
      {
        'type': 'Cat',
        'asset':
            'lib/assets/animalProfile/animalChipSvgs/cat.svg'
      },
      {
        'type': 'Other',
        'asset':
            'lib/assets/animalProfile/animalChipSvgs/other.svg'
      },
    ];

    List<Map<String, String>> petSizes = [
      {'size': 'Small', 'weight': '0-25 lbs'},
      {'size': 'Medium', 'weight': '26-60 lbs'},
      {'size': 'Large', 'weight': '61-100 lbs'},
      {'size': 'X-Large', 'weight': '>101 lbs'},
    ];

    List<String> petColors = [
      "",
      "Red",
      "Blue",
      "White",
      "Brown",
      "Black",
      "Yellow",
      "Green",
      "Purple",
      "Orange",
      "Pink"
    ];

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(
                  bottom:
                      80.0), // Enough space for the floating button
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(
                        horizontal: 16.0),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    //PET IMAGE, FIRST NAME, LAST NAME
                    PetNameArea(
                      petImage:
                          'lib/images/Forgot-Password-Cat.png',
                      fName: '',
                      firstNameController:
                          firstNameController,
                      lastNameController:
                          lastNameController,
                    ),

                    // ANIMAL ADOPTION FEE TEXT FIELDS
                    Padding(
                      padding:
                          EdgeInsets.symmetric(
                              vertical: space),
                      child: AdoptionFeeField(
                        feeAmnt: '',
                        feeController:
                            feeController,
                      ),
                    ),

                    // AGE CONTROLLER
                    Padding(
                      padding:
                          EdgeInsets.symmetric(
                              vertical: space),
                      child: PetAgeField(
                        ageYearController:
                            ageYearController,
                        ageMonthController:
                            ageMonthController,
                      ),
                    ),

                    // LOCATION INPUT CONTROLLER
                    Padding(
                      padding:
                          EdgeInsets.symmetric(
                              vertical: space),
                      child: PetLocationField(
                        cityLocController:
                            cityLocController,
                        stateLocController:
                            stateLocController,
                        zipLocController:
                            zipLocController,
                      ),
                    ),
                    const AnimalInfoHDivider(),
                    // BREED CONTROLLER
                    Padding(
                      padding:
                          EdgeInsets.symmetric(
                              vertical: space),
                      child: PetBreedField(
                        breedController:
                            breedController,
                      ),
                    ),

                    // PET TYPES
                    Padding(
                      padding:
                          EdgeInsets.symmetric(
                              vertical: space),
                      child: PetType(
                        petTypes: petTypes,
                        petType: petType,
                      ),
                    ),
                    // PET SIZES
                    const SizedBox(height: 16),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(
                              vertical: space),
                      child: PetSize(
                        petSizes: petSizes,
                        petSize: petSize,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // PET COLOR
                    Padding(
                      padding:
                          EdgeInsets.symmetric(
                              vertical: space),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets
                                    .symmetric(
                                        horizontal:
                                            0.0),
                                child: PetFieldTitle(
                                    title:
                                        "Color"),
                              ),
                            ],
                          ),
                          CustomDropdown(
                            initialValue: "",
                            items: petColors,
                          ),
                        ],
                      ),
                    ),

                    const AnimalInfoHDivider(),
                    // PET STORY
                    Padding(
                      padding:
                          EdgeInsets.symmetric(
                              vertical: space),
                      child: LargeTextField(
                        label:
                            "What's the story behind this pet?",
                        placeholder:
                            'Write a small bio about this pet <150 words',
                        controller:
                            petStoryController,
                      ),
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

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    ageYearController.dispose();
    ageMonthController.dispose();
    feeController.dispose();
    cityLocController.dispose();
    stateLocController.dispose();
    zipLocController.dispose();
    petStoryController.dispose();
    breedController.dispose();
    super.dispose();
  }
}
