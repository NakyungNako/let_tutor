import 'package:flutter/material.dart';
import 'package:let_tutor/widgets/avatar.dart';

class Reviewer extends StatelessWidget {
  const Reviewer({Key? key, required this.name, required this.avt, required this.cmt}) : super(key: key);

  final String name;
  final String avt;
  final String cmt;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Avatar(radius: 20, source: avt, name: name),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name),
                      Row(
                        children: const [
                          Icon(Icons.star,color: Colors.yellow,size: 15),
                          Icon(Icons.star,color: Colors.yellow,size: 15),
                          Icon(Icons.star,color: Colors.yellow,size: 15),
                          Icon(Icons.star,color: Colors.yellow,size: 15),
                          Icon(Icons.star,color: Colors.yellow,size: 15),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(child: Text(cmt)),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
