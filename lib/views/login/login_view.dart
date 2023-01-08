import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:let_tutor/model/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:let_tutor/model/user/user_token.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final GoogleSignIn _googleSignIn = GoogleSignIn();
  static const String url = 'https://sandbox.api.lettutor.com';
  final _formfield = GlobalKey<FormState>();
  String email = "";
  String password = "";
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool passToggle = true;
  bool isLoading = false;
  bool isWrong = false;
  bool isChecked = false;

  @override
  void initState() {
    getSharedPreferences();
    super.initState();
  }

  Future<void> getSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('email');
    final storedPass = prefs.getString('password');
    final storedCheck = prefs.getBool("remember_me");

    setState(() {
      _email = TextEditingController(text: storedEmail);
      _password = TextEditingController(text: storedPass);
      if(storedEmail != null){
        email = storedEmail;
      }
      if(storedPass != null){
        password = storedPass;
      }
      if(storedCheck != null){
        isChecked = storedCheck;
      }
    });
    await prefs.remove('email');
    await prefs.remove('password');
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onEmailChanged(String text){
    setState(() {
      if(isWrong == true) isWrong = false;
      email = text;
    });
  }

  void onPasswordChanged(String text) {
    setState(() {
      if(isWrong == true) isWrong = false;
      password = text;
    });
  }

  void handleRemember(bool? value){
    setState(() {
      isChecked = value!;
    });
  }

  Future<void> loginPressed(UserProvider userProvider) async {
    final prefs = await SharedPreferences.getInstance();
    if(isChecked == true){
      prefs.setString('email', email);
      prefs.setString('password', password);
    }
    setState(() {
      isLoading = true;
    });

    var response = await http.post(
      Uri.parse('$url/auth/login'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-type': 'application/json'}
    );

    if(response.statusCode == 200) {
      setState(() {
        _email.clear();
        _password.clear();
      });
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
        isWrong = true;
      });
      print('failed');
    }
  }

  Future<void> signInWithGoogle(UserProvider userProvider) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final String? accessToken = googleAuth?.accessToken;

      if (accessToken != null) {
        try {
          final response = await http.post(Uri.parse("$url/auth/google"), body: {'access_token': accessToken});
          if (response.statusCode == 200) {
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
            final jsonRes = json.decode(response.body);
            throw Exception(jsonRes["message"]);
          }
        } catch (e) {
          print(e);
          // showTopSnackBar(context, CustomSnackBar.error(message: "Login failed! ${e.toString()}"),
          //     showOutAnimationDuration: const Duration(milliseconds: 1000), displayDuration: const Duration(microseconds: 4000));
        }
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = context.watch<UserProvider>();
    TextTheme _textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('LetTutor'),
          // backgroundColor: Colors.white,
          // foregroundColor: Colors.black,
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Center(
            child: Form(
              key: _formfield,
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)!.helloWorld,
                        style: _textTheme.headline4?.copyWith(
                            color:isDark?Colors.white: Colors.blueAccent[700],fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
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
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: onEmailChanged,
                            validator: (value) {
                              bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                              if(value.isEmpty){
                                return AppLocalizations.of(context)!.enterEmail;
                              }
                              if(!emailValid) {
                                return AppLocalizations.of(context)!.enterValidEmail;
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: "enter email"
                            ),
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
                            AppLocalizations.of(context)!.password,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.grey[800]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _password,
                            obscureText: passToggle,
                            onChanged: onPasswordChanged,
                            validator: (value) {
                              if(value!.isEmpty){
                                return AppLocalizations.of(context)!.enterPass;
                              }
                            },
                            decoration: InputDecoration(
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
                          child: Text(AppLocalizations.of(context)!.forgotPassword),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                        SizedBox(
                            height: 24.0,
                            width: 24.0,
                            child: Checkbox(
                                value: isChecked,
                                onChanged: handleRemember)),
                        const SizedBox(width: 10.0),
                        Text(AppLocalizations.of(context)!.rememberMe,)
                      ]),
                    ),
                    isLoading ? const CircularProgressIndicator() : Container(),
                    isWrong ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.red[50],
                            border: Border.all(color: Colors.redAccent),
                          borderRadius: BorderRadius.circular(3)
                        ),
                        child: Text(AppLocalizations.of(context)!.wrongUser, style: const TextStyle(color: Colors.black),),
                      ),
                    ) : Container(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if(isWrong == true) isWrong = false;
                          });
                          if(_formfield.currentState!.validate()){
                            loginPressed(userProvider);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)
                        ),
                        child: Text(AppLocalizations.of(context)!.login),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          children: <Widget>[
                            const Expanded(
                                child: Divider()
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Text(AppLocalizations.of(context)!.or),
                            ),
                            const Expanded(
                                child: Divider()
                            ),
                          ]
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            if(isWrong == true) isWrong = false;
                          });
                          signInWithGoogle(userProvider);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        icon: const FaIcon(FontAwesomeIcons.google),
                        label: Text(AppLocalizations.of(context)!.googleSignIn),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.notMember),
                        TextButton(
                          child: Text(AppLocalizations.of(context)!.signUp),
                          onPressed: () {
                            setState(() {
                              _email.clear();
                              _password.clear();
                              if(isWrong == true) isWrong = false;
                            });
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
        ),
      ),
    );
  }
}