import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:let_tutor/model/user_provider.dart';
import 'package:let_tutor/theme/theme_constants.dart';
import 'package:let_tutor/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:let_tutor/home_page.dart';
import 'package:let_tutor/views/login/login_view.dart';
import 'package:let_tutor/views/login/register_view.dart';
import 'package:let_tutor/views/login/reset_password.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:let_tutor/views/tutor/tutor_detail/tutor_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  final UserProvider userProvider = UserProvider();

  void setLocale(Locale locale){
    setState(() {
      _locale = locale;
    });
  }

  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    initTheme();
    _themeManager.addListener(themeListener);
    super.initState();
  }

  initTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool("isDark");
    if(isDark != null){
      _themeManager.toggleTheme(isDark);
    }
  }

  themeListener(){
    if(mounted){
      setState(() {

      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => userProvider),
      ],
      child: MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: _themeManager.themeMode,
        locale: _locale,
        title: 'Flutter Demo',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: '/login',
        routes: <String, WidgetBuilder>{
          '/login':(BuildContext context) => const LoginView(),
          '/register':(BuildContext context) => const RegisterView(),
          '/resetpassword':(BuildContext context) => const ResetPassword(),
          // '/tutordetail':(BuildContext context) => const TutorDetail(),
          '/home':(BuildContext context) => HomePage(setLocale: setLocale, themeManager: _themeManager,),
        },
      ),
    );
  }
}







