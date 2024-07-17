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
    int selectedIndex = 3;

    void onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: MyBottomNavBar(
        onTap: onItemTapped,
        currIndex: selectedIndex,
      ),
      body: const Center(
        child: Text("Inquiry Page",
            style: TextStyle(fontSize: 48)),
      ),
    );
  }
}
