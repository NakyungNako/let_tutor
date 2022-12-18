import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
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
  List<BookingInfo> bookInfo = [];
  static const String url = 'https://sandbox.api.lettutor.com';

  @override
  void initState() {
    // TODO: implement initState
    getSchedule();
    super.initState();
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
      });
    } else {
      throw Exception('Failed to load upcomming lesson');
    }
  }
  @override
  Widget build(BuildContext context) {
    int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10000;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20),
          height: 230,
          width: MediaQuery.of(context).size.width,
          color: Colors.red[400],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Upcoming Lesson',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sun, 23 Oct 22 00:30 - 00:55 ',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  CountdownTimer(
                    endTime: endTime,
                    widgetBuilder: (BuildContext context,CurrentRemainingTime? time) {
                      if (time == null) {
                        return const Text('Game over');
                      }
                      return Text(
                        '(starts in ${time.hours}:${time.min}:${time.sec})',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.greenAccent,
                        ),
                      );
                    },
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const Classroom()));
                },
                icon: const Icon(Icons.play_circle_outline),
                label: const Text('Enter room now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red[400],
                ),
              ),
              const Text(
                'Total lesson time is 156 hours 15 minutes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              ElevatedButton.icon(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const HistoryLesson()));
                },
                icon: const Icon(Icons.history),
                label: const Text('History'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: bookInfo.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return ScheduleCard(bookInfo: bookInfo[index], reloadList: () => getSchedule(),);
            },
          ),
        )
      ],
    );
  }
}
