import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:let_tutor/model/tutor/favorites.dart';
import 'package:let_tutor/model/tutor/tutor.dart';
import 'package:let_tutor/views/tutor/tutor_detail/tutor_detail.dart';
import 'package:let_tutor/widgets/avatar.dart';
import 'package:let_tutor/widgets/stars.dart';

class TutorCard extends StatelessWidget {
  const TutorCard({Key? key, required this.tutor, }) :super(key: key);

  final Tutor tutor;


  @override
  Widget build(BuildContext context) {
    var favorites = context.watch<Favorites>();
    var isFavorite = favorites.itemIds.contains(tutor.id);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/tutordetail',
                arguments: Tutor(
                    tutor.id,
                    tutor.fullName,
                    tutor.country,
                    tutor.rate,
                    tutor.intro,
                    tutor.image,
                    tutor.languages,
                    tutor.details,
                    tutor.specialties,
                    tutor.dateAvailable
                )
            );
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            //constraints: const BoxConstraints(maxHeight: 185),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(right: 15),
                            child: Avatar(radius: 37, source: tutor.image, name: tutor.fullName)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                tutor.fullName,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/svg/be.svg', width: 12, height: 12,),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                      child: Text(tutor.country),
                                  ),
                                ],
                              ),
                            ),
                            TutorStars(stars: tutor.rate)
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          if(isFavorite){
                            favorites.remove(tutor);
                          } else {
                            favorites.add(tutor);
                          }
                        },
                        icon: isFavorite ? const Icon(Icons.favorite, color: Colors.redAccent,) : const Icon(Icons.favorite_border)),
                  ],
                ),
                Wrap(
                  children: List<Widget>.generate(tutor.specialties.length, (index) => Chip(label: Text(tutor.specialties[index]))),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      tutor.intro,
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
