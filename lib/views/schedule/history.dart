import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:let_tutor/views/schedule/history_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../model/schedule/book_info.dart';
import '../../model/schedule/lesson_report.dart';

class HistoryLesson extends StatefulWidget {
  const HistoryLesson({Key? key}) : super(key: key);

  @override
  State<HistoryLesson> createState() => _HistoryLessonState();
}

class _HistoryLessonState extends State<HistoryLesson> {
  static const String url = 'https://sandbox.api.lettutor.com';
  List<BookingInfo> historyInfo = [];
  List<LessonReport> reportReason = [];

  @override
  void initState() {
    // TODO: implement initState
    getHistory();
    getReason();
    super.initState();
  }

  Future<void> getReason() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? "";
    var response = await http.get(
      Uri.parse(
          "$url/lesson-report/reason"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json",
      },
    );

    if(response.statusCode == 200) {
      final jsonRes = jsonDecode(response.body);
      final reasonList = jsonRes['rows'] as List;
      setState(() {
        reportReason = reasonList.map((reason) => LessonReport.fromJson(reason)).toList();
      });
    } else {
      throw Exception('Failed to load reason');
    }
  }

  Future<void> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? "";
    final current = DateTime.now().millisecondsSinceEpoch;
    var response = await http.get(
      Uri.parse(
          "$url/booking/list/student?page=1&perPage=20&dateTimeLte=$current&orderBy=meeting&sortBy=desc"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json",
      },
    );

    if(response.statusCode == 200) {
      final jsonRes = jsonDecode(response.body);
      final historyList = jsonRes['data']['rows'] as List;
      setState(() {
        historyInfo = historyList.map((schedule) => BookingInfo.fromJson(schedule)).toList();
      });
    } else {
      throw Exception('Failed to load upcomming lesson');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: historyInfo.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return HistoryCard(historyInfo: historyInfo[index], reasons: reportReason,);
        },
    );
  }
}
