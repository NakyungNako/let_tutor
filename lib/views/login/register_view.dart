import 'package:flutter/material.dart';
import 'package:let_tutor/widgets/input_text.dart';
import 'package:http/http.dart' as http;

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
    final response = await http.post(Uri.parse("$url/auth/register"), body: {
      'email': email,
      'password': password,
      "source": "null",
    });

    if (response.statusCode == 201) {
      final snackBar = SnackBar(
        content: const Text('Registed Success!'),
        action: SnackBarAction(
          onPressed: () {
            // Some code to undo the change.
          }, label: 'done',
        ),
      );
      scaffoldMess.showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: const Text('Registed Success!'),
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
          resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Register'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          child: Form(
            key: _formfield,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                          } else if (value.length < 8){
                            return "Password Length must be 8 or more";
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Re-Enter Password:",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.grey[800]),
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
                            return "Enter Password!";
                          } else if (value != _password.text){
                            return "Password mismatch";
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
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if(_formfield.currentState!.validate()){
                        registerUser();
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50)
                    ),
                    child: const Text('Register'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      child: const Text('Log in'),
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
    );
  }
}