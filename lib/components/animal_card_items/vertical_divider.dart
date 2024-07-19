import 'package:flutter/material.dart';

class InfoDivider extends StatelessWidget {
  const InfoDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: 20,
        width: 20,
        child: VerticalDivider(
          thickness: 1,
          color: Colors.grey,
        ));
  }
}

class InfoHDivider extends StatelessWidget {
  const InfoHDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
      child: Divider(
        indent: 3,
        endIndent: 3,
        thickness: 1,
        color: Colors.grey,
      ),
    );
  }
}

class ProfileInfoHDivider
    extends StatelessWidget {
  const ProfileInfoHDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 30,
      child: Divider(
        thickness: 1,
        color: Colors.grey,
      ),
    );
  }
}
