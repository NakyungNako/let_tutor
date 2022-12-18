import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/model/schedule/book_info.dart';
import 'package:let_tutor/widgets/avatar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ScheduleCard extends StatefulWidget {
  const ScheduleCard({Key? key, required this.bookInfo, required this.reloadList}) : super(key: key);

  final BookingInfo bookInfo;
  final VoidCallback reloadList;


  @override
  State<ScheduleCard> createState() => _ScheduleCardState();
}

class _ScheduleCardState extends State<ScheduleCard> {
  static const String url = 'https://sandbox.api.lettutor.com';

  @override
  Widget build(BuildContext context) {
    cancelBookedClass(String scheduleDetailIds) async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken') ?? "";
      final List<String> idList = [scheduleDetailIds];
      var response = await http.delete(
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
    return Card(
      margin: const EdgeInsets.all(10),
      color: Colors.grey[300],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Text(
                  DateFormat.yMEd().format(DateTime.fromMillisecondsSinceEpoch(widget.bookInfo.scheduleDetailInfo!.startPeriodTimestamp)),
                style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
          ),
          Container(
            margin: const EdgeInsets.all(5),
            color: Colors.white,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Avatar(radius: 30, source: widget.bookInfo.scheduleDetailInfo!.scheduleInfo!.tutorInfo.avatar, name: widget.bookInfo.scheduleDetailInfo!.scheduleInfo!.tutorInfo.name),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.bookInfo.scheduleDetailInfo!.scheduleInfo!.tutorInfo.name,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/svg/be.svg', width: 12, height: 12,),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: Text(widget.bookInfo.scheduleDetailInfo!.scheduleInfo!.tutorInfo.country),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Lesson Time:',style: TextStyle(fontSize: 18),),
                Row(
                  children: <Widget>[
                    Text(
                      DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(widget.bookInfo.scheduleDetailInfo!.startPeriodTimestamp)),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const Text(" - "),
                    Text(
                      DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(widget.bookInfo.scheduleDetailInfo!.endPeriodTimestamp)),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )
                  ],
                    // ListView.separated(
                    //   scrollDirection: Axis.vertical,
                    //   shrinkWrap: true,
                    //   padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    //   itemCount: entries.length,
                    //   itemBuilder: (BuildContext context, int index){
                    //     return SizedBox(
                    //       height: 20,
                    //       child: Row(
                    //         children: [
                    //           Text('Session ${index + 1}: ${entries[index].hour}:${entries[index].minute} - '
                    //               '${entries[index].add(const Duration(minutes: 25)).hour}:${entries[index].add(const Duration(minutes: 25)).minute}'),
                    //         ],
                    //       ),
                    //     );
                    //   },
                    //   separatorBuilder: (BuildContext context, int index) => const Divider(),
                    // )
                )],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: ElevatedButton(
                  onPressed: () async {
                    final scaffoldMess = ScaffoldMessenger.of(context);
                    final now = DateTime.now();
                    final start = DateTime.fromMillisecondsSinceEpoch(widget.bookInfo.scheduleDetailInfo!.startPeriodTimestamp);
                    if (start.isAfter(now) && now.difference(start).inHours.abs() >= 2) {
                      final res = await cancelBookedClass(widget.bookInfo.id);
                      if (res) {
                        widget.reloadList();
                        final snackBar = SnackBar(
                          content: const Text('Delete success!'),
                          action: SnackBarAction(
                            onPressed: () {
                              // Some code to undo the change.
                            }, label: 'done',
                          ),
                        );

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        scaffoldMess.showSnackBar(snackBar);
                      }
                    } else {
                      final snackBar = SnackBar(
                        content: const Text('Cannot delete that'),
                        action: SnackBarAction(
                          onPressed: () {
                            // Some code to undo the change.
                          }, label: 'done',
                        ),
                      );
                      scaffoldMess.showSnackBar(snackBar);
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Delete'),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(right: 20),
                  child: ElevatedButton(onPressed: (){}, child: const Text('Go To Meeting'))
              ),
            ],
          ),
        ],
      ),
    );
  }
}
