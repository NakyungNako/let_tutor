import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:let_tutor/model/tutor/favorites.dart';
import 'package:let_tutor/views/tutor/tutor_detail/booking.dart';
import 'package:let_tutor/views/tutor/tutor_detail/tutor_report.dart';
import 'package:let_tutor/views/tutor/tutor_detail/tutor_review.dart';
import 'package:let_tutor/widgets/avatar.dart';
import 'package:readmore/readmore.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:let_tutor/widgets/stars.dart';

import '../../../data/course_sample.dart';
import '../../../model/course.dart';
import '../../../model/tutor/tutor.dart';


class TutorDetail extends StatefulWidget {

 const TutorDetail({Key? key}) : super(key: key);

  @override
  State<TutorDetail> createState() => _TutorDetailState();
}

class _TutorDetailState extends State<TutorDetail> {

  @override
  void initState() {
    super.initState();
  }

  Future openReportDialog() => showDialog(
      context: context,
      builder: (context) => const TutorReport()
  );

  Future openReviewDialog() => showDialog(
      context: context,
      builder: (context) => const TutorReview()
  );

  void goBook() {
    initializeDateFormatting()
        .then((_) => Navigator.push(context, MaterialPageRoute(builder: (context) => const Booking())));
  }

  @override
  Widget build(BuildContext context) {
    final _tutor = ModalRoute.of(context)!.settings.arguments as Tutor;

    var favorites = context.watch<Favorites>();
    var isFavorite = favorites.itemIds.contains(_tutor.id);

    final List<Course> courses = [];
    for (Course course in CoursesSample.courses) {
      for (Tutor tutor in course.tutors) {
        if (tutor.id == _tutor.id) {
          courses.add(course);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 15, left: 15),
                      child: Avatar(radius: 60, source: _tutor.image, name: _tutor.fullName)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        width: 240,
                        child: Text(
                          _tutor.fullName,
                          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/svg/be.svg', width: 12, height: 12,),
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: Text(_tutor.country, style: TextStyle(fontSize: 14),),
                            ),
                          ],
                        ),
                      ),
                      TutorStars(stars: _tutor.rate),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: ReadMoreText(
                  _tutor.intro,
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'more',
                  trimExpandedText: 'less',
                  moreStyle: const TextStyle(fontSize: 15, color: Colors.lightBlue),
                  lessStyle: const TextStyle(fontSize: 15, color: Colors.lightBlue),
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            if(isFavorite){
                              favorites.remove(_tutor);
                            } else {
                              favorites.add(_tutor);
                            }
                          },
                          icon: isFavorite ? const Icon(Icons.favorite, color: Colors.redAccent,) : const Icon(Icons.favorite_border)),
                      const Text('favorite'),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: (){
                            openReportDialog();
                          },
                          icon: const Icon(Icons.info_outline)),
                      const Text('report'),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: (){
                            openReviewDialog();
                          },
                          icon: const Icon(Icons.star_border)),
                      const Text('reviews'),
                    ],
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(13),
                child: const Text(
                    'Specialties',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                children: List<Widget>.generate(_tutor.specialties.length, (index) => Chip(label: Text(_tutor.specialties[index]))),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(13),
                child: const Text(
                  'Interests',
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 40,right: 40),
                child: const Text(
                  'I loved the weather, the scenery and the laid-back lifestyle of the locals.',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(13),
                child: const Text(
                  'Teaching experience',
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 40,right: 40),
                child: const Text(
                  'I have more than 10 years of teaching english experience',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              courses.isNotEmpty
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(13),
                        child: const Text(
                          "Courses",
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 40,right: 40),
                        child: SizedBox(
                          height: 30,
                          child: ListView.builder(
                            itemCount: courses.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      '${courses[index].title}:',
                                      style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {

                                    },
                                    child: const Text(
                                      'Link',
                                      style: TextStyle(fontSize: 16, color: Colors.lightBlue)
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                  : const Text(""),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      goBook();
                    },
                    child: const Text('Start Booking'),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
