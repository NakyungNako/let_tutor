import 'package:flutter/material.dart';

import 'fivestar_comment.dart';

class TutorReview extends StatelessWidget {
  const TutorReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left:20.0),
                child: const Text('Reviews', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: const Icon(Icons.close)),
          ],
        ),
        const Divider(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:const [
            Reviewer(name: 'Mbappe', avt: 'assets/images/mbappe.jpg', cmt: 'Outstanding teacher with creative teaching style'),
            Reviewer(name: 'Sterling', avt: '', cmt: 'I love this man'),
            Reviewer(name: 'Kevin', avt: '', cmt: 'Easy to understand, great accent'),
            Reviewer(name: 'Erling Haaland', avt: 'assets/images/haaland.jpg', cmt: 'gonna study again, 5 stars!!!'),
          ],
        ),
      ],
    );
  }
}
