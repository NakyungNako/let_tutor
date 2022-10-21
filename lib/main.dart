import 'package:flutter/material.dart';
import 'package:let_tutor/views/home_page.dart';
import 'package:let_tutor/views/login/login_view.dart';
import 'package:let_tutor/views/login/register_view.dart';
import 'package:let_tutor/views/login/reset_password.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/':(BuildContext context) => const FirstPage(),
        '/login':(BuildContext context) => const LoginView(),
        '/register':(BuildContext context) => const RegisterView(),
        '/resetpassword':(BuildContext context) => const ResetPassword(),
        '/home':(BuildContext context) => const HomePage(),
      },
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline4!,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Home Page'),
            TextButton(
              onPressed: (){
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('Login'),),
          ],
        ),
      ),
    );
  }
}





