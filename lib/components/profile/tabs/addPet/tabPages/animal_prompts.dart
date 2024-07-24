import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swipet_mobile/components/profile/profile_button.dart';
import 'package:swipet_mobile/components/profile/tabs/addPet/tabPages/animalFields/animal_bio.dart';
import 'package:swipet_mobile/dbHelper/api_service.dart';

class AnimalPrompts extends StatefulWidget {
  const AnimalPrompts({super.key});

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

  // WITH API SERVICE
  Future<void> _addPet() async {
    // Here you should add the logic to send data to your API service
    // For example:
    // await apiService.addPet(...);
    _clearAll();
  }

  void _clearAll() {
    prompt1Controller.clear();
    prompt2Controller.clear();
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
                  onPressed: () {
                    // Navigate to the next tab
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
