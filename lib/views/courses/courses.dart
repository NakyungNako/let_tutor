import 'dart:async';

import 'package:flutter/material.dart';
import 'package:let_tutor/data/course_sample.dart';
import 'package:let_tutor/model/course.dart';
import 'package:let_tutor/views/courses/course_card.dart';

class Courses extends StatefulWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  Timer? _debounce;

  List<Course> _results = [];

  @override
  void initState() {
    // TODO: implement initState
    _results = CoursesSample.courses;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _debounce?.cancel();
    super.dispose();
  }

  void _runFilter(String enteredKeyword) {
    List<Course> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = CoursesSample.courses;
    } else {
      results = CoursesSample.courses
          .where((course) =>
          course.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
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
                hintText: 'Course...',
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
