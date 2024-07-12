import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swipet_mobile/components/bottom_navbar_item.dart'; // Import your updated BottomNavItem class

class MyBottomNavBar extends StatelessWidget {
  final Function(int) onTap;
  final int currIndex;

  const MyBottomNavBar({
    super.key,
    required this.onTap,
    required this.currIndex,
  });

  @override
  Widget build(BuildContext context) {
    // List of BottomNavItem instances
    final List<BottomNavItem> navItems = [
      BottomNavItem(
        icon: SvgPicture.asset(
          'lib/assets/swipet-nav-item.svg',
          height: 28,
          width: 28,
        ),
        label: 'Swipe',
        page: '/swipepage',
      ),
      BottomNavItem(
        icon: SvgPicture.asset(
          'lib/assets/find.svg',
          height: 28,
          width: 28,
        ),
        label: 'Explore',
        page: '/explorepage',
      ),
      BottomNavItem(
        icon: SvgPicture.asset(
          'lib/assets/favorites-page.svg',
          height: 28,
          width: 28,
        ),
        label: 'Favorites',
        page: '/favoritepage',
      ),
      BottomNavItem(
        icon: SvgPicture.asset(
          'lib/assets/inquiry.svg',
          height: 28,
          width: 28,
        ),
        label: 'Inquiry',
        page: '/inquiry',
      ),
      BottomNavItem(
        icon: Icons.account_circle_outlined,
        label: 'Profile',
        page: '/profilepage',
      ),
    ];

    // Build the BottomNavigationBarItem widgets
    List<BottomNavigationBarItem> bottomNavItems =
        navItems
            .map((navItem) => navItem.build())
            .toList();

    return BottomNavigationBar(
      currentIndex: currIndex,
      onTap: (index) {
        // Perform navigation when an item is tapped
        final page = navItems[index].page;
        // Navigator.of(context).pop();
        Navigator.of(context).pushNamed(page);
        // Optional: Call onTap callback if needed
        onTap(index);
      },
      items: bottomNavItems,
      type:
          BottomNavigationBarType.fixed, // Fixed
      backgroundColor:
          const Color.fromRGBO(242, 145, 163, 1),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white30,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
