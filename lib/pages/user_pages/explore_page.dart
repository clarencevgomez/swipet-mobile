import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swipet_mobile/components/my_bottom_bar.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() =>
      _ExplorePageState();
}

class _ExplorePageState
    extends State<ExplorePage> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
            'lib/assets/appheaders/search-heart.svg',
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: const Text(
          "Explore",
          style: TextStyle(
              fontSize: 24,
              fontFamily: 'Recoleta'),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 10,
      ),
      bottomNavigationBar: MyBottomNavBar(
        onTap: _onItemTapped,
        currIndex: _selectedIndex,
      ),
      body: const Center(
        child: Text("Explore Page",
            style: TextStyle(fontSize: 48)),
      ),
    );
  }
}
