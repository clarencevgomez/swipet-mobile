import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swipet_mobile/components/animalBioItems/animal_text_field.dart';

class PetType extends StatefulWidget {
  final List<Map<String, String>> petTypes;
  final String petType;

  const PetType({
    super.key,
    required this.petTypes,
    required this.petType,
  });

  @override
  _PetTypeState createState() => _PetTypeState();
}

class _PetTypeState extends State<PetType> {
  late String petType;

  @override
  void initState() {
    super.initState();
    petType = widget.petType;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.0),
                child: PetFieldTitle(
                    title: 'Pet Type*'),
              ),
            ],
          ),
          // PET CHIP TYPES
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: widget.petTypes.map((e) {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 20),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      petType = e['type']!;
                      print(
                          'Selected pet type: $petType');
                    });
                  },
                  child: Chip(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                              8.0),
                      side: BorderSide(
                        color:
                            petType == e['type']!
                                ? Colors.pink
                                : Colors.grey,
                        width: 1,
                      ),
                    ),
                    backgroundColor:
                        petType == e['type']!
                            ? Colors.pink
                                .withOpacity(0.1)
                            : Colors.white,
                    label: SizedBox(
                      width: 105,
                      height: 70,
                      child: Row(
                        mainAxisSize:
                            MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .end,
                            children: [
                              // Chip Text
                              Text(e['type']!),
                            ],
                          ),
                          const Spacer(),
                          // SVG Asset
                          Column(
                            children: [
                              SvgPicture.asset(
                                e['asset']!,
                                height: 45,
                                width: 45,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class PetSize extends StatefulWidget {
  final List<Map<String, String>> petSizes;
  final String petSize;

  const PetSize({
    super.key,
    required this.petSizes,
    required this.petSize,
  });

  @override
  _PetSizeState createState() => _PetSizeState();
}

class _PetSizeState extends State<PetSize> {
  late String petSize;

  @override
  void initState() {
    super.initState();
    petSize = widget.petSize;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.0),
                child:
                    PetFieldTitle(title: 'Size*'),
              ),
            ],
          ),
          // PET SIZE CHIPS
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: widget.petSizes.map((e) {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 20),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      petSize = e['size']!;
                      print(
                          'Selected pet size: $petSize');
                    });
                  },
                  child: Chip(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                              8.0),
                      side: BorderSide(
                        color:
                            petSize == e['size']!
                                ? Colors.pink
                                : Colors.grey,
                        width: 1,
                      ),
                    ),
                    backgroundColor:
                        petSize == e['size']!
                            ? Colors.pink
                                .withOpacity(0.1)
                            : Colors.white,
                    label: SizedBox(
                      width: 70,
                      height: 60,
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min,
                        children: [
                          // Weight Text
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .end,
                            children: [
                              Text(
                                e['weight']!,
                                style:
                                    const TextStyle(
                                  color:
                                      Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          // Size Text
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .start,
                            children: [
                              Text(e['size']!),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
