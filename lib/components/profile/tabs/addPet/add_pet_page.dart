import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swipet_mobile/components/profile/profile_tab.dart';
import 'package:swipet_mobile/components/profile/tabs/addPet/tabPages/animal_prompts.dart';
import 'package:swipet_mobile/components/profile/tabs/addPet/tabPages/new_animal_info.dart';
import 'package:swipet_mobile/components/profile/tabs/addPet/tabPages/upload_animal_photo.dart';
import 'package:swipet_mobile/objects/newPetModel.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({super.key});

  @override
  State<AddPetPage> createState() =>
      _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  NewPet newPet = NewPet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: true,
        leading: IconButton(
          iconSize: 30,
          onPressed: () =>
              Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          color: const Color.fromRGBO(
              242, 136, 164, 1),
        ),
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: 8.0),
              child: SvgPicture.asset(
                'lib/assets/appheaders/house-listing.svg',
                colorFilter:
                    const ColorFilter.mode(
                  Color.fromRGBO(
                      242, 136, 164, 1),
                  BlendMode.srcIn,
                ),
              ),
            ),
            const Text(
              ' Your Listings',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Recoleta',
                color: Color.fromRGBO(
                    242, 136, 164, 1),
              ),
            ),
          ],
        ),
        titleSpacing: 10,
      ),
      body: DefaultTabController(
        length: 3,
        child: Builder(
          builder: (context) {
            final TabController tabController =
                DefaultTabController.of(context);
            return Column(
              children: [
                TabBar(
                  isScrollable: true,
                  padding: EdgeInsets.zero,
                  indicatorPadding:
                      EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  tabs: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(
                        horizontal:
                            MediaQuery.of(context)
                                    .size
                                    .width *
                                1 /
                                36,
                      ),
                      child: const Tab(
                        child: TabName(
                            name: 'Animal Info'),
                      ),
                    ),
                    Tab(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(
                                          context)
                                      .size
                                      .width *
                                  1 /
                                  36,
                        ),
                        child: const TabName(
                            name:
                                'Upload Photos'),
                      ),
                    ),
                    Tab(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(
                                      context)
                                  .size
                                  .width *
                              1 /
                              36,
                        ),
                        child: const TabName(
                            name: 'Prompts'),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      NewAnimalInfo(
                          pet: newPet,
                          tabController:
                              tabController),
                      UploadAnimalPhoto(
                          tabController:
                              tabController),
                      AnimalPrompts(
                        pet: newPet,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
