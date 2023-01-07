import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key, required this.setLocale, required this.themeManager}) : super(key: key);

  final void Function(Locale locale) setLocale;
  final ThemeManager themeManager;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final List<String> _locale = ['en','vi'];
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
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),

      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.settings,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(AppLocalizations.of(context)!.mainSettings,style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                )
              ],
            ),
            const Divider(height: 20, thickness: 2),
            buildAccountOption(context, AppLocalizations.of(context)!.changePass, isDark),
            buildAccountOption(context, AppLocalizations.of(context)!.social, isDark),
            buildAccountOption(context, AppLocalizations.of(context)!.language, isDark),
            buildAccountOption(context, AppLocalizations.of(context)!.privacy, isDark),
            const SizedBox(height: 40),
            Row(
              children: [
                const Icon(
                  Icons.change_circle,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(AppLocalizations.of(context)!.otherSetting,style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                )
              ],
            ),
            const Divider(height: 20, thickness: 2),
            // buildSwitchOption('Night Theme', switch1, onChangeFunction1),
            // buildSwitchOption('Notification', switch2, onChangeFunction2),
            // buildSwitchOption('Auto Block', switch3, onChangeFunction3),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.nightTheme,
                    style: TextStyle(
                        fontSize: 20,
                        color: isDark ? Colors.white70 : Colors.grey[700]
                    ),
                  ),
                  Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      activeColor: Colors.orange,
                      trackColor: Colors.grey,
                      value: widget.themeManager.themeMode == ThemeMode.dark,
                      onChanged: (bool newValue) async {
                        widget.themeManager.toggleTheme(newValue);
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('isDark', newValue);
                      },
                    ),
                  )
                ],
              ),
            ),
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

  GestureDetector buildAccountOption(BuildContext context, String title, bool isDark){
    return GestureDetector(
      onTap: (){
        showDialog(context: context,
            builder: (builder){
              return AlertDialog(
                title: Text('Choose Your Language'),
                content: Container(
                  width: double.maxFinite,
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(child: Text(_locale[index] == 'vi' ? "Tiếng Việt" : "English"),
                            onPressed: (){
                              widget.setLocale(Locale.fromSubtags(languageCode: _locale[index]));
                              Navigator.pop(context);
                          },),
                        );
                      }, separatorBuilder: (context,index){
                    return Divider(
                      color: isDark ? Colors.white70 : Colors.grey[700],
                    );
                  }, itemCount: 2
                  ),
                ),
              );
            }
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(
              fontSize: 20,
              color: isDark ? Colors.white70 : Colors.grey[700],
            )),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[700])
          ],
        ),
      ),
    );
  }
}
