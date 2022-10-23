import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/views/tutor/tutor_detail/booking.dart';
import 'package:let_tutor/views/tutor/tutor_detail/tutor_report.dart';
import 'package:let_tutor/views/tutor/tutor_detail/tutor_review.dart';
import 'package:let_tutor/widgets/avatar.dart';
import 'package:readmore/readmore.dart';
import 'package:intl/date_symbol_data_local.dart';


class TutorDetail extends StatefulWidget {
 final String name;
 final String avt;
 final String desc;
 final List chips;

 const TutorDetail({Key? key, required this.name, required this.avt, required this.desc, required this.chips}) : super(key: key);

  @override
  State<TutorDetail> createState() => _TutorDetailState();
}

class _TutorDetailState extends State<TutorDetail> {
  late final String _name;
  late final String _avt;
  late final String _desc;
  late final List _chips;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _name = widget.name;
      _avt = widget.avt;
      _desc = widget.desc;
      _chips = widget.chips;
    });
  }

  void handleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: Avatar(radius: 65, source: _avt, name: _name)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          _name,
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/svg/be.svg', width: 15, height: 15,),
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              child: const Text('Belgium',style: TextStyle(fontSize: 17),),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 25,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 25,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 25,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: ReadMoreText(
                  _desc,
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
                          onPressed: handleFavorite,
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
                children: List<Widget>.generate(_chips.length, (index) => Chip(label: Text(_chips[index]))),
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
