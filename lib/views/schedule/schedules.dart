import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:let_tutor/views/schedule/classroom.dart';
import 'package:let_tutor/views/schedule/history.dart';
import 'package:let_tutor/views/schedule/schedule_card.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/schedule/book_info.dart';

class Schedules extends StatefulWidget {
  const Schedules({Key? key}) : super(key: key);

  @override
  State<Schedules> createState() => _SchedulesState();
}

class _SchedulesState extends State<Schedules> {
  Duration? total;
  int? rawTotal;
  int? endTime;
  List<String>? timeParts;
  BookingInfo? upcomingLesson;
  List<BookingInfo> bookInfo = [];
  bool isLoading = true;
  bool isLoadSchedule = true;
  bool isSchedule = false;
  static const String url = 'https://sandbox.api.lettutor.com';

  @override
  void initState() {
    // TODO: implement initState
    getSchedule();
    getTotal();
    getUpcoming();
    super.initState();
  }

  Future<void> getUpcoming() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? "";
    final dateTime = DateTime.now().millisecondsSinceEpoch;
    final response = await http.get(
      Uri.parse('$url/booking/next?dateTime=$dateTime'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      final listData = jsonRes["data"] as List;
      List<BookingInfo> lessons = listData.map((lesson) => BookingInfo.fromJson(lesson)).toList();
      lessons.sort((a, b) => a.scheduleDetailInfo!.startPeriodTimestamp.compareTo(b.scheduleDetailInfo!.startPeriodTimestamp));
      lessons = lessons.where((element) => element.scheduleDetailInfo!.startPeriodTimestamp > dateTime).toList();
      setState(() {
        if (lessons.isEmpty == false) {
          upcomingLesson = lessons.first;
        }
        isLoading = false;
      });
    } else {
      throw Exception(json.decode(response.body)["message"]);
    }
  }

  Future<void> getTotal() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? "";
    var response = await http.get(
      Uri.parse('$url/call/total'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonRes = json.decode(response.body);
      setState(() {
        rawTotal = jsonRes['total'];
        total = Duration(minutes: jsonRes['total']);
        timeParts = total.toString().split(":");
      });
    } else {
      print('get Total error');
    }
  }

  Future<void> getSchedule() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? "";
    final current = DateTime.now().millisecondsSinceEpoch;
    var response = await http.get(
      Uri.parse(
          "$url/booking/list/student?page=1&perPage=40&dateTimeGte=$current&orderBy=meeting&sortBy=asc"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json",
      },
    );

    if(response.statusCode == 200) {
      final jsonRes = jsonDecode(response.body);
      final bookList = jsonRes['data']['rows'] as List;
      setState(() {
        bookInfo = bookList.map((schedule) => BookingInfo.fromJson(schedule)).toList();
        isLoadSchedule = false;
        if(bookList.isNotEmpty){
          isSchedule = true;
        }
      });
    } else {
      throw Exception('Failed to load upcomming lesson');
    }
  }

  String totalString(List<String> parts) {
    if(AppLocalizations.of(context)!.timeLocale == "en") {
      if (parts[0] != '0') {
        return '${parts[0]} hours ${parts[1]} minutes';
      } else {
        return '${parts[1]} minutes';
      }
    } else {
      if (parts[0] != '0') {
        return '${parts[0]} giờ ${parts[1]} phút';
      } else {
        return '${parts[1]} phút';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    if(upcomingLesson != null){
      setState((){
        endTime = upcomingLesson!.scheduleDetailInfo!.startPeriodTimestamp;
      });
    }
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 5),
          height: 180,
          width: MediaQuery.of(context).size.width,
          color: isDark ? Colors.black38 : Colors.orangeAccent,
          child: isLoading ? const Center(child: CircularProgressIndicator(),) :
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              upcomingLesson != null ? Text(
                AppLocalizations.of(context)!.upcoming,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ) : Text(
                AppLocalizations.of(context)!.noUpcoming,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              upcomingLesson != null ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                        "${DateFormat.yMMMEd(AppLocalizations.of(context)!.timeLocale).format(
                        DateTime.fromMillisecondsSinceEpoch(upcomingLesson!.scheduleDetailInfo!.startPeriodTimestamp))} "
                        "${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(upcomingLesson!.scheduleDetailInfo!.startPeriodTimestamp))} - "
                        "${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(upcomingLesson!.scheduleDetailInfo!.endPeriodTimestamp))} ",
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  const Text("(",style: TextStyle(fontSize: 15, color: Colors.greenAccent)),
                  CountdownTimer(
                    endTime: endTime ?? DateTime.now().millisecondsSinceEpoch + 1000 * 30,
                    textStyle: const TextStyle(fontSize: 15, color: Colors.greenAccent),
                  ),
                  const Text(")", style: TextStyle(fontSize: 15, color: Colors.greenAccent)),
                ],
              ) :  Container(),
              SizedBox(height: 8,),
              upcomingLesson != null ? ElevatedButton.icon(
                onPressed: () async {
                  String? userId = upcomingLesson?.userId;
                  String? tutorId = upcomingLesson?.scheduleDetailInfo?.scheduleInfo?.tutorId;
                  String room = '$userId-$tutorId';
                  String? meetingToken = upcomingLesson?.studentMeetingLink.split('token=')[1];
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>const Classroom()));
                  try {
                    FeatureFlag featureFlag = FeatureFlag();
                    featureFlag.welcomePageEnabled = false;
                    featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION; // Limit video resolution to 360p

                    var options = JitsiMeetingOptions(room: room)
                      ..serverURL = "https://meet.lettutor.com"
                      ..audioOnly = true
                      ..audioMuted = true
                      ..token = meetingToken
                      ..videoMuted = true;

                    await JitsiMeet.joinMeeting(options);
                  } catch (error) {
                    debugPrint("error: $error");
                  }
                },
                icon: const Icon(Icons.play_circle_outline),
                label: Text(AppLocalizations.of(context)!.enterRoom),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: isDark ? Colors.black : Colors.orangeAccent,
                ),
              ) : Container(),
              SizedBox(height: 8,),
              Text(
                rawTotal != 0 && timeParts != null ? AppLocalizations.of(context)!.totalTime(totalString(timeParts!)) : AppLocalizations.of(context)!.welcome,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              // ElevatedButton.icon(
              //   onPressed: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (context)=>const HistoryLesson()));
              //   },
              //   icon: const Icon(Icons.history),
              //   label: const Text('History'),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.white,
              //     foregroundColor: Colors.black87,
              //   ),
              // ),
            ],
          ),
        ),
        isLoadSchedule ? Center(child: CircularProgressIndicator(),) : Expanded(
          child: isSchedule ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: bookInfo.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return ScheduleCard(bookInfo: bookInfo[index], reloadList: () {
                getSchedule();
                getTotal();
                getUpcoming();
              },);
            },
          ) : SvgPicture.asset('assets/svg/empty-box.svg'),
        )
      ],
    );
  }
}
