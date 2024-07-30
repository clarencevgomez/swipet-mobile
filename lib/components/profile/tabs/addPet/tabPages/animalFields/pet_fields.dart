import 'package:flutter/material.dart';
import 'package:swipet_mobile/components/animalBioItems/animal_text_field.dart';

// ignore: must_be_immutable
class PetAgeField extends StatelessWidget {
  Map<String, dynamic> oldPet;
  final TextEditingController ageYearController;
  final TextEditingController ageMonthController;

  PetAgeField({
    super.key,
    required this.ageYearController,
    required this.ageMonthController,
    required this.oldPet,
  }) {
    if (oldPet['Age'] != null &&
        oldPet['Age'].isNotEmpty) {
      ageYearController.text = oldPet['Age'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 0.0),
            child:
                PetFieldTitle(title: 'Pet Age*'),
          ),
          const Spacer(),
          MyAnimalTextField(
            placeholder: '0',
            controller: ageYearController,
            obscureText: false,
            width: MediaQuery.of(context)
                    .size
                    .width /
                2,
            height: 50,
            horizontal: 0,
            onChanged: (value) {},
          ),
          SizedBox(
            width: 10,
          ),
          const PetFieldTitle(title: 'Years'),
        ],
      ),
    );
  }
}

class PetLocationField extends StatelessWidget {
  final Map<String, dynamic> oldPet;
  final TextEditingController cityLocController;
  final TextEditingController stateLocController;
  final TextEditingController zipLocController;

  PetLocationField({
    super.key,
    required this.cityLocController,
    required this.stateLocController,
    required this.zipLocController,
    required this.oldPet,
  }) {
    if (oldPet['Location'] != null &&
        oldPet['Location'].isNotEmpty) {
      var locationParts =
          oldPet['Location'].split(", ");
      if (locationParts.length == 2) {
        cityLocController.text = locationParts[0];
        var stateZip =
            locationParts[1].split(" ");
        if (stateZip.length == 2) {
          stateLocController.text = stateZip[0];
          zipLocController.text = stateZip[1];
        }
      }
    }
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
                    title: 'Location*'),
              ),
            ],
          ),
          // INPUT FIELDS
          Row(
            children: [
              Expanded(
                flex: 4,
                child: MyAnimalTextField(
                  placeholder: 'City',
                  controller: cityLocController,
                  obscureText: false,
                  height: 50,
                  horizontal: 0,
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                  width:
                      8), // Spacing between fields
              Expanded(
                flex: 3,
                child: MyAnimalTextField(
                  placeholder: 'State',
                  controller: stateLocController,
                  obscureText: false,
                  height: 50,
                  horizontal: 0,
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                  width:
                      8), // Spacing between fields
              Expanded(
                flex: 3,
                child: MyAnimalTextField(
                  placeholder: 'Zip Code',
                  controller: zipLocController,
                  obscureText: false,
                  height: 50,
                  horizontal: 0,
                  onChanged: (value) {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PetBreedField extends StatelessWidget {
  final Map<String, dynamic> oldPet;
  final TextEditingController breedController;

  PetBreedField({
    super.key,
    required this.breedController,
    required this.oldPet,
  }) {
    if (oldPet['Breed'] != null &&
        oldPet['Breed'].isNotEmpty) {
      breedController.text = oldPet['Breed'];
    }
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
                    title: 'Animal Breed'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: [
              MyAnimalTextField(
                placeholder: 'Breed',
                controller: breedController,
                obscureText: false,
                height: 50,
                width: MediaQuery.of(context)
                        .size
                        .width -
                    35,
                horizontal: 0,
                onChanged: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
