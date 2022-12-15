import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:let_tutor/model/tutor/favorites.dart';
import 'package:let_tutor/views/tutor/tutor_card.dart';

import '../../data/tutors_sample.dart';
import '../../model/tutor/tutor.dart';

class TutorPage extends StatefulWidget {
  const TutorPage({Key? key}) : super(key: key);

  @override
  State<TutorPage> createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  final List<String> chips = [
    "All",
    "English for kids",
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

  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  List<Tutor> _results = [];
  List<Tutor> _searchedTutor = [];
  String specialty = "All";

  @override
  void initState() {
    // TODO: implement initState
    _results = TutorsSample.tutors;
    _searchedTutor = TutorsSample.tutors;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _debounce?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _runFilter(String enteredKeyword) {
    List<Tutor> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = TutorsSample.tutors;
    } else {
      results = TutorsSample.tutors
          .where((user) =>
          user.fullName.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      _searchedTutor = results;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 1000), () {
                  _runFilter(value);

                  if(specialty != "All"){
                    setState(() {
                      _results = _searchedTutor.where((tutor) => tutor.specialties.contains(specialty)).toList();
                    });
                  } else {
                    setState(() {
                      _results = _searchedTutor;
                    });
                  }
                });
              },
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
            DropdownSearch<String>(
              clearButtonProps: const ClearButtonProps(isVisible: true, icon: Icon(Icons.clear, size: 20)),
              items: const ['Foreign','Vietnamese','Native English'],
              popupProps: const PopupProps.menu(
                showSelectedItems: true,
              ),
              onChanged: (value) {
                print(value);
              },
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
                  return Container(
                    margin: const EdgeInsets.only(right: 3),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          specialty = chips[index];
                        });
                        if(specialty != "All"){
                          setState(() {
                            _results = _searchedTutor.where((tutor) => tutor.specialties.contains(specialty)).toList();
                          });
                        } else {
                          setState(() {
                            _results = _searchedTutor;
                          });
                        }
                        _scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      child: Chip(
                        label: Text(chips[index]),
                        labelStyle: specialty == chips[index] ? TextStyle(color: Colors.red[400]) : null,
                        backgroundColor: specialty == chips[index] ? Colors.red[50] : null,
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _results.length,
                itemBuilder: (context,index) {
                  return TutorCard(tutor: _results[index]);
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
