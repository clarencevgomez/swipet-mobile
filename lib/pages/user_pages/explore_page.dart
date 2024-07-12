import 'package:flutter/material.dart';
import 'package:swipet_mobile/components/my_bottom_bar.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() =>
      _ExplorePageState();
}

class _ExplorePageState
    extends State<ExplorePage> {
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
        child: Text("Explore Page",
            style: TextStyle(fontSize: 48)),
      ),
    );
  }
}
