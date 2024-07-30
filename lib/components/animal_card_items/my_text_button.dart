import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final String text;
  final VoidCallback function;

  MyTextButton({
    super.key,
    required this.text,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
            fontFamily: 'Recoleta',
            color: Colors.black,
            fontWeight: FontWeight.bold),
      ), // Use the text parameter for the button label
      onPressed: () {
        function(); // Call the function
        Navigator.of(context).pop();
      },
    );
  }
}
