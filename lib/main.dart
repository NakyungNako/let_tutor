import 'package:flutter/material.dart';
import 'package:let_tutor/model/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:let_tutor/home_page.dart';
import 'package:let_tutor/views/login/login_view.dart';
import 'package:let_tutor/views/login/register_view.dart';
import 'package:let_tutor/views/login/reset_password.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:let_tutor/views/tutor/tutor_detail/tutor_detail.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final UserProvider userProvider = UserProvider();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => userProvider)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/login',
        routes: <String, WidgetBuilder>{
          '/login':(BuildContext context) => const LoginView(),
          '/register':(BuildContext context) => const RegisterView(),
          '/resetpassword':(BuildContext context) => const ResetPassword(),
          // '/tutordetail':(BuildContext context) => const TutorDetail(),
          '/home':(BuildContext context) => const HomePage(),
        },
      ),
    );
  }
}







