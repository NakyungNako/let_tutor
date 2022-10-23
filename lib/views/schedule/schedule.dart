import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:let_tutor/views/schedule/classroom.dart';
import 'package:let_tutor/views/schedule/history.dart';
import 'package:let_tutor/views/schedule/schedule_card.dart';

class Schedule extends StatelessWidget {
  const Schedule({Key? key}) : super(key: key);

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
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: <Widget>[
              Column(
                children: const [
                  ScheduleCard(name: 'Ronaldo', avt: ''),
                  ScheduleCard(name: 'Kante', avt: ''),
                  ScheduleCard(name: 'Benzema', avt: ''),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
