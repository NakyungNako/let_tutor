import 'package:flutter/material.dart';
import 'package:let_tutor/widgets/avatar.dart';

class Message extends StatelessWidget {
  const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const Avatar(radius: 30, source: 'assets/images/lukaku.jpg', name: 'Romelu Lukaku'),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text('Romelu Lukaku',style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                      ),
                      Text('Romelu Lukaku: have you done your homework yet?',overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              )
            ],
          ),
          Divider(thickness: 2),
        ],
      ),
    );
  }
}
