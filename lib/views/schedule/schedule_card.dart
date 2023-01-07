import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/model/schedule/book_info.dart';
import 'package:let_tutor/widgets/avatar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

import '../../model/user_provider.dart';

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
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    var userProvider = context.read<UserProvider>();
    String userId = widget.bookInfo.userId;
    String? tutorId = widget.bookInfo.scheduleDetailInfo?.scheduleInfo?.tutorId;
    String room = '$userId-$tutorId';
    String meetingToken = widget.bookInfo.studentMeetingLink.split('token=')[1];
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
      color: isDark ? null : Colors.grey[300],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Text(
                  DateFormat.yMMMEd(AppLocalizations.of(context)!.timeLocale).format(DateTime.fromMillisecondsSinceEpoch(widget.bookInfo.scheduleDetailInfo!.startPeriodTimestamp)),
                style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
          ),
          Container(
            margin: const EdgeInsets.all(5),
            color: isDark ? Colors.black54 : Colors.white,
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
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
            color: isDark ? Colors.black54 : Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Text(AppLocalizations.of(context)!.lessonTime,style:const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                    Text(
                      DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(widget.bookInfo.scheduleDetailInfo!.startPeriodTimestamp)),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const Text(" - "),
                    Text(
                      DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(widget.bookInfo.scheduleDetailInfo!.endPeriodTimestamp)),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                    final appLocale = AppLocalizations.of(context);
                    final now = DateTime.now();
                    final start = DateTime.fromMillisecondsSinceEpoch(widget.bookInfo.scheduleDetailInfo!.startPeriodTimestamp);
                    if (start.isAfter(now) && now.difference(start).inHours.abs() >= 2) {
                      final res = await cancelBookedClass(widget.bookInfo.id);
                      if (res) {
                        widget.reloadList();
                        final snackBar = SnackBar(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          behavior: SnackBarBehavior.floating,
                          content: AwesomeSnackbarContent(
                            title: appLocale!.removeSuccess,
                            message: appLocale.removeSuccess,
                            contentType: ContentType.success,
                          ),
                        );

                        // Find the ScaffoldMessenger in the widget tree
                        // and use it to show a SnackBar.
                        scaffoldMess.showSnackBar(snackBar);
                      }
                    } else {
                      final snackBar = SnackBar(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        behavior: SnackBarBehavior.floating,
                        content: AwesomeSnackbarContent(
                          title: appLocale!.removeFail,
                          message: appLocale.removeFail,
                          contentType: ContentType.failure,
                        ),
                      );
                      scaffoldMess.showSnackBar(snackBar);
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text(AppLocalizations.of(context)!.remove),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(right: 20),
                  child: ElevatedButton(onPressed: () async {
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
                  }, child: Text(AppLocalizations.of(context)!.goMeet))
              ),
            ],
          ),
        ],
      ),
    );
  }
}
