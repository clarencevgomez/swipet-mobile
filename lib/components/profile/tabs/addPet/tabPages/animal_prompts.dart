import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swipet_mobile/components/profile/profile_button.dart';
import 'package:swipet_mobile/components/profile/tabs/addPet/tabPages/animalFields/animal_bio.dart';
import 'package:swipet_mobile/dbHelper/api_service.dart';
import 'package:swipet_mobile/objects/newPetModel.dart';

class AnimalPrompts extends StatefulWidget {
  final NewPet pet;
  const AnimalPrompts({
    super.key,
    required this.pet,
  });

  @override
  State<AnimalPrompts> createState() =>
      _AnimalPromptsState();
}

class _AnimalPromptsState
    extends State<AnimalPrompts> {
  // Name
  final prompt1Controller =
      TextEditingController();
  final prompt2Controller =
      TextEditingController();

  final ApiService apiService = ApiService();
  void _showDialog(String result, String info) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              result,
              style: const TextStyle(
                  fontFamily: 'Dm Sans',
                  fontSize: 18),
            ),
          ),
          content: Text(info,
              style: const TextStyle(
                  fontFamily: 'Dm Sans',
                  fontSize: 16)),
          actions: [
            CupertinoButton(
                child: const Icon(
                  Icons.check_circle,
                  color: Color.fromRGBO(
                      255, 106, 146, 1),
                  size: 32,
                ),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }

  // WITH API SERVICE
  Future<void> _addPet(NewPet pet) async {
    try {
      final result = await apiService.addPet(
          pet.userLogin,
          pet.petName,
          pet.type,
          pet.petAge,
          pet.petGender,
          pet.colors,
          pet.breed,
          pet.petSize,
          pet.bio,
          pet.prompt1,
          pet.prompt2,
          pet.contactEmail,
          pet.location,
          pet.images,
          pet.adoptionFee);

      String msg = result['message'];
      if (msg.isNotEmpty) {
        if (msg.contains('exists')) {
          _showDialog(msg,
              'Please use a different username');
        } else {
          _showDialog(msg, '');
        }
      }
    } catch (e) {
      print(e.toString());
    }
    _clearAll();
  }

  void _clearAll() {
    prompt1Controller.clear();
    prompt2Controller.clear();
  }

  void _updatePetData() {
    setState(() {
      widget.pet.prompt1 = prompt1Controller.text;
      widget.pet.prompt2 = prompt2Controller.text;
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
                          CrossAxisAlignment
                              .start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        PromptBanner(
                          asset1:
                              'lib/assets/animalProfile/promptSvgs/sparkles.svg',
                          asset2:
                              'lib/assets/animalProfile/promptSvgs/star.svg',
                          title:
                              'Write some prompts for your pet!',
                          description:
                              'Make sure to include prompts for your pet so potential soulmates can get to know them better!',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LargeTextField(
                            placeholder:
                                '<150 words',
                            label:
                                "Why should you adopt me?",
                            controller:
                                prompt1Controller),
                        LargeTextField(
                            placeholder:
                                '<150 words',
                            label:
                                "My favorite thing(s) to do are?",
                            controller:
                                prompt2Controller),
                        const SizedBox(
                          height: 200,
                        )
                      ]))),
          Positioned(
            bottom: -0,
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
                  onPressed: ()  {
                    setState(() {
                      _updatePetData();
                    });
                    debugPrintPetData(context);
                    _addPet(widget.pet);
                  },
                  actionText:
                      'Add Pet'.toUpperCase(),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

// ignore: must_be_immutable
class PromptBanner extends StatelessWidget {
  final String title;
  final String description;
  String? asset1;
  String? asset2;

  PromptBanner({
    super.key,
    required this.title,
    required this.description,
    this.asset1,
    this.asset2,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 16.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(8),
              color: const Color.fromRGBO(
                  242, 196, 179, 1)),
          // color: const Color.fromRGBO(
          //     242, 196, 179, 1),
          height: 125,
          width: 420,
          child: Center(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    // FIRST SVG
                    if (asset1 != null)
                      SvgPicture.asset(
                        asset1!,
                        width: 30,
                        height: 30,
                        colorFilter:
                            const ColorFilter
                                .mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                    // TITLE
                    Padding(
                      padding: const EdgeInsets
                          .symmetric(
                          horizontal: 10.0,
                          vertical: 5.0),
                      child: SizedBox(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 20,
                            letterSpacing: -0.2,
                            fontWeight:
                                FontWeight.bold,
                          ),
                          textAlign:
                              TextAlign.center,
                        ),
                      ),
                    ),
                    // END TITLE SVG
                    if (asset2 != null)
                      SvgPicture.asset(
                        asset2!,
                        width: 25,
                        height: 25,
                        colorFilter:
                            const ColorFilter
                                .mode(
                          Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                  ],
                ),
                // DESCRIPTION
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 400,
                      child: Text(
                        description,
                        textAlign:
                            TextAlign.center,
                        style: const TextStyle(
                          letterSpacing: -0.3,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
