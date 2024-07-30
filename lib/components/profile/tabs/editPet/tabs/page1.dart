import 'package:flutter/cupertino.dart';
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

class EditAnimalInfo extends StatefulWidget {
  final NewPet pet;
  final Map<String, dynamic> oldPet;
  final TabController tabController;

  const EditAnimalInfo({
    Key? key,
    required this.pet,
    required this.oldPet,
    required this.tabController,
  }) : super(key: key);

  @override
  State<EditAnimalInfo> createState() =>
      _EditAnimalInfoState();
}

class _EditAnimalInfoState
    extends State<EditAnimalInfo> {
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
    _initializeControllers();
  }

  void _initializeControllers() {
    List<String> name =
        widget.oldPet['Pet_Name'].split(" ");
    firstNameController.text =
        name.isNotEmpty ? name[0] : '';
    lastNameController.text = name.length > 1
        ? name.sublist(1).join(" ")
        : '';
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
        widget.pet.userLogin =
            decodedToken['username'];
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
          "${ageYearController.text}";
      widget.pet.petGender = petGender;
      widget.pet.breed = breedController.text;
      widget.pet.petSize = petSize;
      widget.pet.bio = petStoryController.text;
      widget.pet.location =
          "${cityLocController.text}, ${stateLocController.text} ${zipLocController.text}";
      widget.pet.adoptionFee = feeController.text;
      widget.pet.prompt1 =
          widget.oldPet['Prompt1'].toString();
      widget.pet.prompt2 =
          widget.oldPet['Prompt2'].toString();
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

  // void _showDialog(String result, String info) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return CupertinoAlertDialog(
  //         title: Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Text(
  //             result,
  //             style: const TextStyle(
  //                 fontFamily: 'Dm Sans',
  //                 fontSize: 18),
  //           ),
  //         ),
  //         content: Text(info,
  //             style: const TextStyle(
  //                 fontFamily: 'Dm Sans',
  //                 fontSize: 16)),
  //         actions: [
  //           CupertinoButton(
  //               child: const Icon(
  //                 Icons.check_circle,
  //                 color: Color.fromRGBO(
  //                     255, 106, 146, 1),
  //                 size: 32,
  //               ),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               })
  //         ],
  //       );
  //     },
  //   );
  // }

  // WITH API SERVICE
  Future<void> _editpet(NewPet pet,
      final Map<String, dynamic> oldPet) async {
    try {
      final editResult =
          await apiService.updatePet(
              userLogin,
              oldPet['_id'].toString(),
              pet.petName,
              pet.type,
              pet.type,
              pet.petGender,
              pet.colors,
              pet.breed,
              petSize,
              pet.bio,
              oldPet['Prompt1'].toString(),
              oldPet['Prompt2'].toString(),
              pet.contactEmail,
              pet.location,
              [],
              pet.adoptionFee);

      String msg = editResult['message'];
      if (msg ==
          'Pet information updated successfully') {
        // _showDialog(msg, '');
      }
      if (msg.isNotEmpty) {
        if (msg.contains('exists')) {
          // _showDialog(msg,
          //     'Please check all the fields needed');
        }
      }
    } catch (e) {
      print(e.toString());
    }
    _clearAll();
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
                      oldPet: widget.oldPet,
                      petImage: widget.oldPet[
                                  'Images'][0] ==
                              ''
                          ? 'lib/images/defaultLogo-pic.jpg'
                          : widget.oldPet[
                              'Images'][0],
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
                        feeController:
                            feeController,
                        feeAmnt: widget.oldPet[
                                    'AdoptionFee']
                                ?.toString() ??
                            '',
                      ),
                    ),

                    // AGE CONTROLLER
                    Padding(
                      padding:
                          EdgeInsets.symmetric(
                              vertical: space),
                      child: PetAgeField(
                        oldPet: widget.oldPet,
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
                        oldPet: widget.oldPet,
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
                        oldPet: widget.oldPet,
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
                        oldPet: widget.oldPet,
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
                        oldPet: widget.oldPet,
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
                        pet: widget.oldPet,
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
                      _editpet(widget.pet,
                          widget.oldPet);
                      debugPrintPetData(context);

                      // _editpet(widget.pet,
                      //     widget.oldPet);

                      // Navigate to the next tab
                      // if (widget.tabController
                      //         .index <
                      //     widget.tabController
                      //             .length -
                      //         1) {
                      //   widget.tabController
                      //       .animateTo(widget
                      //               .tabController
                      //               .index +
                      //           1);
                      // }
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
