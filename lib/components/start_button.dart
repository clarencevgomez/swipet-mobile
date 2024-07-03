import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
  final IconData next;
  final String actionText;
  final Function()? onTap;

  const StartButton(
      {super.key,
      required this.next,
      required this.actionText,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 45, vertical: 15),
        child: FilledButton(
            style: ButtonStyle(
              backgroundColor:
                  WidgetStateProperty.all<Color>(
                      Colors.black),
            ),
            onPressed: () {},
            child: Center(
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets
                        .symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Text(
                          actionText,
                          style: const TextStyle(
                              fontSize: 22),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets
                                  .only(left: 10),
                          child: Icon(next),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
