import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:let_tutor/model/tutor/comment.dart';

import 'fivestar_comment.dart';

class TutorReview extends StatefulWidget {
  const TutorReview({Key? key, required this.tutorId}) : super(key: key);
  final String tutorId;

  static const String url = 'https://sandbox.api.lettutor.com';

  @override
  State<TutorReview> createState() => _TutorReviewState();
}

class _TutorReviewState extends State<TutorReview> {
  List<Comment>? commentList;
  late int numCom;

  Future<void> getComment() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? "";
    var response = await http.get(
      Uri.parse("${TutorReview.url}/feedback/v2/${widget.tutorId}"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-type": "application/json",
      },
    );
    if(response.statusCode == 200){
      final jsonRes = jsonDecode(response.body);
      final List<dynamic> results = jsonRes['data']['rows'];
      setState(() {
        commentList = results.map((comment) => Comment.fromJson(comment)).toList();
        numCom = jsonRes['data']['count'];
      });
      print(results);
    } else {
      final jsonRes = json.decode(response.body);
      throw Exception(jsonRes["message"]);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComment();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
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
        const Divider(thickness: 2,),
        Container(
          height: 300.0, // Change as per your requirement
          width: 300.0, // Change as per your requirement
          child:commentList != null ? ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: commentList!.length,
            itemBuilder: (BuildContext context, int index) {
              return Reviewer(name: commentList![index].firstInfo.name, avt: commentList![index].firstInfo.avatar, cmt: commentList![index].content);
            }
          ) : const Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }
}
