import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/schedule/book_info.dart';
import '../../model/schedule/lesson_report.dart';
import '../../widgets/avatar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

class HistoryReport extends StatefulWidget {
  const HistoryReport({Key? key, required this.historyInfo, required this.reasons}) : super(key: key);

  final BookingInfo historyInfo;
  final List<LessonReport> reasons;

  @override
  State<HistoryReport> createState() => _HistoryReportState();
}

class _HistoryReportState extends State<HistoryReport> {
  static const String url = 'https://sandbox.api.lettutor.com';
  bool isChecked = false;
  List<String> reasonList = [];
  late LessonReport reason;
  TextEditingController textarea = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    reasonList = widget.reasons.map((e) => e.reason).toList();
    reason = widget.reasons[0];
    super.initState();
  }

  Future<void> submitReport(String note, String bookingId, int reasonId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? "";
    var response = await http.put(
      Uri.parse("$url/lesson-report/save-report"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json",
      },
      body: jsonEncode({
        "note": note,
        "bookingId": bookingId,
        "reasonId": reasonId,
      }),
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
    } else {
      final jsonRes = json.decode(response.body);
      throw Exception(jsonRes["message"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Avatar(radius: 50, source: widget.historyInfo.scheduleDetailInfo!.scheduleInfo!.tutorInfo.avatar, name: widget.historyInfo.scheduleDetailInfo!.scheduleInfo!.tutorInfo.name),
            ),
            Text(
              widget.historyInfo.scheduleDetailInfo!.scheduleInfo!.tutorInfo.name,
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10,),
            Text(AppLocalizations.of(context)!.rateLessonTime, style:const TextStyle(fontSize: 14)),
            const SizedBox(height: 10,),
            Text(DateFormat.yMMMEd(AppLocalizations.of(context)!.timeLocale).format(DateTime.fromMillisecondsSinceEpoch(widget.historyInfo.scheduleDetailInfo!.startPeriodTimestamp)),
              style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(widget.historyInfo.scheduleDetailInfo!.startPeriodTimestamp)),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const Text(" - "),
                Text(
                  DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(widget.historyInfo.scheduleDetailInfo!.endPeriodTimestamp)),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(height: 10,),
            const Divider(
              color: Colors.black54,
            ),
            Padding(
              padding:const EdgeInsets.all(8.0),
              child: Text(AppLocalizations.of(context)!.reportQuestion,
                  style:const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownSearch<String>(
                popupProps: const PopupProps.menu(
                  showSelectedItems: true,
                ),
                items: reasonList,
                // dropdownDecoratorProps: const DropDownDecoratorProps(
                //   dropdownSearchDecoration: InputDecoration(
                //     labelText: "My Level",
                //     hintText: "level in menu mode",
                //     border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                //   ),
                // ),
                selectedItem: reasonList[0],
                onChanged: (value) {
                  var index = widget.reasons.indexWhere((element) => element.reason == value);
                  setState(() {
                    reason = widget.reasons[index];
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: TextField(
                controller: textarea,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.addNote,
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1)
                    )
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text(AppLocalizations.of(context)!.later,style: TextStyle(color: isDark ? Colors.white : Colors.black),)),
        TextButton(onPressed: () {
          submitReport(textarea.text, widget.historyInfo.id, reason.id);
          Navigator.pop(context);
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.reportSuccess),
              content: Text(AppLocalizations.of(context)!.thankReport, style: const TextStyle(fontSize: 19),),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }, child: Text(AppLocalizations.of(context)!.submit))
      ],
    );
  }
}
