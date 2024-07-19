import 'package:swipet_mobile/components/action_footer.dart';
import 'package:swipet_mobile/components/action_header.dart';
import 'package:swipet_mobile/components/forgot_tile.dart';
import 'package:swipet_mobile/components/my_button.dart';
import 'package:swipet_mobile/components/router.dart';
import 'package:swipet_mobile/components/text_field.dart';
import 'package:swipet_mobile/dbHelper/mongodb.dart';
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
  String currentUser = "";

  Future<void> userLogin(
      String username, String password) async {
    String loginResult =
        await MongoDatabase.loginUser(
            username, password);

    if (loginResult == "User Found") {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Successful Login!")),
      );
      currentUser = username;
      // if successful navigate to swipe screen
      // ignore: use_build_context_synchronously
      ScreenNavigator(cx: context).navigate(
          '/swipepage',
          NavigatorTweens.rightToLeft());
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loginResult)),
      );
    }
    _clearAll();
  }

  void _clearAll() {
    usernameController.clear();
    passwordController.clear();
  }

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
              MyButton(
                onPressed: () {
                  userLogin(
                      usernameController.text,
                      passwordController.text);
                },
                actionText: 'Login',
              ),

              // --- BELOW ACTION BUTTON
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [
                  ActionFooter(
                      page: '/signup',
                      description:
                          "Need an Account?\t",
                      actionText: "Sign Up",
                      animation: NavigatorTweens
                          .bottomToTop())
                ],
              ),
              // Forgot Password Page
              const ResetPassword(),
              // Debug Output
            ],
          ),
        ),
      ),
    );
  }
}
