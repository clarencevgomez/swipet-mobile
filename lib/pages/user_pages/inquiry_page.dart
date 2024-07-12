import 'package:flutter/material.dart';
import 'package:swipet_mobile/components/my_bottom_bar.dart';

class InquiryPage extends StatefulWidget {
  const InquiryPage({super.key});

  @override
  State<InquiryPage> createState() =>
      _InquiryPageState();
}

class _InquiryPageState
    extends State<InquiryPage> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: MyBottomNavBar(
        onTap: _onItemTapped,
        currIndex: _selectedIndex,
      ),
      body: const Center(
        child: Text("Inquiry Page",
            style: TextStyle(fontSize: 48)),
      ),
    );
  }
}
