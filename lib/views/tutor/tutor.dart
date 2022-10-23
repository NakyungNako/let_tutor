import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/views/tutor/tutor_card.dart';

class TutorPage extends StatefulWidget {
  const TutorPage({Key? key}) : super(key: key);

  @override
  State<TutorPage> createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  final List<String> chips = [
    "All",
    "English for Kids",
    "English for Business",
    "Conversational",
    "STARTERS",
    "MOVERS",
    "FLYERS",
    "KET",
    "PET",
    "IELTS",
    "TOEFL",
    "TOEIC"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter tutor name...',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      width: 2, color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
            ),
            const SizedBox(height: 10.0,),
            DropdownSearch<String>.multiSelection(
              items: const ['Foreign','Vietnamese','Native English'],
              popupProps: const PopupPropsMultiSelection.menu(
                showSelectedItems: true,
              ),
              onChanged: print,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: 'Nationality',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1, color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              height: 32,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: chips.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Chip(label: Text(chips[index])),
                  );
                },
                shrinkWrap: true,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context,index) {
                  return const TutorCard(
                      name: 'Romelu Lukaku',
                      avt: 'assets/images/lukaku.jpg',
                      desc: 'I am passionate about running and fitness, I often compete in trail/mountain running events and I love pushing myself. I am training to one day take part in ultra-endurance events. I also enjoy watching rugby on the weekends, reading and watching podcasts on Youtube. My most memorable life experience would be living in and traveling around Southeast Asia.'
                  );
                },
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
              ),
            ),
          ],
        ),
      );
  }
}
