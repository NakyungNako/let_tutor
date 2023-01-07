import 'package:flutter/material.dart';
import 'package:let_tutor/theme/theme_manager.dart';
import 'package:let_tutor/views/schedule/history.dart';
import 'package:provider/provider.dart';
import 'package:let_tutor/views/configure/account.dart';
import 'package:let_tutor/views/configure/settings.dart';
import 'package:let_tutor/views/courses/courses.dart';
import 'package:let_tutor/views/messages/messages.dart';
import 'package:let_tutor/views/schedule/schedules.dart';
import 'package:let_tutor/views/tutor/tutor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.setLocale, required this.themeManager}) : super(key: key);

  final void Function(Locale locale) setLocale;
  final ThemeManager themeManager;

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
        page = AppLocalizations.of(context)!.findTutor;
      } else if (currentIndex == 1) {
        page = AppLocalizations.of(context)!.schedule;
      } else if (currentIndex == 2) {
        page = AppLocalizations.of(context)!.history;
      } else if (currentIndex == 3) {
        page = AppLocalizations.of(context)!.discover;
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
                child: ListTile(
                  leading: const Icon(Icons.account_circle),
                  title: Text(AppLocalizations.of(context)!.profile),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Settings(setLocale: widget.setLocale, themeManager: widget.themeManager,)));
                },
                child: ListTile(
                  leading: const Icon(Icons.settings),
                  title: Text(AppLocalizations.of(context)!.settings),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.popUntil(context, ModalRoute.withName('/login'));
                },
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text(AppLocalizations.of(context)!.logOut),
                ),
              ),
            ],
          ),
        ),
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTap,
          currentIndex: currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: const Icon(Icons.school), label: AppLocalizations.of(context)!.tutor),
            BottomNavigationBarItem(icon: const Icon(Icons.calendar_today_rounded), label: AppLocalizations.of(context)!.schedule),
            BottomNavigationBarItem(icon: const Icon(Icons.history), label: AppLocalizations.of(context)!.history),
            BottomNavigationBarItem(icon: const Icon(Icons.my_library_books), label: AppLocalizations.of(context)!.courses),
            // BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Messages'),
          ],
        ),
      ),
    );
  }
}
