import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final String asset;

  const MyAppBar(
      {super.key,
      required this.title,
      required this.asset});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      leading: Padding(
        padding:
            const EdgeInsets.only(left: 25.0),
        child: SvgPicture.asset(
          asset,
          colorFilter: const ColorFilter.mode(
            Colors.black,
            BlendMode.srcIn,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontFamily: 'Recoleta',
        ),
      ),
      automaticallyImplyLeading: false,
      titleSpacing: 10,
    );
  }
}
