// sign_up_button.dart

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String actionText;
  const MyButton(
      {super.key,
      required this.onPressed,
      required this.actionText, required bool loading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 15.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width *
            (8 / 10),
        height: 45,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            shadowColor: Colors.transparent,
            backgroundColor: Colors.black,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Text(
                actionText.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.app_shortcut,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
