import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:let_tutor/widgets/avatar.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({Key? key, required this.name, required this.avt}) : super(key: key);

  final String name;
  final String avt;

  @override
  Widget build(BuildContext context) {
    DateTime dt1 = DateTime.parse('2022-10-23 10:00:00');
    DateTime dt2 = DateTime.parse('2022-10-23 10:30:00');
    DateTime dt3 = DateTime.parse('2022-10-23 11:00:00');
    final List<DateTime> entries = <DateTime>[dt1,dt2,dt3];
    return Card(
      margin: const EdgeInsets.all(10),
      color: Colors.grey[300],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: const Text('Sun, 23 Oct 22',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
          ),
          Container(
            margin: const EdgeInsets.all(5),
            color: Colors.white,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Avatar(radius: 30, source: avt, name: name),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      name,
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
                const Text('Lesson Time:',style: TextStyle(fontSize: 18),),
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index){
                    return SizedBox(
                      height: 20,
                      child: Row(
                        children: [
                          Text('Session ${index + 1}: ${entries[index].hour}:${entries[index].minute} - '
                              '${entries[index].add(const Duration(minutes: 25)).hour}:${entries[index].add(const Duration(minutes: 25)).minute}'),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 5),
              child: ElevatedButton(onPressed: (){}, child: const Text('Go To Meeting'))
          ),
        ],
      ),
    );
  }
}
