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
  String SignResult = '';
  String errors = '';
  bool _isLoading = false;

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

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

  Future<void> _register(
    String firstName,
    String lastName,
    String username,
    String email,
    String address,
    String password,
    String phoneNumber,
  ) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

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
          SignResult =
              'Please use a different username';
        } else {
          setState(() {
            SignResult = msg;
          });
        }
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
    _clearAll();
  }

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
              },
            )
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
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  const ActionHeader(
                    imagePath:
                        'lib/images/sign-upp-cat.png',
                    actionText: "Sign Up",
                  ),
                  Text(
                    SignResult,
                    style: const TextStyle(
                      color: Color.fromARGB(
                          255, 255, 255, 255),
                      fontSize: 22,
                      letterSpacing: -0.4,
                    ),
                  ),
                  Text(
                    errors,
                    style: const TextStyle(
                      color: Color.fromARGB(
                          255, 255, 67, 67),
                      fontSize: 22,
                      letterSpacing: -0.4,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(
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
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [
                                NameTextField(
                                  next: Icons
                                      .camera_front_rounded,
                                  placeholder:
                                      "First Name",
                                  controller:
                                      firstNameController,
                                  obscureText:
                                      false,
                                  validator:
                                      (value) {},
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding:
                                const EdgeInsets
                                    .only(
                                    right: 50),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                              children: [
                                NameTextField(
                                  next: Icons
                                      .video_camera_front_outlined,
                                  placeholder:
                                      "Last Name",
                                  controller:
                                      lastNameController,
                                  obscureText:
                                      false,
                                  validator:
                                      (value) {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      MyTextField(
                        next:
                            Icons.person_outline,
                        placeholder: 'Username*',
                        controller:
                            signUpUsernameController,
                        obscureText: false,
                        validator: (value) {},
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      MyTextField(
                        next: Icons
                            .alternate_email_sharp,
                        placeholder:
                            'Email Address*',
                        controller:
                            signUpEmailController,
                        obscureText: false,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Email is required';
                          }
                        },
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      MyTextField(
                        next: Icons
                            .location_on_outlined,
                        placeholder: 'Location',
                        controller:
                            signUpLocationController,
                        obscureText: false,
                        validator: (value) {},
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      MyTextField(
                        next: Icons
                            .lock_open_outlined,
                        placeholder: 'Password*',
                        controller:
                            signUpPasswordController,
                        obscureText: true,
                        validator: (value) {},
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      MyTextField(
                        next: Icons.lock_outline,
                        placeholder:
                            'Confirm Password*',
                        controller:
                            signUpConfirmPasswordController,
                        obscureText: true,
                        validator: (value) {},
                      ),
                    ],
                  ),
                  MyButton(
                    onPressed: () {
                      if (signUpPasswordController
                                  .text.length >=
                              6 &&
                          signUpPasswordController
                                  .text ==
                              signUpConfirmPasswordController
                                  .text) {
                        _register(
                          firstNameController
                              .text,
                          lastNameController.text,
                          signUpUsernameController
                              .text,
                          signUpEmailController
                              .text,
                          signUpLocationController
                              .text,
                          signUpConfirmPasswordController
                              .text,
                          "000 000 0000",
                        );
                        setState(() {
                          errors = '';
                        });
                      } else {
                        setState(() {
                          errors =
                              'Password needs to be 6+ characters';
                          SignResult = '';
                        });
                      }
                    },
                    actionText: 'Sign Up',
                    loading: _isLoading,
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
                  SizedBox(
                    height: 20,
                  )
                  // OutlinedButton(
                  //   onPressed: _fakeData,
                  //   child: const Text(
                  //     "Generate Data",
                  //     style: TextStyle(
                  //         color: Colors.black),
                  //   ),
                  // ),
                ],
              ),
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
