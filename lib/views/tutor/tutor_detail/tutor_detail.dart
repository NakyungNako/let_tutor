import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:let_tutor/model/schedule/schedule.dart';
import 'package:let_tutor/model/user/user.dart';
import 'package:let_tutor/views/tutor/tutor_detail/booking.dart';
import 'package:let_tutor/views/tutor/tutor_detail/tutor_report.dart';
import 'package:let_tutor/views/tutor/tutor_detail/tutor_review.dart';
import 'package:let_tutor/widgets/avatar.dart';
import 'package:readmore/readmore.dart';
import 'package:let_tutor/widgets/stars.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../model/course/course.dart';
import '../../../model/schedule/schedule_detail.dart';
import '../../../model/specialties.dart';
import '../../../model/tutor/tutor.dart';
import '../../../model/tutor/tutor_search.dart';


class TutorDetail extends StatefulWidget {
  final String tutorId;
  final VoidCallback changeFavorite;

 const TutorDetail({Key? key, required this.tutorId, required this.changeFavorite }) : super(key: key);

  @override
  State<TutorDetail> createState() => _TutorDetailState();
}

class _TutorDetailState extends State<TutorDetail> {
  Tutor? _tutor;
  late List<String> specialList;
  List<Schedule>? schedule;
  static const String url = 'https://sandbox.api.lettutor.com';
  late FlickManager flickManager;

