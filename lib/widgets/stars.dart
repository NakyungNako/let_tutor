import 'package:flutter/material.dart';

class TutorStars extends StatelessWidget {
  const TutorStars({Key? key, required this.stars}) : super(key: key);

  final int stars;

  @override
  Widget build(BuildContext context) {
    List<Widget> starsList() {
      final list = <Widget>[];
      for (var i = 0; i < 5; i++) {
        if (i < stars) {
          list.add(const Icon(
            Icons.star,
            color: Colors.yellow,
            size: 18,
          ));
        } else {
          list.add(const Icon(
            Icons.star_border,
            color: Colors.yellow,
            size: 18,
          ));
        }
      }
      return list;
    }
    return Row(
      children: starsList(),
    );
  }
}
