import 'package:flutter/material.dart';
import 'package:swipet_mobile/components/animalBioItems/animal_text_field.dart';

// ignore: must_be_immutable
class PetAgeField extends StatelessWidget {
  final TextEditingController ageYearController;
  final TextEditingController ageMonthController;

  const PetAgeField({
    super.key,
    required this.ageYearController,
    required this.ageMonthController,
  });

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
                    title: 'Pet Age*'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: [
              MyAnimalTextField(
                placeholder: '0',
                controller: ageYearController,
                obscureText: false,
                width: 180,
                height: 50,
                horizontal: 0,
              ),
              const PetFieldTitle(title: 'Years'),
              MyAnimalTextField(
                placeholder: '0',
                controller: ageMonthController,
                obscureText: false,
                width: 140,
                height: 50,
                horizontal: 0,
              ),
              const PetFieldTitle(
                  title: 'Months'),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class PetLocationField extends StatelessWidget {
  final TextEditingController cityLocController;
  final TextEditingController stateLocController;
  final TextEditingController zipLocController;

  const PetLocationField({
    super.key,
    required this.cityLocController,
    required this.stateLocController,
    required this.zipLocController,
  });

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
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: [
              MyAnimalTextField(
                placeholder: 'City',
                controller: cityLocController,
                obscureText: false,
                width: 170,
                height: 50,
                horizontal: 0,
              ),
              MyAnimalTextField(
                placeholder: 'State',
                controller: stateLocController,
                obscureText: false,
                width: 130,
                height: 50,
                horizontal: 0,
              ),
              MyAnimalTextField(
                placeholder: 'Zip Code',
                controller: zipLocController,
                obscureText: false,
                width: 120,
                height: 50,
                horizontal: 0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PetBreedField extends StatelessWidget {
  final TextEditingController breedController;

  const PetBreedField({
    super.key,
    required this.breedController,
  });

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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
