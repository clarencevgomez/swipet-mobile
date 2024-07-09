import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:swipet_mobile/MongoDBModels/MongoDBModel.dart';
import 'package:swipet_mobile/components/action_footer.dart';
import 'package:swipet_mobile/components/action_header.dart';
import 'package:swipet_mobile/components/forgot_tile.dart';
import 'package:swipet_mobile/components/text_field.dart';
import 'package:swipet_mobile/components/my_button.dart'; // Import the new component
import 'package:swipet_mobile/dbHelper/mongodb.dart';
import 'package:swipet_mobile/pages/login_page.dart';
import 'package:swipet_mobile/components/router.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;

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

  // NEW USER FUNCTION
  Future<void> _newUser(
      String firstName,
      String lastName,
      String username,
      String email,
      String address,
      String password) async {
    var _id = M.ObjectId(); // FOR A UNIQUE ID

    final data = MongoDbModel(
        id: _id,
        firstName: firstName,
        lastName: lastName,
        username: username,
        email: email,
        address: address,
        password: password);
    await MongoDatabase.addUser(data);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                // ignore: deprecated_member_use
                Text(
                    "inserted->\n\tID: ${_id.$oid}\nUsername: ${username}")));
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
                  child: MyTextField(
                      next: Icons
                          .camera_front_rounded,
                      placeholder: "First Name*",
                      controller:
                          firstNameController,
                      obscureText: false),
                ),

                // Last Name Controller
                MyTextField(
                    next: Icons
                        .video_camera_front_outlined,
                    placeholder: "Last Name*",
                    controller:
                        lastNameController,
                    obscureText: false),
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
                    _newUser(
                      firstNameController.text,
                      lastNameController.text,
                      signUpUsernameController
                          .text,
                      signUpEmailController.text,
                      signUpLocationController
                          .text,
                      signUpConfirmPasswordController
                          .text,
                    );
                  },
                  actionText: 'Sign Up',
                ),
                ActionFooter(
                  page: const LoginPage(),
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
