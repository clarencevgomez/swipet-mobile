import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavItem {
  final String svgAsset;
  final String label;
  final String page;
  final double size;
  final Color selectedColor;
  final Color unselectedColor;

  BottomNavItem({
    required this.svgAsset,
    required this.label,
    required this.page,
    required this.size,
    required this.selectedColor,
    required this.unselectedColor,
  });

  BottomNavigationBarItem build(bool isSelected) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        svgAsset,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(
          isSelected
              ? selectedColor
              : unselectedColor,
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }
}

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
        label: 'Swipe',
        page: '/swipepage',
        size: 30,
        svgAsset: 'lib/assets/swipet.svg',
        selectedColor: const Color.fromRGBO(
            242, 145, 163, 1),
        unselectedColor: Colors.white30,
      ),
      BottomNavItem(
        label: 'Explore',
        page: '/explorepage',
        size: 30,
        svgAsset:
            'lib/assets/search-heart-fill.svg',
        selectedColor: Colors.white,
        unselectedColor: Colors.white30,
      ),
      BottomNavItem(
        label: 'Favorites',
        page: '/favoritepage',
        size: 30,
        svgAsset: 'lib/assets/hearts.svg',
        selectedColor: Colors.white,
        unselectedColor: Colors.white30,
      ),
      BottomNavItem(
        label: 'Inquiry',
        page: '/inquiry',
        size: 30,
        svgAsset: 'lib/assets/heart-mail.svg',
        selectedColor: Colors.white,
        unselectedColor: Colors.white30,
      ),
      BottomNavItem(
        label: 'Profile',
        page: '/profilepage',
        size: 34,
        svgAsset: 'lib/assets/person-fill.svg',
        selectedColor: Colors.white,
        unselectedColor: Colors.white30,
      ),
    ];

    // Build the BottomNavigationBarItem widgets
    List<BottomNavigationBarItem> bottomNavItems =
        navItems
            .map((navItem) => navItem.build(
                navItems.indexOf(navItem) ==
                    currIndex))
            .toList();

    return BottomNavigationBar(
      currentIndex: currIndex,
      onTap: (index) {
        // Perform navigation when an item is tapped
        final page = navItems[index].page;
        Navigator.of(context).pushNamed(page);
        // Optional: Call onTap callback if needed
        onTap(index);
      },
      items: bottomNavItems,
      type:
          BottomNavigationBarType.fixed, // Fixed
      backgroundColor: Colors.black,
      // const Color.fromRGBO(242, 145, 163, 1),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white30,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
