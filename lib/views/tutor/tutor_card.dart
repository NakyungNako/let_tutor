import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/views/tutor/tutor_detail/tutor_detail.dart';
import 'package:let_tutor/widgets/avatar.dart';

class TutorCard extends StatelessWidget {
  const TutorCard({Key? key, required this.name, required this.avt, required this.desc}) :super(key: key);

  final String name;
  final String avt;
  final String desc;

  static const List<String> chips = [
    "English for Business",
    "Conversational",
    "IELTS",
    "TOEFL",
    "TOEIC"
  ];

  @override
  Widget build(BuildContext context) {
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
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                TutorDetail(name: name, avt: avt, desc: desc, chips: chips,)));
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
                            child: Avatar(radius: 37, source: avt, name: name)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                name,
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
                                      child: const Text('Belgium'),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 18,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 18,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 18,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {

                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.redAccent,
                        ))
                  ],
                ),
                Wrap(
                  children: List<Widget>.generate(chips.length, (index) => Chip(label: Text(chips[index]))),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      desc,
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
