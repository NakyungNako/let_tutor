import 'package:flutter/material.dart';
import 'package:let_tutor/model/course/course.dart';
import 'package:let_tutor/views/courses/course_detail/course_detail.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({Key? key, required this.course,}) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    final listLevels = {
      "0": "Any level",
      "1": "Beginner",
      "2": "High Beginner",
      "3": "Pre-Intermediate",
      "4": "Intermediate",
      "5": "Upper-Intermediate",
      "6": "Advanced",
      "7": "Proficiency"
    };
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CourseDetail(course: course)
              )
          );
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                course.imageUrl,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    course.name,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 10, 40, 5),
                      child: Text(
                        course.description,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey
                        ),
                      )
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                      margin: const EdgeInsets.only(left: 5,top: 10),
                      child: Text('${listLevels[course.level]} · ${course.topics.length} lessons')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

