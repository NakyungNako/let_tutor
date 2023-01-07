import 'dart:convert';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String url = 'https://sandbox.api.lettutor.com';
  String email = "";
  late final TextEditingController _email = TextEditingController();

  void onEmailChanged(String text){
    setState(() {
      email = text;
    });
  }

  Future<void> loginPressed() async {
    final scaffoldMess = ScaffoldMessenger.of(context);
    final appLocale = AppLocalizations.of(context);
    var response = await http.post(
        Uri.parse('$url/user/forgotPassword'),
        body: jsonEncode({'email': email}),
        headers: {'Content-type': 'application/json'}
    );

    if(response.statusCode == 200) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        content: Text(appLocale!.registerSuccess),
        action: SnackBarAction(
          textColor: Colors.white,
          onPressed: () {
            // Some code to undo the change.
          }, label: 'close',
        ),
      );
      scaffoldMess.showSnackBar(snackBar);
      if (!mounted) return;
      Navigator.pop(context);
    } else {
      final snackBar = SnackBar(
        elevation: 0,
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        content: Text(appLocale!.registerFail),
        action: SnackBarAction(
          textColor: Colors.white,
          onPressed: () {
            // Some code to undo the change.
          }, label: 'close',
        ),
      );
      scaffoldMess.showSnackBar(snackBar);
      print('failed');
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
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.resetTitle),
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.resetPass,
                style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(AppLocalizations.of(context)!.resetQuote),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: onEmailChanged,
                  decoration: const InputDecoration(
                      hintText: "example@mail.com",
                  ),
                ),
              ),
              const SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: loginPressed,
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50)
                  ),
                  child: Text(AppLocalizations.of(context)!.resetSend),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
