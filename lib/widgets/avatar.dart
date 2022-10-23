import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key, required this.radius, required this.source, required this.name}) :super(key: key);

  final double radius;
  final String source;
  final String name;


  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.deepPurple[900],
      foregroundColor: Colors.white,
      backgroundImage: source != '' ? AssetImage(source) : null,
      radius: radius,
      child: Text(
        source == '' ? name[0].toUpperCase() : '',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );
  }
}