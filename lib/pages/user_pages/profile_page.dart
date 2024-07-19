import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swipet_mobile/components/my_bottom_bar.dart';
import 'package:swipet_mobile/components/profile/profile_image.dart';
import 'package:swipet_mobile/components/profile/profile_tab.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() =>
      _ProfilePageState();
}

class _ProfilePageState
    extends State<ProfilePage> {
  int selectedIndex = 4;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(
              height: 130,
            ),
            const ProfileImage(
                image:
                    'lib/images/defaultCat.jpg'),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Your Name",
              style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Recoleta'),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 80,
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
