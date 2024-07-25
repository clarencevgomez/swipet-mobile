import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    int selectedIndex = 2;

    void onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        leading: Padding(
          padding:
              const EdgeInsets.only(left: 25.0),
          child: SvgPicture.asset(
            'lib/assets/appheaders/envelope-paper-heart.svg',
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(
            242, 162, 155, 1),
        title: const Text(
          "Your Inquiries",
          style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontFamily: 'Recoleta'),
        ),
        automaticallyImplyLeading: false,
        titleSpacing: 10,
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
