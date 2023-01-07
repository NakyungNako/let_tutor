import 'package:flutter/material.dart';
import 'package:let_tutor/model/course/course.dart';
import 'package:let_tutor/views/courses/course_detail/pdf_viewer.dart';

class CourseDetail extends StatelessWidget {
  const CourseDetail({Key? key, required this.course,}) : super(key: key);

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  course.imageUrl,
                  width: MediaQuery.of(context).size.width,
                ),
                Positioned(
                    top: 50,
                    left: 10,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.black.withOpacity(0.4),
                        shape: const CircleBorder(),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    )
                ),
              ]
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5,bottom: 5),
                      child: Text(
                        course.description,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey
                        ),
                      )
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 15,bottom: 15),
                  //   child: ElevatedButton(
                  //     onPressed: (){},
                  //     style: ElevatedButton.styleFrom(
                  //       minimumSize: const Size.fromHeight(50),
                  //     ),
                  //     child: const Text(
                  //         'Discover',
                  //       style: TextStyle(
                  //         fontSize: 19,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                    child: Row(
                      children: const [
                        Expanded(
                            flex: 1,
                            child: Divider(
                              color: Colors.black54,
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          child: Text(
                            'Overview',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 5,
                            child: Divider(
                              color: Colors.black54,
                            )
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.help_outline,
                        color: Colors.deepOrangeAccent,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'Why take this course',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      course.reason,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.help_outline,
                        color: Colors.deepOrangeAccent,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'What will you be able to do',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      course.purpose,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                    child: Row(
                      children: const [
                        Expanded(
                            flex: 1,
                            child: Divider(
                              color: Colors.black54,
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          child: Text(
                            'Experience Level',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 5,
                            child: Divider(
                              color: Colors.black54,
                            )
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children:[
                      const Icon(
                        Icons.group_add_outlined,
                        color: Colors.indigo,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          listLevels[course.level]!,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                    child: Row(
                      children: const [
                        Expanded(
                            flex: 1,
                            child: Divider(
                              color: Colors.black54,
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          child: Text(
                            'Course Length',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 5,
                            child: Divider(
                              color: Colors.black54,
                            )
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children:[
                      const Icon(
                        Icons.book_outlined,
                        color: Colors.indigo,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                            '${course.topics.length} topics',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 15, 5, 0),
                    child: Row(
                      children: const [
                        Expanded(
                            flex: 1,
                            child: Divider(
                              color: Colors.black54,
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          child: Text(
                            'List Topics',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 5,
                            child: Divider(
                              color: Colors.black54,
                            )
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    itemCount: course.topics.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.only(top: 15,bottom: 15),
                          child: ElevatedButton(
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PDFViewer(url: course.topics[index].nameFile, title: course.topics[index].name)
                                  )
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              backgroundColor: Colors.white70,
                              foregroundColor: Colors.black
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${index+1}. ${course.topics[index].name}',
                                style: const TextStyle(
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
