import 'package:flutter/material.dart';
import 'package:swipet_mobile/MongoDBModels/MongoDBModel.dart';
import 'package:swipet_mobile/components/animal_card_items/animal_images.dart';
import 'package:swipet_mobile/components/animal_card_items/info_section.dart';

class AnimalCard extends StatelessWidget {
  final AnimalModel data;
  const AnimalCard(
      {super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    int imgAmnt = data.images.length;

    // image Elements
    int img1 = imgAmnt - imgAmnt;
    int img2 = img1 + 1;
    int img3 = img2 + 1;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(0),
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // PET NAME
                Text(
                  isEmpty(data.petName),
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight:
                          FontWeight.w600),
                ),

                // FIRST IMAGE
                AnimalImage(
                    image: data.images[img1]),

                const SizedBox(
                  height: 10,
                ),
                // PET INFO COMPONENT
                AnimalInfoCard(
                  age: data.age,
                  breed: data.breed,
                  gender: data.gender,
                  location: data.location,
                  color: data.color,
                  petType: data.petType,
                  bio: data.bio,
                  contactEmail: data.contactEmail,
                  adoptionFee: data.adoptionFee,
                  username:
                      data.username.toString(),
                ),

                // PET INFO
                const SizedBox(
                  height: 10,
                ),
                // ANIMAL IMAGE
                if (img2 > 0 &&
                    data.images[img2].isNotEmpty)
                  AnimalImage(
                      image: data.images[img2]),
                const SizedBox(
                  height: 10,
                ),
                const Prompt(
                    info: "Prompt Answer",
                    question: "Prompt Question"),
                const SizedBox(
                  height: 10,
                ),
                // THIRD IMAGE
                if (img3 > 0 &&
                    data.images[img3].isNotEmpty)
                  AnimalImage(
                      image: data.images[img3]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String isEmpty(String? data) {
  return data == null || data.isEmpty ? "" : data;
}
