import 'package:flutter/material.dart';
import 'package:let_tutor/views/courses/course_detail/course_detail.dart';

class CourseCard extends StatelessWidget {
  const CourseCard(
      {Key? key,
        required this.imgsrc,
        required this.title,
        required this.desc,
        required this.level,
        required this.lessons
      }) : super(key: key);

  final String imgsrc;
  final String title;
  final String desc;
  final String level;
  final int lessons;

  @override
  Widget build(BuildContext context) {
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
                  builder: (context) => CourseDetail(
                      imgsrc: imgsrc,
                      title: title,
                      desc: desc,
                      level: level,
                      lessons: lessons
                  )
              )
          );
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imgsrc,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 10, 40, 5),
                      child: Text(
                        desc,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey
                        ),
                      )
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                      margin: const EdgeInsets.only(left: 5,top: 10),
                      child: Text('$level · $lessons lessons')),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

