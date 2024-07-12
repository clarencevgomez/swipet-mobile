import 'package:swipet_mobile/components/router.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const Text(
                "Forgot Password?\t",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'DM Sans',
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  ScreenNavigator(cx: context)
                      .navigate(
                    '/forgotpage',
                    NavigatorTweens.bottomToTop(),
                  );
                },
                child: const Text(
                  "reset",
                  style: TextStyle(
                    decoration:
                        TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
