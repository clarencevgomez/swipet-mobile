import 'package:flutter/material.dart';

class ActionHeader extends StatelessWidget {
  final String imagePath;
  final String actionText;

  const ActionHeader(
      {super.key,
      required this.imagePath,
      required this.actionText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(imagePath),
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 10),
          child: Text(
            actionText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              height: 1.1,
              fontSize: 40,
              fontFamily: 'Recoleta',
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
