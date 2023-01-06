import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:let_tutor/model/schedule/book_info.dart';
import 'package:let_tutor/widgets/avatar.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard({Key? key, required this.historyInfo}) : super(key: key);

  final BookingInfo historyInfo;

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.grey[300],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Text(DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(widget.historyInfo.scheduleDetailInfo!.startPeriodTimestamp)),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
          ),
          Container(
            margin: const EdgeInsets.all(5),
            color: Colors.white,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Avatar(radius: 30, source: widget.historyInfo.scheduleDetailInfo!.scheduleInfo!.tutorInfo.avatar, name: widget.historyInfo.scheduleDetailInfo!.scheduleInfo!.tutorInfo.name),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.historyInfo.scheduleDetailInfo!.scheduleInfo!.tutorInfo.name,
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
                            child: const Text('Belgium'),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: <Widget>[
                        const Text('Lesson Time : ',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),
                        Text(
                          DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(widget.historyInfo.scheduleDetailInfo!.startPeriodTimestamp)),
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                        ),
                        const Text(" - "),
                        Text(
                          DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(widget.historyInfo.scheduleDetailInfo!.endPeriodTimestamp)),
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                    ElevatedButton(onPressed: (){}, child: const Text('Record'))
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.only(left: 10, right: 10),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(onPressed: (){},
                        child: const Text('Add a Rating')),
                    TextButton(onPressed: (){},
                        child: const Text('Report')),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
