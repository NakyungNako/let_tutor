import 'package:flutter/material.dart';
import 'package:let_tutor/home_page.dart';
import 'package:let_tutor/views/login/login_view.dart';
import 'package:let_tutor/views/login/register_view.dart';
import 'package:let_tutor/views/login/reset_password.dart';
import 'package:let_tutor/views/tutor/tutor_detail/tutor_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/login',
      routes: <String, WidgetBuilder>{
        '/login':(BuildContext context) => const LoginView(),
        '/register':(BuildContext context) => const RegisterView(),
        '/resetpassword':(BuildContext context) => const ResetPassword(),
        '/home':(BuildContext context) => const HomePage(),
      },
    );
  }
}







