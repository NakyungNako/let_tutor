import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:let_tutor/widgets/avatar.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({Key? key, required this.name, required this.avt}) : super(key: key);

  final String name;
  final String avt;

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Lesson Time: 11:00 - 12:00',style: TextStyle(fontSize: 15),),
                    ElevatedButton(onPressed: (){}, child: const Text('Record'))
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('No request for lesson'),
                const Divider(),
                const Text("Tutor haven't reviewed yet"),
                const Divider(),
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
