import 'package:flutter/material.dart';

class CourseDetail extends StatelessWidget {
  const CourseDetail(
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  imgsrc,
                  width: MediaQuery.of(context).size.width,
                ),
                Positioned(
                    top: 30,
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
                    title,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5,bottom: 5),
                      child: Text(
                        desc,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey
                        ),
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15,bottom: 15),
                    child: ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text(
                          'Discover',
                        style: TextStyle(
                          fontSize: 19,
                        ),
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
                  const Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                        'As climate change and environmentalism become increasingly global issues, this topic appears often in international news and is relevant to many international industries.',
                      style: TextStyle(
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
                  const Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                        'This course covers intermediate level vocabulary related to sustainability and environmental science. In addition, you will complete technical tasks such as describing charts, analyzing data, and making estimations.',
                      style: TextStyle(
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
                            level,
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
                            '$lessons topics',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
