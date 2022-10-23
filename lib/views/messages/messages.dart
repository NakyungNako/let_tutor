import 'package:flutter/material.dart';
import 'package:let_tutor/views/messages/message.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search message...',
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 2, color: Colors.grey),
                borderRadius: BorderRadius.circular(50.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 2, color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context,index) {
                return const Message();
              },
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
            ),
          )
        ],
      ),
    );
  }
}