  @override
  void initState() {
    getUser();
    getSchedule();
    super.initState();
  }

  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? "";
    var response = await http.get(
      Uri.parse("$url/tutor/${widget.tutorId}"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json",
      },
    );
    if(response.statusCode == 200){
      var tutorDetail = Tutor.fromJson(jsonDecode(response.body));
      setState(() {
        _tutor = tutorDetail;
        flickManager = FlickManager(videoPlayerController: VideoPlayerController.network(tutorDetail.video));
      });
    } else {
      final jsonDecode = json.decode(response.body);
      throw Exception(jsonDecode['message']);
    }
  }

  Future<void> getSchedule() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? "";
    var response = await http.post(
        Uri.parse("$url/schedule"), headers: {
          "Authorization": "Bearer $token",
          "Content-type": "application/json",
        }, body: jsonEncode(
        {"tutorId": widget.tutorId}
      )
    );
    if (response.statusCode == 200) {
      final jsonRes = jsonDecode(response.body);
      final List<dynamic> results = jsonRes['data'];
      List<Schedule> scheduleList = results.map((schedule) => Schedule.fromJson(schedule)).toList();
      scheduleList = scheduleList.where((schedule) {
        final now = DateTime.now();
        final start = DateTime.fromMillisecondsSinceEpoch(schedule.startTimestamp);
        return start.isAfter(now) || (start.day == now.day && start.month == now.month && start.year == now.year);
      }).toList();
      scheduleList.sort((s1, s2) => s1.startTimestamp.compareTo(s2.startTimestamp));

      List<Schedule> tempRes = [];

      for (int index = 0; index < scheduleList.length; index++) {
        bool isExist = false;
        for (int index_2 = 0; index_2 < tempRes.length; index_2++) {
          final DateTime first = DateTime.fromMillisecondsSinceEpoch(scheduleList[index].startTimestamp);
          final DateTime second = DateTime.fromMillisecondsSinceEpoch(tempRes[index_2].startTimestamp);
          if (first.day == second.day && first.month == second.month && first.year == second.year) {
            tempRes[index_2].scheduleDetails.addAll(scheduleList[index].scheduleDetails);
            isExist = true;
            break;
          }
        }

        if (!isExist) {
          tempRes.add(scheduleList[index]);
        }
      }

      for (int index = 0; index < tempRes.length; index++) {
        tempRes[index].scheduleDetails.sort((s1, s2) =>
            DateTime.fromMillisecondsSinceEpoch(s1.startPeriodTimestamp).compareTo(DateTime.fromMillisecondsSinceEpoch(s2.startPeriodTimestamp)));
      }
      setState(() {
        schedule = tempRes;
      });

      print(response.body);
    } else {
      throw Exception('Failed to load schedule');
    }
  }

  bookAClass(String scheduleDetailIds) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? "";
    final List<String> idList = [scheduleDetailIds];
    var response = await http.post(
      Uri.parse("$url/booking"),
      body: jsonEncode({"scheduleDetailIds": idList}),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      final jsonRes = jsonDecode(response.body);
      throw Exception(jsonRes["message"]);
    }
  }

  Future openReportDialog() => showDialog(
      context: context,
      builder: (context) => const TutorReport()
  );

  Future openReviewDialog() => showDialog(
      context: context,
      builder: (context) => TutorReview(tutorId: widget.tutorId)
  );

  // void goBook() {
  //   initializeDateFormatting()
  //       .then((_) => Navigator.push(context, MaterialPageRoute(builder: (context) => const Booking())));
  // }

  void onPressedFavorite() {
    widget.changeFavorite();
    setState(() {
      _tutor!.isFavorite = !_tutor!.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final tutorId = ModalRoute.of(context)!.settings.arguments as String;
    if(_tutor != null) {
      var specialtiesList = {...Specialties.specialList};
      specialtiesList.update("english-for-kids", (value) => AppLocalizations.of(context)!.englishKids);
      specialtiesList.update("business-english", (value) => AppLocalizations.of(context)!.englishBusiness);
      specialtiesList.update("conversational-english", (value) => AppLocalizations.of(context)!.englishConversation);
      setState(() {
        specialList = specialtiesList.entries
            .where((element) => _tutor!.specialties.split(",").contains(element.key))
            .map((e) => e.value)
            .toList();
      });
    }

    final List<Course> courses = [];
    // for (Course course in CoursesSample.courses) {
    //   for (Tutor tutor in course.tutors) {
    //     if (tutor.id == _tutor.id) {
    //       courses.add(course);
    //     }
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.tutorProfile),
      ),
      body:_tutor != null ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: Column(
            children: [
              Container(
                height: 200,
                margin: const EdgeInsets.only(bottom: 10),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                    child: FlickVideoPlayer(
                        flickManager: flickManager,
                      flickVideoWithControls: FlickVideoWithControls(
                        videoFit: BoxFit.fitHeight,
                        controls: FlickPortraitControls(
                          progressBarSettings:
                          FlickProgressBarSettings(playedColor: Colors.redAccent),
                        ),
                      ),
                    )
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 15, left: 15),
                      child: Avatar(radius: 40, source: _tutor!.user.avatar, name: _tutor!.user.name),
                  ),
                  // child: Avatar(radius: 60, source: _tutor.user.avatar, name: _tutor.user.name)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        width: 240,
                        child: Text(
                          _tutor!.user.name,
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
                              child: Text(_tutor!.user.country, style: const TextStyle(fontSize: 14),),
                            ),
                          ],
                        ),
                      ),
                      TutorStars(stars: _tutor!.rating)
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(15),
                child: ReadMoreText(
                  _tutor!.bio,
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: AppLocalizations.of(context)!.more,
                  trimExpandedText: AppLocalizations.of(context)!.less,
                  moreStyle: const TextStyle(fontSize: 15, color: Colors.orange),
                  lessStyle: const TextStyle(fontSize: 15, color: Colors.orange),
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                          onPressed: onPressedFavorite,
                          icon: _tutor!.isFavorite ? const Icon(Icons.favorite, color: Colors.redAccent,) : const Icon(Icons.favorite_border),
                      ),
                      Text(AppLocalizations.of(context)!.favorite),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: (){
                            openReportDialog();
                          },
                          icon: const Icon(Icons.info_outline)),
                      Text(AppLocalizations.of(context)!.report),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: (){
                            openReviewDialog();
                          },
                          icon: const Icon(Icons.star_border)),
                      Text(AppLocalizations.of(context)!.reviews),
                    ],
                  ),
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(13),
                child: Text(
                  AppLocalizations.of(context)!.specialties,
                    style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                children: List<Widget>.generate(specialList.length, (index) => Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Chip(label: Text(specialList[index])),
                )),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(13),
                child: Text(
                  AppLocalizations.of(context)!.interests,
                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 30),
                child: Text(
                  _tutor!.interests,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.all(13),
                child: Text(
                  AppLocalizations.of(context)!.teachExp,
                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(left: 30),
                child: Text(
                  _tutor!.experience,
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              _tutor!.user.courses!.isNotEmpty ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(13),
                    child: Text(
                      AppLocalizations.of(context)!.courseProfile,
                      style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 40,right: 40),
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        itemCount: _tutor!.user.courses!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      '${_tutor!.user.courses![index].name}:',
                                      style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {

                                      },
                                    child: const Text(
                                        'Link',
                                        style: TextStyle(fontSize: 16, color: Colors.orange)
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 5,)
                            ],
                          );
                          },
                      ),
                    ),
                  ),
                ],
              ) : Container(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: schedule == null ? null : () {
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          context: context,
                          builder: (BuildContext context) {
                            return LayoutBuilder(
                              builder: (BuildContext context, BoxConstraints constraints) => Container(
                                height: MediaQuery.of(context).size.height * 0.4,
                                constraints: const BoxConstraints(maxWidth: 1000),
                                child: Column(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.only(bottom: 20,top: 20),
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(AppLocalizations.of(context)!.pickDate, style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                          ],
                                        )),
                                    Expanded(
                                      child: ListView.separated(
                                          itemCount: schedule!.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: const EdgeInsets.only(right: 20, left: 20),
                                              child: ConstrainedBox(
                                                constraints: const BoxConstraints.tightFor(height: 40),
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      timeofDay(schedule![index]);
                                                    },
                                                  style: ElevatedButton.styleFrom(
                                                    shape: const RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(
                                                        Radius.circular(15),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text (
                                                    DateFormat.yMMMMd().format(DateTime.fromMillisecondsSinceEpoch(schedule![index].startTimestamp)),
                                                    style: const TextStyle(fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }, separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    },
                    icon: schedule == null
                      ? Container(
                        width: 24,
                        height: 24,
                        padding: const EdgeInsets.all(2.0),
                        child: const CircularProgressIndicator(
                          strokeWidth: 3,
                      ),)
                    : const Icon(Icons.saved_search),
                    label: Text(AppLocalizations.of(context)!.booking),
                  ),
                ),
              )
            ],
          ),
        ),
      ) : const Center(child: CircularProgressIndicator())
    );
  }

  Future timeofDay(Schedule schedules) {
    List<ScheduleDetail> scheduleDetails = schedules.scheduleDetails;

    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) => Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 20,top: 20),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:<Widget>[
                          Text(
                            AppLocalizations.of(context)!.pickClass,
                            style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        shrinkWrap: true,
                        children: List.generate(
                          scheduleDetails.length,
                              (index) => ElevatedButton(
                            onPressed: scheduleDetails[index].isBooked ||
                                DateTime.fromMillisecondsSinceEpoch(scheduleDetails[index].startPeriodTimestamp).isBefore(DateTime.now())
                                ? null
                                : () async {
                              final navigator = Navigator.of(context);
                              final scaffoldMess = ScaffoldMessenger.of(context);
                              final appLocale = AppLocalizations.of(context);
                              if (!scheduleDetails[index].isBooked &&
                                  DateTime.fromMillisecondsSinceEpoch(scheduleDetails[index].startPeriodTimestamp).isAfter(DateTime.now())) {
                                try {
                                  final res = await bookAClass(scheduleDetails[index].id);
                                  if (res) {
                                    scheduleDetails[index].isBooked = true;
                                    navigator.pop();
                                    navigator.pop();

                                    final snackBar = SnackBar(
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      behavior: SnackBarBehavior.floating,
                                      content: AwesomeSnackbarContent(
                                        title: appLocale!.bookSuccess,
                                        message: appLocale.bookSuccess,
                                        contentType: ContentType.success,
                                      ),
                                    );

                                    // Find the ScaffoldMessenger in the widget tree
                                    // and use it to show a SnackBar.
                                    scaffoldMess.showSnackBar(snackBar);
                                  }
                                } catch (e) {
                                  final snackBar = SnackBar(
                                    elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    behavior: SnackBarBehavior.floating,
                                    content: AwesomeSnackbarContent(
                                      title: appLocale!.bookFail,
                                      message: appLocale.bookFail,
                                      contentType: ContentType.failure,
                                      inMaterialBanner: true,
                                    ),
                                  );
                                  scaffoldMess.showSnackBar(snackBar);
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.only(top: 13, bottom: 13),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(scheduleDetails[index].startPeriodTimestamp))} - ",
                                  ),
                                  Text(
                                    DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(scheduleDetails[index].endPeriodTimestamp)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

