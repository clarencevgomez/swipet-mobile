import 'package:swipet_mobile/components/action_footer.dart';
import 'package:swipet_mobile/components/action_header.dart';
import 'package:swipet_mobile/components/forgot_tile.dart';
import 'package:flutter/material.dart';
import 'package:swipet_mobile/components/start_button.dart';
import 'package:swipet_mobile/components/text_field.dart';
import 'package:swipet_mobile/pages/login_page.dart';
import 'package:swipet_mobile/components/router.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() =>
      _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final signUpUsernameController =
      TextEditingController();

  final signUpEmailController =
      TextEditingController();

  final signUpLocationController =
      TextEditingController();

  final signUpPasswordController =
      TextEditingController();

  final signUpConfirmPasswordController =
      TextEditingController();

  void signUpUser() {
    print(
        "User: ${signUpUsernameController.text}");
    print("Email: ${signUpEmailController.text}");
    print(
        "Location: ${signUpLocationController.text}");
    print(
        "Pass1: ${signUpPasswordController.text}");
    print(
        "Pass2: ${signUpConfirmPasswordController.text}");
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
            onPressed: () =>
                Navigator.of(context).pop(),
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
              Color.fromRGBO(242, 145, 163, 1),
              Color.fromRGBO(242, 145, 163, 1),
              Colors.white
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 175),
                // Sign Up Header
                const ActionHeader(
                    imagePath:
                        'lib/images/sign-upp-cat.png',
                    actionText: "Sign Up"),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30),

                  // Username Input Field
                  child: MyTextField(
                    next: Icons.person_outline,
                    placeholder: 'Username*',
                    controller:
                        signUpUsernameController,
                    obscureText: false,
                  ),
                ),
                // Username Email Field
                MyTextField(
                  next:
                      Icons.alternate_email_sharp,
                  placeholder: 'Email Address*',
                  controller:
                      signUpEmailController,
                  obscureText: false,
                ),
                // Location Input Field
                MyTextField(
                  next:
                      Icons.location_on_outlined,
                  placeholder: 'Location*',
                  controller:
                      signUpLocationController,
                  obscureText: false,
                ),
                // Password Input Field
                MyTextField(
                  next: Icons.lock_open_outlined,
                  placeholder: 'Password*',
                  controller:
                      signUpPasswordController,
                  obscureText: true,
                ),
                // Confirm Password Input Field
                MyTextField(
                  next: Icons.lock_outline,
                  placeholder:
                      'Confirm Password*',
                  controller:
                      signUpConfirmPasswordController,
                  obscureText: true,
                ),
                StartButton(
                  next: Icons.app_shortcut,
                  actionText: 'Sign Up',
                  onTap: signUpUser,
                ),

                // Log In Redirection
                ActionFooter(
                    page: const LoginPage(),
                    description:
                        "Have an Account?\t",
                    actionText: "Login",
                    animation: NavigatorTweens
                        .topToBottom()),
                // RESET PASSWORD PAGE REDIRECTION
                const ResetPassword(),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
