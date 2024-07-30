import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:swipet_mobile/components/my_bottom_bar.dart';
import 'package:swipet_mobile/components/profile/profile_image.dart';
import 'package:swipet_mobile/components/profile/profile_tab.dart';
import 'package:swipet_mobile/dbHelper/api_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() =>
      _ProfilePageState();
}

class _ProfilePageState
    extends State<ProfilePage> {
  int selectedIndex = 2;
  String userName = '';
  String fullName = '';
  String email = '';
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    const FlutterSecureStorage storage =
        FlutterSecureStorage();
    String? token =
        await storage.read(key: 'jwtToken');
    if (token != null) {
      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(token);
      if (kDebugMode) {
        print(": $decodedToken");
      }
      setState(() {
        userName = decodedToken['username'] ??
            'Unknown User';
        fullName = (decodedToken['firstName'] +
                ' ' +
                decodedToken['lastName']) ??
            'Unknown Location';
        email = decodedToken['email'] ??
            'No email found';
      });
    }
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
// Ensure NewPet object is initialized

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: Padding(
          padding:
              const EdgeInsets.only(left: 25.0),
          child: SvgPicture.asset(
            'lib/assets/appheaders/person-circle.svg',
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: const Text(
          "Your Profile",
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Recoleta',
          ),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 10,
      ),
      bottomNavigationBar: MyBottomNavBar(
        onTap: onItemTapped,
        currIndex: selectedIndex,
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(
              horizontal: 0.0),
          children: [
            const SizedBox(height: 118),
            const ProfileImage(
                image:
                    'lib/images/defaultCat.jpg'),
            const SizedBox(height: 10),
            Text(
              userName,
              style: const TextStyle(
                  fontSize: 32,
                  fontFamily: 'Recoleta'),
              textAlign: TextAlign.center,
            ),
            Text(
              fullName,
              style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Recoleta'),
              textAlign: TextAlign.center,
            ),
            Text(
              email,
              style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Recoleta'),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
              width: MediaQuery.of(context)
                  .size
                  .width,
            ),
            const ProfileTabs(),
          ],
        ),
      ),
    );
  }
}
