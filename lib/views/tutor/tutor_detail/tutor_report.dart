import 'package:flutter/material.dart';

class TutorReport extends StatefulWidget {
  const TutorReport({Key? key}) : super(key: key);

  @override
  State<TutorReport> createState() => _TutorReportState();
}

class _TutorReportState extends State<TutorReport> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Report Tutor'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Help us understand what's wrong"),
          Row(
            children: [
              Checkbox(value: isChecked, onChanged: (bool? value){
                setState(() {
                  isChecked = value!;
                });
              }),
              const Text('This tutor is annoying me'),
            ],
          ),
          Row(
            children: [
              Checkbox(value: isChecked, onChanged: (bool? value){
                setState(() {
                  isChecked = value!;
                });
              }),
              const Expanded(child: Text('This profile is pretending be someone')),
            ],
          ),
          Row(
            children: [
              Checkbox(value: isChecked, onChanged: (bool? value){
                setState(() {
                  isChecked = value!;
                });
              }),
              const Text('Inappropriate profile photo'),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: const Text('Submit'))
      ],
    );
  }
}
