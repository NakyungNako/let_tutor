import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool switch1 = true;
  bool switch2 = false;
  bool switch3 = false;

  onChangeFunction1(bool newValue1){
    setState(() {
      switch1 = newValue1;
    });
  }
  onChangeFunction2(bool newValue2){
    setState(() {
      switch2 = newValue2;
    });
  }
  onChangeFunction3(bool newValue3){
    setState(() {
      switch3 = newValue3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Row(
              children: const [
                Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('Main Settings',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                )
              ],
            ),
            const Divider(height: 20, thickness: 2),
            buildAccountOption(context, 'Change Password'),
            buildAccountOption(context, 'Social'),
            buildAccountOption(context, 'Language'),
            buildAccountOption(context, 'Privacy and Security'),
            const SizedBox(height: 40),
            Row(
              children: const [
                Icon(
                  Icons.change_circle,
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('Other Settings',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                )
              ],
            ),
            const Divider(height: 20, thickness: 2),
            buildSwitchOption('Night Theme', switch1, onChangeFunction1),
            buildSwitchOption('Notification', switch2, onChangeFunction2),
            buildSwitchOption('Auto Block', switch3, onChangeFunction3),
          ],
        ),
      ),
    );
  }

  Padding buildSwitchOption(String title,bool value, Function onChangeMethod){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[700]
            ),
          ),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Colors.blue,
              trackColor: Colors.grey,
              value: value,
              onChanged: (bool newValue) {
                onChangeMethod(newValue);
              },
            ),
          )
        ],
      ),
    );
  }

  GestureDetector buildAccountOption(BuildContext context, String title){
    return GestureDetector(
      onTap: (){
        showDialog(context: context, builder: (BuildContext context){
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('English'),
                Text('Vietnamese')
              ],
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text('Accept'))
            ],
          );
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(
              fontSize: 20,
              color: Colors.grey[700]
            )),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[700])
          ],
        ),
      ),
    );
  }
}
