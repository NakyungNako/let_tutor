import 'package:flutter/material.dart';
import 'package:let_tutor/widgets/input_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  TextEditingController? _repassword;
  bool passToggle = true;
  static const String url = 'https://sandbox.api.lettutor.com';
  final _formfield = GlobalKey<FormState>();
  String email = "";
  String password = "";

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

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    final scaffoldMess = ScaffoldMessenger.of(context);
    final appLocale = AppLocalizations.of(context);
    final response = await http.post(Uri.parse("$url/auth/register"), body: {
      'email': email,
      'password': password,
      "source": "null",
    });

    if (response.statusCode == 201) {
      final snackBar = SnackBar(
        elevation: 0,
        content: Text(appLocale!.registerSuccess),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          onPressed: () {
            // Some code to undo the change.
          }, label: 'done',
        ),
      );
      scaffoldMess.showSnackBar(snackBar);
      if (!mounted) return;
      Navigator.pop(context);
    } else {
      final snackBar = SnackBar(
        elevation: 0,
        content: Text(appLocale!.registerFail),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          onPressed: () {
            // Some code to undo the change.
          }, label: 'done',
        ),
      );
      scaffoldMess.showSnackBar(snackBar);
      throw Exception('Cannot registed');
    }
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
          title: Text(AppLocalizations.of(context)!.register),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email:",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
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
                                return AppLocalizations.of(context)!.enterEmail;
                              }
                              if(!emailValid) {
                                return AppLocalizations.of(context)!.enterValidEmail;
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
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
                            AppLocalizations.of(context)!.password,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
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
                                return AppLocalizations.of(context)!.enterPass;
                              } else if (value.length < 8){
                                return AppLocalizations.of(context)!.shortPass;
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
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.rePassword,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            style: TextStyle(fontSize: 15, color: Colors.grey[900]),
                            controller: _repassword,
                            obscureText: passToggle,
                            onChanged: onPasswordChanged,
                            validator: (value) {
                              if(value!.isEmpty){
                                return AppLocalizations.of(context)!.enterPass;
                              } else if (value != _password.text){
                                return AppLocalizations.of(context)!.matchPass;
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
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if(_formfield.currentState!.validate()){
                            registerUser();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50)
                        ),
                        child: Text(AppLocalizations.of(context)!.register),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppLocalizations.of(context)!.alreadyMember),
                        TextButton(
                          child: Text(AppLocalizations.of(context)!.backToLogin),
                          onPressed: () {
                            Navigator.pop(context);
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