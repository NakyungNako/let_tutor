import 'package:flutter/material.dart';
import 'package:let_tutor/views/schedule/history_card.dart';

class HistoryLesson extends StatelessWidget {
  const HistoryLesson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('History'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          Column(
            children: const [
              HistoryCard(name: 'Bob', avt: ''),
              HistoryCard(name: 'Tyson', avt: ''),
              HistoryCard(name: 'Bob', avt: '')
            ],
          ),
        ],
      ),
    );
  }
}
