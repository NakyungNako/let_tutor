import 'package:flutter/material.dart';
import 'package:let_tutor/widgets/input_text.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
          title: const Text('Register'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                autocorrect: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Confirm your Password',
                  labelText: 'Re-enter Password',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Register'),
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
    );
  }
}