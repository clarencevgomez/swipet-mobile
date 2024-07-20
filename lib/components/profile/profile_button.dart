// sign_up_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String actionText;
  // ignore: non_constant_identifier_names
  final String SvgAsset;
  const ProfileButton(
      {super.key,
      required this.onPressed,
      required this.actionText,
      // ignore: non_constant_identifier_names
      required this.SvgAsset});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width *
          (8 / 10),
      height: 45,
      child: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(
            242, 216, 238, 1),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          crossAxisAlignment:
              CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(SvgAsset),
            const SizedBox(
              width: 10,
            ),
            Text(
              actionText,
              style: const TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 20,
                  letterSpacing: -0.80),
            )
          ],
        ),
      ),
    );
  }
}
