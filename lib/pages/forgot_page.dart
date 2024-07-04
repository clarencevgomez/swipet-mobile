import 'package:swipet_mobile/components/action_header.dart';
import 'package:swipet_mobile/components/router.dart';
import 'package:swipet_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:swipet_mobile/components/start_button.dart';
import 'package:swipet_mobile/components/text_field.dart';

class ForgotKeyPage extends StatefulWidget {
  const ForgotKeyPage({super.key});

  @override
  State<ForgotKeyPage> createState() =>
      _ForgotKeyPageState();
}

class _ForgotKeyPageState
    extends State<ForgotKeyPage> {
  final oldPasswordController =
      TextEditingController();

  final newPasswordController =
      TextEditingController();

  final confirmPasswordController =
      TextEditingController();

  Future<void> forgotPassword(String hey) async {
    return;
    // Implement your forgot password logic here
    // You can access the text field values using the controller instances
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding:
              const EdgeInsets.only(left: 10.0),
          child: IconButton(
            iconSize: 60,
            onPressed: () {
              Navigator.of(context).pop();
              ScreenNavigator(cx: context)
                  .navigate(
                const WelcomePage(),
                NavigatorTweens.rightToLeft(),
              );
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(242, 162, 155, 1),
              Color.fromRGBO(242, 162, 155, 1),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              // Action Header
              const ActionHeader(
                  imagePath:
                      'lib/images/Forgot-Password-Cat.png',
                  actionText:
                      "Forgot your Password?\nNo Problem!"),
              // User Inputs
              Padding(
                padding: const EdgeInsets.only(
                    top: 30.0),
                // Old password input field
                child: MyTextField(
                  next: Icons.lock_open_outlined,
                  placeholder: 'Old Password*',
                  controller:
                      oldPasswordController,
                  obscureText: true,
                ),
              ),
              // New password input field
              MyTextField(
                next: Icons.lock_open_outlined,
                placeholder: 'New Password*',
                controller: newPasswordController,
                obscureText: true,
              ),
              // Confirm New Password Field
              MyTextField(
                next: Icons.lock_open_outlined,
                placeholder:
                    'Confirm New Password*',
                controller:
                    confirmPasswordController,
                obscureText: true,
              ),
              // Action Button
              StartButton(
                next: Icons
                    .check_circle_outline_sharp,
                actionText:
                    'Confirm New Password*',
                onTap: forgotPassword('hey'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
