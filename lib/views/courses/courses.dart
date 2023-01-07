import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:let_tutor/model/course/course.dart';
import 'package:let_tutor/views/courses/course_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  Timer? _debounce;
  static const String url = 'https://sandbox.api.lettutor.com';
  List<Course> _results = [];
  List<Course> _default = [];

  @override
  void initState() {
    // TODO: implement initState
    // _results = CoursesSample.courses;
    getCourses();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> getCourses() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? "";
    var response = await http.get(
      Uri.parse("$url/course?page=1&size=100"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json",
      },
    );

    if(response.statusCode == 200) {
      final jsonRes = jsonDecode(response.body);
      final coLi = jsonRes['data']['rows'] as List;
      setState(() {
        _results = coLi.map((e) => Course.fromJson(e)).toList();
        _default = coLi.map((e) => Course.fromJson(e)).toList();
      });
    } else {
      throw Exception('Cannot get list course');
    }
  }

  void _runFilter(String enteredKeyword) {
    List<Course> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _default;
    } else {
      results = _default
          .where((course) =>
          course.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      _results = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 7),
            child: TextField(
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  _runFilter(value);
                });
              },
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.courseSearch,
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
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _results.length,
                itemBuilder: (context, index) {
                  return CourseCard(course: _results[index]);
                },
                physics: const BouncingScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}
