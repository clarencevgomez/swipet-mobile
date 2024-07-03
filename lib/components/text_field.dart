import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  final IconData next;
  final String placeholder;
  // ignore: prefer_typing_uninitialized_variables
  final TextEditingController controller;
  final bool obscureText;

  const MyTextField(
      {super.key,
      required this.next,
      required this.placeholder,
      required this.controller,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 50, vertical: 3),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: placeholder,
          prefixIcon: Icon(next),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(15.0),
            borderSide: const BorderSide(
                color: Colors.white),
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
    );
  }
}
