import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swipet_mobile/components/my_bottom_bar.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() =>
      _FavoritePageState();
}

class _FavoritePageState
    extends State<FavoritePage> {
  int _selectedIndex = 2;

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
            'lib/assets/appheaders/balloon-heart.svg',
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        title: const Text(
          "Your Matches",
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
        child: Text("Favorite Page",
            style: TextStyle(fontSize: 48)),
      ),
    );
  }
}
