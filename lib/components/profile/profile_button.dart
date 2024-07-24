import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String actionText;
  final String? svgAsset;
  final Color backgroundColor;

  const ProfileButton({
    super.key,
    required this.onPressed,
    required this.actionText,
    this.svgAsset,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:
          MediaQuery.of(context).size.width * 0.8,
      height: 45,
      child: FloatingActionButton(
        backgroundColor: backgroundColor,
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          crossAxisAlignment:
              CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(svgAsset!),
            const SizedBox(width: 10),
            Text(
              actionText,
              style: const TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 20,
                  letterSpacing: -0.80,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
