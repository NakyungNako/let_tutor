import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:let_tutor/model/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:let_tutor/model/user/user_token.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  static const String url = 'https://sandbox.api.lettutor.com';
  final _formfield = GlobalKey<FormState>();
  String email = "";
  String password = "";
  TextEditingController? _email;
  TextEditingController? _password;
  bool passToggle = true;
  bool isLoading = false;

  @override
  void initState() {
    // getSharedPreferences();
    super.initState();
  }

  Future<void> getSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('email');
    final storedPass = prefs.getString('password');

    setState(() {
      _email = TextEditingController(text: storedEmail);
      _password = TextEditingController(text: storedPass);
      email = storedEmail!;
      password = storedPass!;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onEmailChanged(String text){
    setState(() {
      email = text;
    });
  }

  void onPasswordChanged(String text) {
    setState(() {
      password = text;
    });
  }
  
  Future<void> loginPressed(UserProvider userProvider) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
    setState(() {
      isLoading = true;
    });

    var response = await http.post(
      Uri.parse('$url/auth/login'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-type': 'application/json'}
    );

    if(response.statusCode == 200) {
      var userToken = UserToken.fromJson(jsonDecode(response.body));
      userProvider.setUser(userToken.user);
      prefs.setString('accessToken',userToken.tokens.access.token);
      prefs.setString('refreshToken',userToken.tokens.refresh.token);
      setState(() {
        isLoading = false;
      });
      if(!mounted) return;
      Navigator.pushNamed(context, '/home');
    } else {
      setState(() {
        isLoading = false;
      });
      print('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = context.watch<UserProvider>();
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Form(
            key: _formfield,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email:",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.grey[800]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: TextStyle(fontSize: 15, color: Colors.grey[900]),
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: onEmailChanged,
                        validator: (value) {
                          bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                          if(value.isEmpty){
                            return "Enter Email!";
                          }
                          if(!emailValid) {
                            return "Enter Valid Email";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            hintText: "enter your email: example@mail.com"),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Password:",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.grey[800]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        style: TextStyle(fontSize: 15, color: Colors.grey[900]),
                        controller: _password,
                        obscureText: passToggle,
                        onChanged: onPasswordChanged,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Enter Password!";
                          }
                        },
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            hintText: "enter your pass",
                            suffixIcon: IconButton(
                              icon: Icon(
                                passToggle ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  passToggle = !passToggle;
                                });
                              },
                            )
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/resetpassword');
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                ),
                isLoading ? const CircularProgressIndicator() : Container(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if(_formfield.currentState!.validate()){
                        loginPressed(userProvider);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)
                    ),
                    child: const Text('Login'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a member yet?'),
                    TextButton(
                      child: const Text('Sign up'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                        },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}