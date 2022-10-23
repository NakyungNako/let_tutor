import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/widgets/avatar.dart';
import 'package:let_tutor/widgets/input_text.dart';
import 'package:intl/intl.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final TextEditingController _date = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              const Avatar(radius: 80, source: 'assets/images/greenwood.png', name: 'Greenwood'),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Mason Greenwood',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              const Divider(
                color: Colors.black54,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: InputText(iniVal: 'Mason Greenwood', hint: 'Enter name...', label: 'Full Name',type: 'name',enable: true,),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: InputText(iniVal: 'RedMasonG11@gmail.com', hint: 'Enter email...', label: 'Email', type: 'email',enable: false,),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: InputText(iniVal: '', hint: 'Enter phone number...', label: 'Phone Number', type: 'phone', enable: true,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownSearch<String>(
                  popupProps: const PopupProps.menu(
                    showSelectedItems: true,
                  ),
                  items: const ["Brazil", "Italia", "Tunisia", 'Canada', 'United States', 'Viet Nam', 'United Kingdom', 'South Korea', 'Germany', 'China','Thailand','Australia'],
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Country",
                      hintText: "country in menu mode",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  selectedItem: "United Kingdom",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _date,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date of Birth'
                  ),
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2023)
                    );
                    if(pickedDate != null){
                      setState(() {
                        _date.text = DateFormat('dd-MM-yyyy').format(pickedDate);
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
                      border: OutlineInputBorder(),
                    ),
                  ),
                  selectedItem: "A1 (Higher Beginner)",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownSearch<String>.multiSelection(
                  popupProps: const PopupPropsMultiSelection.menu(
                    showSelectedItems: true,
                  ),
                  items: const ["English for Kids",
                    "English for Business",
                    "Conversational",
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
                      border: OutlineInputBorder(),
                    ),
                  ),
                  selectedItems: const ['KET','IELTS'],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: (){
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
