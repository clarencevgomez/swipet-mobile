import 'package:flutter/material.dart';
import 'package:swipet_mobile/components/animalBioItems/animal_text_field.dart';

class LargeTextField extends StatelessWidget {
  final String placeholder;
  final String label;
  final TextEditingController controller;

  const LargeTextField({
    super.key,
    required this.placeholder,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(
                        horizontal: 0.0),
                child:
                    PetFieldTitle(title: label),
              ),
            ],
          ),
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
            children: [
              MyAnimalTextFormField(
                placeholder: placeholder,
                controller: controller,
                obscureText: false,
                height: 150,
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
