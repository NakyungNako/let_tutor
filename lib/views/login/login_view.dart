import 'package:flutter/material.dart';
import 'package:let_tutor/widgets/input_text.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

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
          title: const Text('Login'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: InputText(iniVal: '', hint: 'Enter your email', label: 'Email', type: 'email', enable: true),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                autocorrect: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your password',
                  labelText: 'Password',
                ),
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
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: const Text('Login'),
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
    );
  }
}