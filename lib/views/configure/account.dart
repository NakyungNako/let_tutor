import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:let_tutor/model/exchange/country_code.dart';
import 'package:let_tutor/model/exchange/level.dart';
import 'package:let_tutor/model/exchange/wantolearn.dart';
import 'package:let_tutor/model/user/learn_topics.dart';
import 'package:let_tutor/model/user/test_preparation.dart';
import 'package:let_tutor/widgets/avatar.dart';
import 'package:let_tutor/widgets/input_text.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collection/collection.dart';

import '../../model/user/user.dart';
import '../../model/user_provider.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  static const String url = 'https://sandbox.api.lettutor.com';
  final ImagePicker _picker = ImagePicker();
  TextEditingController? _date;
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  TextEditingController? _phoneController;
  late DateTime? _birthday;
  String _name = "";
  String _levelKey = "";
  String _country = "";
  String _level = "";
  List<LearnTopics> _learnTopics = [];
  List<TestPreparation> _testPrepare = [];
  List<String> _whatLearn = [];
  List<String> _learnTest = [];
  bool isInit = true;



  Future<void> getInfo(UserProvider userProvider) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? "";
    final response = await http.get(
      Uri.parse('$url/user/info'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonRes = jsonDecode(response.body);
      final user = User.fromJson(jsonRes["user"]);
      userProvider.setUser(user);
    } else {
      throw Exception('Cannot get user info');
    }
  }

  void _imgFromGallery(UserProvider userProvider) async {
    final scaffoldMess = ScaffoldMessenger.of(context);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? "";
    var pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (pickedFile != null) {
      final request = http.MultipartRequest("POST", Uri.parse('$url/user/uploadAvatar'));
      request.files.add(await http.MultipartFile.fromPath("avatar", pickedFile.path));
      request.headers.addAll({"Authorization": 'Bearer $token'});
      var response = await request.send();
      if (response.statusCode == 200) {
        getInfo(userProvider);

        final snackBar = SnackBar(
          content: const Text('Booking success!'),
          action: SnackBarAction(
            onPressed: () {
              // Some code to undo the change.
            }, label: 'done',
          ),
        );

        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        scaffoldMess.showSnackBar(snackBar);
      } else {
        print("failedx2");
      }
    }
  }

  Future<void> saveUser(String name, String country, String phone, String birthday, String level, List learnTopics, List testPre, UserProvider userProvider) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? "";
    final response = await http.put(
      Uri.parse('$url/user/info'),
      body: jsonEncode({'name': name, 'country': country, 'phone': phone, 'birthday': birthday, 'level': level, 'learnTopics': learnTopics, 'testPreparations': testPre}),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if(response.statusCode == 200){
      final jsonRes = jsonDecode(response.body);
      final user = User.fromJson(jsonRes["user"]);
      userProvider.setUser(user);
    } else {
      throw Exception('Cannot get user info');
    }
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = context.watch<UserProvider>();
    setState(() {
      if(isInit){
        _name = userProvider.userInfo.name;
        _levelKey = userProvider.userInfo.level!;
        _nameController = TextEditingController(text: userProvider.userInfo.name);
        _emailController = TextEditingController(text: userProvider.userInfo.email);
        _phoneController = TextEditingController(text: userProvider.userInfo.phone);
        _date = TextEditingController(text: userProvider.userInfo.birthday);
        _country = userProvider.userInfo.country;
        _level = userProvider.userInfo.level ?? "BEGINNER";
        _learnTopics = userProvider.userInfo.learnTopics ?? [];
        _testPrepare = userProvider.userInfo.testPreparations ?? [];
      }
      isInit = false;
    });
    for (var element in _learnTopics) {
      _whatLearn.add(element.name);
    }
    for (var element in _testPrepare) {
      _whatLearn.add(element.name);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 5),
          child: Column(
            children: [
              Stack(
                  children: [
                    Avatar(radius: 80, source: userProvider.userInfo.avatar, name: userProvider.userInfo.name),
                    Positioned(
                      bottom: 10,
                      right: 0,
                      child: GestureDetector(
                        onTap: (){
                          _imgFromGallery(userProvider);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 15,
                          child: const Icon(Icons.camera_alt, color: Colors.grey,),
                        ),
                      ),
                    )
                  ]
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  userProvider.userInfo.name,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              const Divider(
                color: Colors.black54,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  style: TextStyle(fontSize: 17),
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText: "Full Name"
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  style: const TextStyle(fontSize: 17),
                  enabled: false,
                  controller: _emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: "Email"
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  style: TextStyle(fontSize: 17),
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: "Phone Number"
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownSearch<String>(
                  popupProps: const PopupProps.menu(
                    showSelectedItems: true,
                  ),
                  items: countryList,
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Country",
                      hintText: "country in menu mode",
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  selectedItem: countryListWithCode[_country],
                  onChanged: (value) {
                    var key = countryListWithCode.keys.firstWhere((k) => countryListWithCode[k] == value);
                    setState(() {
                      _country = key;
                      print(key);
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _date,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    labelText: 'Date of Birth'
                  ),
                  onTap: () async {
                    // _date.text = userProvider.userInfo.birthday!;
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2023)
                    );
                    if(pickedDate != null){
                      setState(() {
                        _date!.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                        _birthday = pickedDate;
                      });

                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownSearch<String>(
                  popupProps: const PopupProps.menu(
                    showSelectedItems: true,
                  ),
                  items: const ['Pre A1 (Beginner)','A1 (Higher Beginner)','A2 (Pre-Intermediate)','B1 (Intermediate)','B2 (Upper-Intermediate)','C1 (Advanced)','C2 (Proficiency)'],
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "My Level",
                      hintText: "level in menu mode",
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  selectedItem: listLevel[_level],
                  onChanged: (value) {
                    var key = listLevel.keys.firstWhere((k) => listLevel[k] == value);
                    setState(() {
                      _levelKey = key;
                      print(key);
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownSearch<String>.multiSelection(
                  popupProps: const PopupPropsMultiSelection.menu(
                    showSelectedItems: true,
                  ),
                  items: const ["English for Kids",
                    "Business English",
                    "Conversational English",
                    "STARTERS",
                    "MOVERS",
                    "FLYERS",
                    "KET",
                    "PET",
                    "IELTS",
                    "TOEFL",
                    "TOEIC"],
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Want to learn",
                      hintText: "level in menu mode",
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  selectedItems: _whatLearn,
                  onChanged: (value) {
                    setState(() {
                      _learnTest = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: (){
                    List<String> learnId = [];
                    List<String> testId = [];
                    // print(_learnTest);
                    // var key = listLearningTopics.keys.firstWhereOrNull((k)
                    // => listLearningTopics[k] == 'STARTERS');
                    for (var element in _learnTest) {
                      var key = listLearningTopics.keys.firstWhereOrNull((k) => listLearningTopics[k] == element);
                      if(key != null){
                        learnId.add(key);
                      } else {
                        key = listPrepare.keys.firstWhereOrNull((k) => listPrepare[k] == element);
                        if(key!=null) testId.add(key);
                      }
                    }
                    saveUser(_nameController!.text, _country, _phoneController!.text, _date!.text, _levelKey, learnId, testId, userProvider);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text(
                    'Save changes',
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
