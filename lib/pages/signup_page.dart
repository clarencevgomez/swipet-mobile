import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipet_mobile/components/action_footer.dart';
import 'package:swipet_mobile/components/action_header.dart';
import 'package:swipet_mobile/components/forgot_tile.dart';
import 'package:swipet_mobile/components/name_text_field.dart';
import 'package:swipet_mobile/components/text_field.dart';
import 'package:swipet_mobile/components/my_button.dart'; // Import the new component
import 'package:swipet_mobile/dbHelper/api_service.dart';
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
  final firstNameController =
      TextEditingController();
  final lastNameController =
      TextEditingController();

  final ApiService apiService = ApiService();

// WITH API SERVICE
  Future<void> _register(
    String firstName,
    String lastName,
    String username,
    String email,
    String address,
    String password,
    String phoneNumber,
  ) async {
    try {
      final result = await apiService.register(
          firstName,
          lastName,
          email,
          phoneNumber,
          address,
          username,
          password);
      String msg = result['message'];
      if (msg.isNotEmpty) {
        if (msg.contains('exists')) {
          _showDialog(msg,
              'Please use a different username');
        } else {
          _showDialog(msg, '');
        }
      }
    } catch (e) {
      print(e.toString());
    }
    // ignore: use_build_context_synchronously

    _clearAll();
  }

  // NEW USER FUNCTION

  void _clearAll() {
    firstNameController.clear();
    lastNameController.clear();
    signUpUsernameController.clear();
    signUpEmailController.clear();
    signUpLocationController.clear();
    signUpPasswordController.clear();
    signUpConfirmPasswordController.clear();
  }

  void _showDialog(String result, String info) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              result,
              style: const TextStyle(
                  fontFamily: 'Dm Sans',
                  fontSize: 18),
            ),
          ),
          content: Text(info,
              style: const TextStyle(
                  fontFamily: 'Dm Sans',
                  fontSize: 16)),
          actions: [
            CupertinoButton(
                child: const Icon(
                  Icons.check_circle,
                  color: Color.fromRGBO(
                      255, 106, 146, 1),
                  size: 32,
                ),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
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
                const ActionHeader(
                  imagePath:
                      'lib/images/sign-upp-cat.png',
                  actionText: "Sign Up",
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30),
                  child: Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding:
                              const EdgeInsets
                                  .only(
                                  left: 50,
                                  right: 5),
                          child: NameTextField(
                            next: Icons
                                .camera_front_rounded,
                            placeholder:
                                "First Name*",
                            controller:
                                firstNameController,
                            obscureText: false,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding:
                              const EdgeInsets
                                  .only(
                                  right: 50),
                          child: NameTextField(
                            next: Icons
                                .video_camera_front_outlined,
                            placeholder:
                                "Last Name*",
                            controller:
                                lastNameController,
                            obscureText: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                MyTextField(
                  next: Icons.person_outline,
                  placeholder: 'Username*',
                  controller:
                      signUpUsernameController,
                  obscureText: false,
                ),
                // First Name Input Controller

                MyTextField(
                  next:
                      Icons.alternate_email_sharp,
                  placeholder: 'Email Address*',
                  controller:
                      signUpEmailController,
                  obscureText: false,
                ),
                MyTextField(
                  next:
                      Icons.location_on_outlined,
                  placeholder: 'Location*',
                  controller:
                      signUpLocationController,
                  obscureText: false,
                ),
                MyTextField(
                  next: Icons.lock_open_outlined,
                  placeholder: 'Password*',
                  controller:
                      signUpPasswordController,
                  obscureText: true,
                ),
                MyTextField(
                  next: Icons.lock_outline,
                  placeholder:
                      'Confirm Password*',
                  controller:
                      signUpConfirmPasswordController,
                  obscureText: true,
                ),
                MyButton(
                  onPressed: () {
                    _register(
                      firstNameController.text,
                      lastNameController.text,
                      signUpUsernameController
                          .text,
                      signUpEmailController.text,
                      signUpLocationController
                          .text,
                      signUpConfirmPasswordController
                          .text,
                      "000 000 0000",
                    );
                  },
                  actionText: 'Sign Up',
                ),
                ActionFooter(
                  page: '/login',
                  description:
                      "Have an Account?\t",
                  actionText: "Login",
                  animation: NavigatorTweens
                      .topToBottom(),
                ),
                const ResetPassword(),
                OutlinedButton(
                  onPressed: _fakeData,
                  child: const Text(
                    "Generate Data",
                    style: TextStyle(
                        color: Colors.black),
                  ),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _fakeData() {
    var faker = Faker();
    firstNameController.text =
        faker.person.firstName();
    lastNameController.text =
        faker.person.lastName();
    signUpUsernameController.text =
        faker.internet.userName();
    signUpEmailController.text =
        faker.internet.email();
    signUpLocationController.text =
        '${faker.address.streetName()}, ${faker.address.streetAddress()}';
    signUpPasswordController.text =
        faker.internet.password();
    signUpConfirmPasswordController.text =
        signUpPasswordController.text;
  }
}
