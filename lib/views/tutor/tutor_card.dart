import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:let_tutor/model/specialties.dart';
import 'package:let_tutor/model/tutor/tutor_search.dart';
import 'package:let_tutor/views/tutor/tutor_detail/tutor_detail.dart';
import 'package:let_tutor/widgets/avatar.dart';
import 'package:let_tutor/widgets/stars.dart';
import 'package:http/http.dart' as http;

class TutorCard extends StatefulWidget {
  const TutorCard({Key? key, required this.tutor, required this.updateFavorite, }) :super(key: key);

  final TutorSearch tutor;
  final VoidCallback updateFavorite;

  @override
  State<TutorCard> createState() => _TutorCardState();
}

class _TutorCardState extends State<TutorCard> {
  static const String url = 'https://sandbox.api.lettutor.com';
  late bool isFavorite;

  @override
  void initState() {
    // TODO: implement initState
    // if(widget.tutor.isfavoritetutor == "1"){
    //   isFavorite = true;
    // } else {
    //   isFavorite = false;
    // }
    super.initState();
  }

  Future<void> onPressedFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? "";
    setState(() {
      if(widget.tutor.isfavoritetutor == "1"){
        widget.tutor.isfavoritetutor = "0";
      } else {
        widget.tutor.isfavoritetutor = "1";
      }
      isFavorite = !isFavorite;
    });
    var response = await http.post(
      Uri.parse('$url/user/manageFavoriteTutor'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {
        'tutorId': widget.tutor.userId,
      },
    );

    if (response.statusCode == 200) {
      // print("success: ${response.body}");
      widget.updateFavorite;
    } else {
      // print("failed: ${response.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      if(widget.tutor.isfavoritetutor == "1"){
        isFavorite = true;
      } else {
        isFavorite = false;
      }
    });
    const specialtiesList = Specialties.specialList;
    final specialList = specialtiesList.entries
        .where((element) => widget.tutor.specialties.split(",").contains(element.key))
        .map((e) => e.value)
        .toList();
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
            // Navigator.pushNamed(context, '/tutordetail',
            //     arguments: tutor.id
            // );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TutorDetail(tutorId: widget.tutor.userId, changeFavorite: () => onPressedFavorite()),
              ),
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
                            child: Avatar(radius: 37, source: widget.tutor.avatar, name: widget.tutor.name)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                widget.tutor.name,
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
                                      child: Text(widget.tutor.country),
                                  ),
                                ],
                              ),
                            ),
                            widget.tutor.rating != null ? TutorStars(stars: widget.tutor.rating!) : Container()
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: onPressedFavorite,
                        icon: isFavorite ? const Icon(Icons.favorite, color: Colors.redAccent,) : const Icon(Icons.favorite_border)
                    ),
                  ],
                ),
                Wrap(
                  children: List<Widget>.generate(specialList.length, (index) => Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Chip(label: Text(specialList[index])),
                  )),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      widget.tutor.bio,
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
