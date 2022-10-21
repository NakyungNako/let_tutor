import 'package:flutter/material.dart';

class Courses extends StatelessWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline4!,
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: const Text('Course Page'),
      ),
    );
  }
}
