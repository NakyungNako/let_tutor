import 'package:flutter/material.dart';
import 'package:let_tutor/views/courses/course_card.dart';

class Courses extends StatelessWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
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
              Container(
                margin: const EdgeInsets.all(10),
                  child: const Text(
                      'English For Traveling',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500
                    ),
                  )
              ),
              const CourseCard(
                  imgsrc: 'https://camblycurriculumicons.s3.amazonaws.com/5e2b99f70f8f1e9f625e8317?h=d41d8cd98f00b204e9800998ecf8427e',
                  title: 'Caring for Our Planet',
                  desc: "Let's discuss our relationship as humans with our planet, Earth",
                  level: 'Intermediate',
                  lessons: 7),
              const CourseCard(
                  imgsrc: 'https://camblycurriculumicons.s3.amazonaws.com/5e2b9a4c05342470fdddf8b8?h=d41d8cd98f00b204e9800998ecf8427e',
                  title: 'Healthy Mind, Healthy Body',
                  desc: "Let's discuss the many aspects of living a long, happy life",
                  level: 'Intermediate',
                  lessons: 6),
              const CourseCard(
                  imgsrc: 'https://camblycurriculumicons.s3.amazonaws.com/608b87b5225bacb7cf82697c?h=d41d8cd98f00b204e9800998ecf8427e',
                  title: 'The Olympics',
                  desc: "Let’s practice talking about the Olympics, the biggest sports festival on earth!",
                  level: 'Advanced',
                  lessons: 8),
              Container(
                  margin: const EdgeInsets.all(10),
                  child: const Text(
                    'English For Beginners',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),
                  )
              ),
              const CourseCard(
                  imgsrc: 'https://camblycurriculumicons.s3.amazonaws.com/5e2b895e541a832674533c18?h=d41d8cd98f00b204e9800998ecf8427e',
                  title: 'Basic Conversation Topics',
                  desc: "Gain confidence speaking about familiar topics",
                  level: 'Beginner',
                  lessons: 10),
              const CourseCard(
                  imgsrc: 'https://camblycurriculumicons.s3.amazonaws.com/5e2b99d0c4288f294426b643?h=d41d8cd98f00b204e9800998ecf8427e',
                  title: 'Intermediate Conversation Topics',
                  desc: "Express your ideas and opinions",
                  level: 'Intermediate',
                  lessons: 10),
              const CourseCard(
                  imgsrc: 'https://camblycurriculumicons.s3.amazonaws.com/5e7e51cca52da4ab4bd958e6?h=d41d8cd98f00b204e9800998ecf8427e',
                  title: 'English Conversation 101',
                  desc: "Approachable lessons for absolute beginners",
                  level: 'Beginner',
                  lessons: 10),
            ],
          ),
        ),
    );
  }
}
