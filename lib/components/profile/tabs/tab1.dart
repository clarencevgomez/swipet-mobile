import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swipet_mobile/components/animal_card_items/vertical_divider.dart';
import 'package:swipet_mobile/components/router.dart';
import 'package:swipet_mobile/dbHelper/api_service.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();
    return Scaffold(
      body: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () async {
                  await apiService.logout();
                  ScreenNavigator(cx: context)
                      .navigate(
                          '/welcome',
                          NavigatorTweens
                              .bottomToTop());
                },
                child: const ProfileInfoText(
                    svgAsset:
                        'lib/assets/tabSvgs/person.svg',
                    info: 'Logout'),
              ),

              const ProfileInfoHDivider(),

              // const ProfileInfoText(
              //     svgAsset:
              //         'lib/assets/tabSvgs/settings.svg',
              //     info: 'Settings'),
              const SizedBox(height: 100),
              // OutlinedButton(
              //   onPressed: () {
              //     apiService.logout();
              //     ScreenNavigator(cx: context)
              //         .navigate(
              //             '/welcome',
              //             NavigatorTweens
              //                 .bottomToTop());
              //   },
              //   child: const Text('Logout'),
              // ),
              const ProfileLogoArea(
                  svgAsset:
                      'lib/assets/swipet.svg',
                  info: [
                    'info@SwiPet.com',
                    'SwiPet.com'
                  ]),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Information Displayed
class ProfileInfoText extends StatelessWidget {
  final String svgAsset;
  final String info;

  const ProfileInfoText(
      {super.key,
      required this.svgAsset,
      required this.info});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.center,
      children: [
        SizedBox(
          width:
              MediaQuery.of(context).size.width /
                  8,
        ),
        SvgPicture.asset(
          svgAsset,
          width: 26,
          height: 26,
          colorFilter: const ColorFilter.mode(
            Colors.black,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 15),
        Text(
          isEmpty(info),
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.1),
        ),
      ],
    );
  }
}

// BOTTOM LOGO AREA
class ProfileLogoArea extends StatelessWidget {
  final String svgAsset;
  final List<String> info;

  const ProfileLogoArea(
      {super.key,
      required this.svgAsset,
      required this.info});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.center,
      children: [
        SizedBox(
          width:
              MediaQuery.of(context).size.width /
                  8,
        ),
        SvgPicture.asset(
          svgAsset,
          width: 60,
          height: 60,
          colorFilter: const ColorFilter.mode(
            Colors.black,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 15),
        const SizedBox(height: 20),
        Text(
          isEmpty(info[0]),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Recoleta',
          ),
        ),
        Text(
          isEmpty(info[1]),
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Recoleta'),
        ),
      ],
    );
  }
}

String isEmpty(String? value) {
  return value?.isNotEmpty == true
      ? value!
      : 'N/A';
}
