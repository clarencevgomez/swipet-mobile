import 'package:swipet_mobile/components/action_footer.dart';
import 'package:swipet_mobile/components/action_header.dart';
import 'package:swipet_mobile/components/forgot_tile.dart';
import 'package:swipet_mobile/components/router.dart';
import 'package:swipet_mobile/components/start_button.dart';
import 'package:swipet_mobile/components/text_field.dart';
import 'package:swipet_mobile/pages/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controller
  final usernameController =
      TextEditingController();
  final passwordController =
      TextEditingController();

  void userLogin() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        // <--------- Back Button
        leading: Padding(
          padding:
              const EdgeInsets.only(left: 10.0),
          child: IconButton(
            iconSize: 60,
            onPressed: () =>
                Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back,
            ),
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
              Color.fromRGBO(242, 196, 179, 1),
              Color.fromRGBO(242, 196, 179, 1),
              Colors.white
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              // --- Login Page Icon / Description
              const ActionHeader(
                  imagePath:
                      'lib/images/login-page-icon.png',
                  actionText: "Log In"),
              // --- INPUT AREA ACTION BUTTON
              // --> username textfield
              Padding(
                padding: const EdgeInsets.only(
                    top: 30),
                child: MyTextField(
                  next: Icons.person_outline,
                  placeholder: 'Username*',
                  controller: usernameController,
                  obscureText: false,
                ),
              ),
              // --> password textfield
              MyTextField(
                next: Icons.lock_outline,
                placeholder: 'Password*',
                controller: passwordController,
                obscureText: true,
              ),
              // --> login button
              StartButton(
                onTap: userLogin,
                next: Icons.app_shortcut,
                actionText: 'Log In',
              ),
              // --- BELOW ACTION BUTTON
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  ActionFooter(
                      page: const SignupPage(),
                      description:
                          "Need an Account?\t",
                      actionText: "Sign Up",
                      animation: NavigatorTweens
                          .bottomToTop())
                ],
              ),
              // Forgot Password Page
              const ResetPassword()
            ],
          ),
        ),
      ),
    );
  }
}
