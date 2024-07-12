import 'package:flutter/material.dart';
import 'package:swipet_mobile/components/my_bottom_bar.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() =>
      _FavoritePageState();
}

class _FavoritePageState
    extends State<FavoritePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
