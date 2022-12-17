import 'package:flutter/material.dart';

class TutorStars extends StatelessWidget {
  const TutorStars({Key? key, required this.stars}) : super(key: key);

  final double? stars;

  @override
  Widget build(BuildContext context) {
    List<Widget> starsList() {
      final list = <Widget>[];
      for (var i = 0; i < 5; i++) {
        if (i < stars!.round()) {
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
    return stars != null
        ? Row(children: starsList())
        : const Text("No reviews yet");
  }
}
