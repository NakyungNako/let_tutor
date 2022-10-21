import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline4!,
      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Account Page'),
            ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/login'));
                }, child: const Text('Log out')),
          ],
        ),
      ),
    );
  }
}
