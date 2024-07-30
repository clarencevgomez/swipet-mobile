import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:swipet_mobile/components/action_footer.dart';
import 'package:swipet_mobile/components/action_header.dart';
import 'package:swipet_mobile/components/forgot_tile.dart';
import 'package:swipet_mobile/components/my_button.dart';
import 'package:swipet_mobile/components/router.dart';
import 'package:swipet_mobile/components/text_field.dart';
import 'package:swipet_mobile/dbHelper/api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final usernameController =
      TextEditingController();
  final passwordController =
      TextEditingController();
  final ApiService apiService = ApiService();

  bool isLoading = false;
  String result = '';

  void _clearAll() {
    usernameController.clear();
    passwordController.clear();
  }

  Future<void> loginUser(
      String username, String password) async {
    setState(() {
      isLoading = true;
    });

    try {
      final loginResult = await apiService.login(
          username, password);
      final token = await apiService.getToken();

      if (token != null) {
        Map<String, dynamic> decoded =
            JwtDecoder.decode(token);
        String? user = decoded['username'];
        if (!mounted) return;

        // ScaffoldMessenger.of(context)
        //     .showSnackBar(
        //   SnackBar(
        //       content: Text(
        //           "Successful Login! $user")),
        // );

        ScreenNavigator(cx: context).navigate(
          '/swipepage',
          NavigatorTweens.topToBottom(),
        );
      } else {
        if (!mounted) return;
        String message = loginResult['message'] ??
            'Failed to retrieve token';

        result = message;
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
      _clearAll();
    }
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
              Color.fromRGBO(242, 196, 179, 1),
              Color.fromRGBO(242, 196, 179, 1),
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 40.0),
          child: Center(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                ),
                const ActionHeader(
                  imagePath:
                      'lib/images/login-page-icon.png',
                  actionText: "Log In",
                ),
                if (isLoading)
                  const CircularProgressIndicator
                      .adaptive()
                else ...[
                  Text(
                    result,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 22,
                      letterSpacing: -0.4,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(
                            top: 10),
                    child: MyTextField(
                      next: Icons.person_outline,
                      placeholder: 'Username*',
                      controller:
                          usernameController,
                      obscureText: false,
                      validator: (value) {},
                    ),
                  ),
                  MyTextField(
                    next: Icons.lock_outline,
                    placeholder: 'Password*',
                    controller:
                        passwordController,
                    obscureText: true,
                    validator: (value) {},
                  ),
                  MyButton(
                    onPressed: () {
                      loginUser(
                          usernameController.text,
                          passwordController
                              .text);
                    },
                    actionText: 'Login',
                    loading: isLoading,
                  ),
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
                            .bottomToTop(),
                      ),
                    ],
                  ),
                  const ResetPassword(),
                  SizedBox(
                    height: 250,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
