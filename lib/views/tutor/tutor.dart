import 'dart:async';
import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:let_tutor/model/tutor/tutor_search.dart';
import 'package:let_tutor/views/tutor/tutor_card.dart';
import 'package:http/http.dart' as http;

import '../../model/user_provider.dart';
import '../../model/specialties.dart';

class TutorPage extends StatefulWidget {
  const TutorPage({Key? key}) : super(key: key);

  @override
  State<TutorPage> createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  // final List<String> chips = [
  //   "All",
  //   "English for kids",
  //   "English for Business",
  //   "Conversational",
  //   "STARTERS",
  //   "MOVERS",
  //   "FLYERS",
  //   "KET",
  //   "PET",
  //   "IELTS",
  //   "TOEFL",
  //   "TOEIC"
  // ];
  static const String url = 'https://sandbox.api.lettutor.com';

  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  List<TutorSearch> _defaultList = [];
  List<TutorSearch> _results = [];
  List<TutorSearch> _searchedTutor = [];
  String specialty = "all";

  @override
  void initState() {
    // TODO: implement initState
    searchTutor().then((value) => setState(() {
      _defaultList = List.from(value);
      _results = List.from(_defaultList);
      _searchedTutor = List.from(_defaultList);
    }));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _debounce?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  // Future<void> getPreferences() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final storeAccess = prefs.getString('accessToken') ?? "";
  //   if(storeAccess != token){
  //     setState(() {
  //       token = storeAccess;
  //     });
  //   }
  // }

  void _runFilter(String enteredKeyword) {
    List<TutorSearch> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _defaultList;
    } else {
      results = _defaultList
          .where((user) =>
          user.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      _searchedTutor = results;
    });
  }

  Future<List<TutorSearch>> searchTutor() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? "";
    var response = await http.post(
      Uri.parse("$url/tutor/search"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json",
      },
    );
    if(response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      final List<dynamic> results = jsonRes['rows'];
      return results.map((tutor) => TutorSearch.fromJson(tutor)).toList();
    } else {
      final jsonRes = json.decode(response.body);
      throw Exception(jsonRes["message"]);
    }
  }

  void updateDefaultList(String teacherId) {
    var isFav = _defaultList[_defaultList.indexWhere((element) => element.userId == teacherId)].isfavoritetutor;
    if (isFav == "1") {
      _defaultList[_defaultList.indexWhere((element) => element.userId == teacherId)].isfavoritetutor = "0";
    } else {
      _defaultList[_defaultList.indexWhere((element) => element.userId == teacherId)].isfavoritetutor = "1";
    }
  }

  @override
  Widget build(BuildContext context) {
    const specialtiesList = Specialties.specialList;
    final specialList = specialtiesList.entries.toList();
    return Container(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 1000), () {
                  _runFilter(value);

                  if(specialty != "all"){
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
                itemCount: specialList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 3),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          specialty = specialList[index].key;
                        });
                        if(specialty != "all"){
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
                        label: Text(specialList[index].value),
                        labelStyle: specialty == specialList[index].key ? TextStyle(color: Colors.red[400]) : null,
                        backgroundColor: specialty == specialList[index].key ? Colors.red[50] : null,
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
                  return TutorCard(tutor: _results[index], updateFavorite: () => updateDefaultList(_results[index].userId));
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
