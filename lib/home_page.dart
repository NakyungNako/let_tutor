import 'package:flutter/material.dart';
import 'package:let_tutor/views/schedule/history.dart';
import 'package:provider/provider.dart';
import 'package:let_tutor/views/configure/account.dart';
import 'package:let_tutor/views/configure/settings.dart';
import 'package:let_tutor/views/courses/courses.dart';
import 'package:let_tutor/views/messages/messages.dart';
import 'package:let_tutor/views/schedule/schedules.dart';
import 'package:let_tutor/views/tutor/tutor.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pages = [
    const TutorPage(),
    const Schedules(),
    const HistoryLesson(),
    const Courses(),
    const Messages(),
  ];

  int currentIndex = 0;
  String page = 'Find a Tutor';

  void onTap(int index){
    setState(() {
      currentIndex = index;
      if(currentIndex == 0){
        page = 'Find a Tutor';
      } else if (currentIndex == 1) {
        page = 'Schedule';
      } else if (currentIndex == 2) {
        page = 'History';
      } else if (currentIndex == 3) {
        page = 'Discover Courses';
      } else {
        page = 'App';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(page),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                      image: NetworkImage('https://camblycurriculumicons.s3.amazonaws.com/5f91cc4c433fcd47eed05118?h=d41d8cd98f00b204e9800998ecf8427e'),
                    fit: BoxFit.fitWidth
                  ),
                ), child: null,
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Account()));
                },
                child: const ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Profile'),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Settings()));
                },
                child: const ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.popUntil(context, ModalRoute.withName('/login'));
                },
                child: const ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Log out'),
                ),
              ),
            ],
          ),
        ),
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
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
            BottomNavigationBarItem(icon: Icon(Icons.my_library_books), label: 'Courses'),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Messages'),
          ],
        ),
      ),
    );
  }
}
