import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class Classroom extends StatefulWidget {
  const Classroom({Key? key}) : super(key: key);

  @override
  State<Classroom> createState() => _ClassroomState();
}

class _ClassroomState extends State<Classroom> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 8000;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            color: Colors.black,
            child: Column(
              children: [
                Expanded(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  const Text(
                                    'Class starts in',
                                    style: TextStyle(color: Colors.white, fontSize: 17),
                                  ),
                                  CountdownTimer(
                                    endTime: endTime,
                                    widgetBuilder: (BuildContext context,CurrentRemainingTime? time) {
                                      if (time == null) {
                                        return const Text('Game over');
                                      }
                                      return Text(
                                        '${time.hours}:${time.min}:${time.sec}',
                                        style: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                    )
                ),
                Card(
                  margin: const EdgeInsets.all(10),
                  color: Colors.grey[900],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(onPressed: (){}, icon: const Icon(Icons.mic_none,color: Colors.white,)),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.camera_alt_outlined,color: Colors.white)),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.chat_bubble_outline,color: Colors.white)),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.back_hand_outlined,color: Colors.white)),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.fullscreen,color: Colors.white)),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.more_horiz,color: Colors.white)),
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ), child: const Icon(Icons.call_end,color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
