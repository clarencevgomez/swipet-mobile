import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swipet_mobile/components/profile/tabs/tab1.dart';
import 'package:swipet_mobile/components/profile/tabs/tab2.dart';

class ProfileTabs extends StatelessWidget {
  const ProfileTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            isScrollable: true,
            padding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            tabs: [
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 25),
                  child: TabName(
                      svgAsset:
                          'lib/assets/appheaders/house-listing.svg',
                      name: 'Your Listings'),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 0.0),
                child: Tab(
                    child: TabName(
                        name:
                            'Profile Information')),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context)
                    .size
                    .height /
                2.2, // Set a height to prevent overflow
            child: const TabBarView(
              children: [
                UserListings(),
                ProfileSettings(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TabName extends StatelessWidget {
  final String? svgAsset;
  final String name;
  const TabName(
      {super.key,
      required this.name,
      this.svgAsset});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (svgAsset != null)
          Padding(
            padding: const EdgeInsets.only(
                right: 10.0),
            child: SvgPicture.asset(
              svgAsset!,
              width: 26,
              height: 26,
              colorFilter: const ColorFilter.mode(
                Color.fromRGBO(242, 136, 164, 1),
                BlendMode.srcIn,
              ),
            ),
          ),
        Text(
          name,
          style: const TextStyle(
              fontSize: 20, letterSpacing: -0.1),
        ),
      ],
    );
  }
}
