import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swipet_mobile/components/animal_card_items/vertical_divider.dart';
import 'package:swipet_mobile/components/profile/profile_button.dart';

class UserListings extends StatelessWidget {
  const UserListings({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.all(12.0),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        const Color.fromRGBO(
                            242, 196, 179, 0.7),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Here you can view all the pets you're listing!",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight:
                            FontWeight.w500),
                  ),
                ),
              ),
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      PetListingInfo(
                          image: '',
                          info: 'Animal Name 1'),
                      PetListingInfo(
                          image: '',
                          info: 'Animal Name 2'),
                      PetListingInfo(
                          image: '',
                          info: 'Animal Name 3'),
                      PetListingInfo(
                          image: '',
                          info: 'Animal Name 4'),
                      PetListingInfo(
                          image: '',
                          info: 'Animal Name 5'),
                      PetListingInfo(
                          image: '',
                          info: 'Animal Name 6'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 15.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileButton(
                    backgroundColor:
                        const Color.fromRGBO(
                            242, 216, 238, 1),
                    svgAsset:
                        'lib/assets/profileSvgs/listPet.svg',
                    onPressed: () {
                      // //     .navigate(
                      // /ScreenNavigator(cx: context)
                      // // /         '/listpetpage',
                      // //         NavigatorTweens
                      // //             .bottomToTop());
                      Navigator.pushNamed(context,
                          '/listpetpage');
                    },
                    actionText:
                        'list a new animal',
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Information Displayed
class PetListingInfo extends StatelessWidget {
  final String image;
  final String info;

  const PetListingInfo({
    super.key,
    required this.image,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment:
              CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context)
                      .size
                      .width /
                  20,
            ),
            ListImage(image: image),
            const SizedBox(width: 10),
            Text(
              info,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.1,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                SvgPicture.asset(
                  'lib/assets/tabSvgs/edit.svg',
                  width: 24,
                  height: 24,
                  colorFilter:
                      const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 25),
                SvgPicture.asset(
                  'lib/assets/tabSvgs/delete.svg',
                  width: 20,
                  height: 20,
                  colorFilter:
                      const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context)
                          .size
                          .width /
                      20,
                ),
              ],
            ),
          ],
        ),
        const ProfileInfoHDivider()
      ],
    );
  }
}

class ListImage extends StatefulWidget {
  final String image;
  const ListImage(
      {super.key, required this.image});

  @override
  State<ListImage> createState() =>
      _ListImageState();
}

class _ListImageState extends State<ListImage> {
  @override
  Widget build(BuildContext context) {
    String imageUrl = widget.image.isNotEmpty
        ? widget.image
        : 'lib/images/defaultLogo-pic.jpg';

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20.0),
        child: Container(
          width: 50, // Adjust the size as needed
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: FractionalOffset.center,
              image: imageUrl.startsWith('http')
                  ? NetworkImage(imageUrl)
                  : AssetImage(imageUrl)
                      as ImageProvider,
            ),
          ),
        ),
      ),
    );
  }
}
