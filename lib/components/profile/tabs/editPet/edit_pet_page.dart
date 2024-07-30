import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:swipet_mobile/components/profile/profile_tab.dart';
import 'package:swipet_mobile/components/profile/tabs/editPet/tabs/page1.dart';
import 'package:swipet_mobile/components/profile/tabs/editPet/tabs/page3.dart';
import 'package:swipet_mobile/objects/newPetModel.dart';

class EditPetPage extends StatefulWidget {
  final Map<String, dynamic> pet;
  EditPetPage({super.key, required this.pet});

  @override
  State<EditPetPage> createState() =>
      _EditPetPageState();
}

class _EditPetPageState
    extends State<EditPetPage> {
  NewPet newPetInfo = NewPet();
  String userName = '';
  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    const FlutterSecureStorage storage =
        FlutterSecureStorage();
    String? token =
        await storage.read(key: 'jwtToken');
    if (token != null) {
      Map<String, dynamic> decodedToken =
          JwtDecoder.decode(token);
      if (kDebugMode) {
        print(": $decodedToken");
      }
      setState(() {
        userName = decodedToken['username'] ??
            'Unknown User';
      });
    }
  }

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
            Text(
              '${widget.pet['Pet_Name']} Information',
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
        length: 2,
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
                      EditAnimalInfo(
                          pet: newPetInfo,
                          oldPet: widget.pet,
                          tabController:
                              tabController),
                      EditAnimalPrompts(
                        oldPet: widget.pet,
                        pet: newPetInfo,
                        userLogin: userName,
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
