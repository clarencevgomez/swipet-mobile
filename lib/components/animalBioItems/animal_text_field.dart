import 'package:flutter/material.dart';

class MyAnimalTextField extends StatelessWidget {
  final String placeholder;
  final TextEditingController controller;
  final bool obscureText;
  final double width; // Add a width parameter
  final double height;
  final double
      horizontal; // Add a height parameter

  const MyAnimalTextField({
    super.key,
    required this.placeholder,
    required this.controller,
    required this.obscureText,
    this.width = double
        .infinity, // Set default width to infinity
    this.height = 60.0,
    this.horizontal = 50, // Set default height
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontal, vertical: 3),
      child: SizedBox(
        width:
            width, // Set the width of the container
        height:
            height, // Set the height of the container
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: placeholder,
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                  color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(15.0),
              borderSide: BorderSide(
                  color: Colors.grey.shade300),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ),
    );
  }
}

class MyAnimalTextFormField
    extends StatelessWidget {
  final String placeholder;
  final TextEditingController controller;
  final bool obscureText;
  final double width; // Add a width parameter
  final double height;
  final double
      horizontal; // Add a height parameter

  const MyAnimalTextFormField({
    super.key,
    required this.placeholder,
    required this.controller,
    required this.obscureText,
    this.width = double
        .infinity, // Set default width to infinity
    this.height = 60.0,
    this.horizontal = 50, // Set default height
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontal, vertical: 3),
      child: SizedBox(
        width:
            width, // Set the width of the container
        height:
            height, // Set the height of the container
        child: TextFormField(
          maxLength: 150,
          maxLines: 5,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: placeholder,
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                  color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(15.0),
              borderSide: BorderSide(
                  color: Colors.grey.shade300),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
        ),
      ),
    );
  }
}

class PetFieldTitle extends StatelessWidget {
  final String title;
  const PetFieldTitle(
      {super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.black,
          fontFamily: 'Recoleta',
          fontSize: 16),
    );
  }
}
