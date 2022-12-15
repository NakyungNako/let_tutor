import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:let_tutor/home_page.dart';
import 'package:let_tutor/views/login/login_view.dart';
import 'package:let_tutor/views/login/register_view.dart';
import 'package:let_tutor/views/login/reset_password.dart';
import 'package:let_tutor/views/tutor/tutor_detail/tutor_detail.dart';

import 'model/tutor/favorites.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Favorites listFavorites = Favorites();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => listFavorites)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/login',
        routes: <String, WidgetBuilder>{
          '/login':(BuildContext context) => const LoginView(),
          '/register':(BuildContext context) => const RegisterView(),
          '/resetpassword':(BuildContext context) => const ResetPassword(),
          '/tutordetail':(BuildContext context) => const TutorDetail(),
          '/home':(BuildContext context) => const HomePage(),
        },
      ),
    );
  }
}







