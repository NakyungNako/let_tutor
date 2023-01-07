import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../model/schedule/book_info.dart';
import '../../widgets/avatar.dart';

class HistoryRating extends StatefulWidget {
  const HistoryRating({Key? key, required this.historyInfo}) : super(key: key);

  final BookingInfo historyInfo;

  @override
  State<HistoryRating> createState() => _HistoryRatingState();
}

class _HistoryRatingState extends State<HistoryRating> {
  static const String url = 'https://sandbox.api.lettutor.com';
  bool isChecked = false;
  int rateValue = 0;
  TextEditingController textarea = TextEditingController();

  Future<void> submitRating(String content, String userId, String bookingId, int rating) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? "";
    var response = await http.post(
      Uri.parse("$url/user/feedbackTutor"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json",
      },
      body: jsonEncode({
        "content": content,
        "bookingId": bookingId,
        "userId": userId,
        "rating": rating,
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
            const Text("Lesson Time", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(widget.historyInfo.scheduleDetailInfo!.startPeriodTimestamp)),
                  style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                ),
                const Text(", ", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500)),
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
              padding: const EdgeInsets.all(8.0),
              child: Text('What is your rating for ${widget.historyInfo.scheduleDetailInfo!.scheduleInfo!.tutorInfo.name}?',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)
              ),
            ),
            RatingBar(
              initialRating: 3,
              direction: Axis.horizontal,
              itemCount: 5,
              ratingWidget: RatingWidget(
                full: const Icon(Icons.star, color: Colors.amber,),
                half: const Icon(Icons.star_half, color: Colors.amber,),
                empty: Icon(Icons.star, color: Colors.grey[350],),
              ),
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              onRatingUpdate: (rating) {
                setState(() {
                  rateValue = rating.toInt();
                });
              },
            ),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: TextField(
                controller: textarea,
                keyboardType: TextInputType.text,
                maxLines: 3,
                decoration: const InputDecoration(
                    hintText: "Additional Notes",
                    border: OutlineInputBorder(
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
        }, child: const Text('Later',style: TextStyle(color: Colors.black),)),
        TextButton(onPressed: () {
          submitRating(textarea.text, widget.historyInfo.userId, widget.historyInfo.id, rateValue);
          Navigator.pop(context);
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Report Successfully!'),
              content: const Text('Thank you! Your report was sent.', style: TextStyle(fontSize: 19),),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }, child: const Text('Submit'))
      ],
    );
  }
}
