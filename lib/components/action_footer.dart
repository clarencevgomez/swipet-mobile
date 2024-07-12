import 'package:flutter/material.dart';
import 'package:swipet_mobile/components/router.dart';

class ActionFooter extends StatelessWidget {
  final String page;
  final String description;
  final String actionText;
  final Tween<Offset> animation;

  const ActionFooter({
    super.key,
    required this.page,
    required this.description,
    required this.actionText,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          description,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'DM Sans',
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pop(); // Close the current screen/dialog
            ScreenNavigator(cx: context).navigate(
              page,
              animation,
            );
          },
          child: Text(
            actionText.toUpperCase(),
            style: const TextStyle(
              decoration:
                  TextDecoration.underline,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
