import 'package:flutter/material.dart';
import 'package:let_tutor/views/account.dart';
import 'package:let_tutor/views/courses.dart';
import 'package:let_tutor/views/messages.dart';
import 'package:let_tutor/views/schedule.dart';
import 'package:let_tutor/views/tutor.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pages = [
    const Tutor(),
    const Schedule(),
    const Courses(),
    const Messages(),
    const Account(),
  ];

  int currentIndex = 0;

  void onTap(int index){
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Tutor'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.my_library_books), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.manage_accounts), label: 'Account')
        ],
      ),
    );
  }
}
