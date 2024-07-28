import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:swipet_mobile/components/animalBioItems/animal_text_field.dart';
import 'package:swipet_mobile/components/animal_card_items/vertical_divider.dart';
import 'package:swipet_mobile/components/profile/profile_button.dart';
import 'package:swipet_mobile/components/profile/tabs/addPet/tabPages/animalFields/animal_bio.dart';
import 'package:swipet_mobile/components/profile/tabs/addPet/tabPages/animalFields/animal_chip_filters.dart';
import 'package:swipet_mobile/components/profile/tabs/addPet/tabPages/animalFields/animal_name_field.dart';
import 'package:swipet_mobile/components/profile/tabs/addPet/tabPages/animalFields/pet_fields.dart';
import 'package:swipet_mobile/components/profile/tabs/addPet/tabPages/color_dropdown.dart';
import 'package:swipet_mobile/dbHelper/api_service.dart';
import 'package:swipet_mobile/objects/newPetModel.dart';

class NewAnimalInfo extends StatefulWidget {
  final NewPet pet;
  final TabController tabController;

  const NewAnimalInfo({
    super.key,
    required this.pet,
    required this.tabController,
  });

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
  String userLogin = '';
  String contactEmail = '';
  String petType = '';
  String petSize = '';
  double space = 12.0;
  String petColor = '';
  String petGender = '';

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

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    const FlutterSecureStorage storage =
        FlutterSecureStorage();
    String? token =
        await storage.read(key: 'jwtToken');
    if (token != null) {
      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(token);
      if (kDebugMode) {
        print("Decoded Token: $decodedToken");
      }
      setState(() {
        userLogin = decodedToken['username'] ??
            'Unknown User';
        contactEmail =
            decodedToken['email'] ?? '';
      });
    }
  }

  void _updatePetData() {
    setState(() {
      widget.pet.userLogin = userLogin;
      widget.pet.contactEmail = contactEmail;
      widget.pet.petName =
          "${firstNameController.text} ${lastNameController.text}";
      widget.pet.petAge =
          "${ageYearController.text} years ${ageMonthController.text} months";
      widget.pet.petGender = petGender;
      widget.pet.breed = breedController.text;
      widget.pet.petSize = petSize;
      widget.pet.bio = petStoryController.text;
      widget.pet.location =
          "${cityLocController.text}, ${stateLocController.text} ${zipLocController.text}";
      widget.pet.adoptionFee = feeController.text;

      List<String> updatedColors =
          List.from(widget.pet.colors);
      if (petColor.isNotEmpty &&
          !updatedColors.contains(petColor)) {
        updatedColors.add(petColor);
      }
      widget.pet.colors = updatedColors;

      widget.pet.type = petType;
    });
  }

  void debugPrintPetData(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pet Data'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                    'User Login: ${widget.pet.userLogin}'),
                Text(
                    'Pet Name: ${widget.pet.petName}'),
                Text('Type: ${widget.pet.type}'),
                Text(
                    'Pet Age: ${widget.pet.petAge}'),
                Text(
                    'Pet Gender: ${widget.pet.petGender}'),
                Text(
                    'Colors: ${widget.pet.colors.join(', ')}'),
                Text(
                    'Breed: ${widget.pet.breed}'),
                Text(
                    'Pet Size: ${widget.pet.petSize}'),
                Text('Bio: ${widget.pet.bio}'),
                Text(
                    'Prompt 1: ${widget.pet.prompt1}'),
                Text(
                    'Prompt 2: ${widget.pet.prompt2}'),
                Text(
                    'Contact Email: ${widget.pet.contactEmail}'),
                Text(
                    'Location: ${widget.pet.location}'),
                Text(
                    'Images: ${widget.pet.images.join(', ')}'),
                Text(
                    'Adoption Fee: ${widget.pet.adoptionFee}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pet Types List
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
    // Pet Sizes List
    List<Map<String, String>> petSizes = [
      {'size': 'Small', 'weight': '0-25 lbs'},
      {'size': 'Medium', 'weight': '26-60 lbs'},
      {'size': 'Large', 'weight': '61-100 lbs'},
      {'size': 'X-Large', 'weight': '>101 lbs'},
    ];
    // Pet Colors List
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
    // Pet Genders List
    List<String> petGenders = [
      "",
      "Male",
      "Female",
      "Other",
      "None"
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
                        horizontal: 6.0),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    // PET IMAGE, FIRST NAME, LAST NAME
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
                        onChanged:
                            (String newType) {
                          setState(() {
                            petType = newType;
                          });
                        },
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
                        onChanged:
                            (String newSize) {
                          setState(() {
                            petSize = newSize;
                          });
                        },
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
                            onChanged: (String?
                                newColor) {
                              setState(() {
                                petColor =
                                    newColor ??
                                        '';
                              });
                            },
                            selected: petColor,
                            items: petColors,
                          ),
                        ],
                      ),
                    ),
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
                                        "Gender"),
                              ),
                            ],
                          ),
                          CustomDropdown(
                            onChanged:
                                (String? gender) {
                              setState(() {
                                petGender =
                                    gender ?? '';
                              });
                            },
                            selected: petGender,
                            items: petGenders,
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
                      setState(() {
                        _updatePetData();
                      });
                      debugPrintPetData(context);
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
                    actionText:
                        'Save Info'.toUpperCase(),
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
