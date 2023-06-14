import 'dart:async';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patient_mobile_app/resources/globals.dart';
import '../resources/colours.dart';
import '../resources/fonts.dart';
import '../resources/components.dart';
import '../resources/objects.dart';

class AddMedicationPage extends StatefulWidget {
  const AddMedicationPage({super.key});

  @override
  State<StatefulWidget> createState() => _AddMedicationPageState();

}
class _AddMedicationPageState extends State<AddMedicationPage> {
  String dropdownValue = 'Day';
  DateTime startDate = DateTime.now();
  bool isVisible = false;

  TextEditingController drugController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController routeController = TextEditingController();
  TextEditingController commentsController = TextEditingController();

  void updateStartDate(DateTime newDate) {
    startDate = newDate;
  }

  DateTime getStartDate() {
    return startDate;
  }

  @override
  Widget build(BuildContext context) {
    Widget dropDown = DropdownButton<String>(
        focusColor: lighterGrey,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        value: dropdownValue,
        isExpanded: true,
        items: [
          DropdownMenuItem(
              value: 'Day',
              child: Text('Day(s)')),
          DropdownMenuItem(
              value: 'Week',
              child: Text('Week(s)')),
          DropdownMenuItem(
              value: 'Month',
              child: Text('Month(s)')),
          DropdownMenuItem(
              value: 'Year',
              child: Text('Year(s)'))
        ], onChanged: (String? value) {
      setState(() {
        dropdownValue = value!;
      });
    });
    return Scaffold(
      body: Stack(
        children: [
          TitlePageFormat(
              children: [BackButtonBlue(), SizedBox(height: 15,),
                SizedBox(height: 5,),
                AddMedicationInfo(
                  drugController: drugController,
                  dosageController: dosageController,
                  durationController: durationController,
                  routeController: routeController,
                  commentsController: commentsController,
                  dropDown: dropDown, setDates: updateStartDate,
                  getDates: getStartDate,
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 20,
                      child: Visibility(
                          visible: isVisible,
                          child:Text(
                            "* Incomplete Field *",
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                LongButton(word: 'Submit Medication', onPress: (){
                  if (drugController.text == "" ||
                      dosageController.text == "" ||
                      durationController.text == "" ||
                      routeController.text == "") {
                    setState(() {
                      isVisible = true;
                    });
                    Timer(Duration(seconds: 3), () {
                      setState(() {
                        isVisible = false;
                      });
                    });
                  }
                  else {
                    submitNewMedicationEntry(drugController.text,
                                              dosageController.text,
                                              startDate,
                                              "${durationController.text} $dropdownValue",
                                              routeController.text,
                                              commentsController.text
                                            );
                    Navigator.pop(context);
                  }
                  // submitNewDiaryEntry(startDate, drugController.text);
                }
                ),
              ]
          ),
          homeIcon,
          const ProfileLogo(),
        ],
      ),
    );
  }

}

class AddMedicationInfo extends StatelessWidget {

  const AddMedicationInfo({super.key, required this.drugController, required this.dosageController, required this.durationController, required this.routeController, required this.commentsController, required this.dropDown, required this.getDates, required this.setDates});
  final TextEditingController drugController;
  final TextEditingController dosageController;
  final TextEditingController durationController;
  final TextEditingController routeController;
  final TextEditingController commentsController;
  final Widget dropDown;
  final ValueGetter<DateTime> getDates;
  final ValueSetter<DateTime> setDates;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children:
      addMedicationText('Drug', drugController, 'Drug') +
          addMedicationText('Dosage', dosageController, 'Dosage') +
          addDateField('Start Date', getDates, setDates) +
          addDropDown(dropDown, durationController, 'Duration') +
          addMedicationText('Route', routeController, 'Route') +
          addMedicationText('Comments', commentsController, 'Comments')
      ,
    );
  }

}

class AddMedicationDetailsText extends StatelessWidget {
  const AddMedicationDetailsText({super.key, required this.title,  required this.controller, required this.hint});

  final String title;
  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    var isRequired = "";

    if (title == "Comments") {
      isRequired = '';
    }
    else {
      isRequired = '* ';
    }
    return Row(children: [
      Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: SizedBox(width: 5,)),
      Flexible(
          fit: FlexFit.tight,
          flex: 10,
          child: Container(
              width: 50,
              child:DefaultTextStyle(
                style: const TextStyle(color: Colors.black),
                child: requiredField(title, isRequired),
                softWrap: true,))),
      Flexible(
          fit: FlexFit.tight,
          flex:15,
          child: Container(
            width: 250,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                  fillColor: lighterGrey,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  hintText: hint,
                  hintStyle: TextStyle(color: bgGrey),
                  constraints: BoxConstraints(
                      maxHeight: 40
                  ),
                  contentPadding: EdgeInsets.only(left: 10.0)
              ),
            ),
          )),
    ]);
  }
}

List<Widget> addMedicationText(String title, TextEditingController controller, String hint) {
  return [
    Flexible(
        flex: 5,
        fit: FlexFit.loose,
        child: SizedBox(height: 20,)),
    Flexible(
        flex: 1,
        fit: FlexFit.loose,
        child: DefaultTextStyle(style: smallInfo,
            child: AddMedicationDetailsText(title: title, controller: controller, hint: hint,), softWrap: true)),
  ];
}

List<Widget> addDropDown(Widget dropDown, TextEditingController controller, String hint) {
  return [
    Flexible(
        flex: 5,
        fit: FlexFit.loose,
        child: SizedBox(height: 20,)),
    Flexible(
        flex: 1,
        fit: FlexFit.loose,
        child:
        Row(children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: SizedBox(width: 5,)),
          Flexible(
              fit: FlexFit.loose,
              flex: 10,
              child: Container(
                  width: 250,
                  child: DefaultTextStyle(
                    style: const TextStyle(color: Colors.black),
                    softWrap: true,
                    child: requiredField("Duration", "* "),))),
          Flexible(
              fit: FlexFit.tight,
              flex:7,
              child: Container(
                width: 250,
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                      fillColor: lighterGrey,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      hintText: hint,
                      hintStyle: TextStyle(color: bgGrey),
                      constraints: BoxConstraints(
                          maxHeight: 40
                      ),
                      contentPadding: EdgeInsets.only(left: 10.0)
                  ),
                ),
              )),
          Flexible(
              fit: FlexFit.loose,
              flex:8,
              child: Container(
                // padding: EdgeInsets.only(left: 38),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1.0
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0) //                 <--- border radius here
                    ),
                    color: lighterGrey,
                  ),
                  constraints: BoxConstraints(maxHeight: 40),
                  padding: EdgeInsets.only(left: 10.0),
                  width: 200,
                  child: dropDown
              )
          )
        ]))];
}

List<Widget> addDateField(String title, ValueGetter<DateTime> getDate, ValueSetter<DateTime> setDate) {
  return [
    Flexible(
        flex: 5,
        fit: FlexFit.loose,
        child: SizedBox(height: 20,)),
    Flexible(
        flex: 1,
        fit: FlexFit.loose,
        child:
        Row(children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: SizedBox(width: 5,)),
          Flexible(
              fit: FlexFit.loose,
              flex: 10,
              child: Container(
                  width: 250,
                  child: DefaultTextStyle(
                    style: const TextStyle(color: Colors.black),
                    softWrap: true,
                    child: requiredField("Start Date", "* "),))),
          Flexible(
              fit: FlexFit.loose,
              flex:15,
              child: Container(
                  constraints: BoxConstraints(maxHeight: 60),
                  padding: EdgeInsets.zero,
                  width: 250,
                  child: DateTimeFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: lighterGrey,
                      suffixIcon: Icon(Icons.arrow_drop_down),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    onDateSelected: (DateTime value) {
                      setDate(value);
                    },
                    dateFormat: DateFormat.yMd(),
                    initialValue: getDate(),
                    mode: DateTimeFieldPickerMode.date,
                  ))
          )
        ]))];
}


List<Widget> getUrlInfo(String title, String url) {
  List<String> splitted = url.split('/');
  String path = splitted.last;
  return [
    Flexible(
        flex: 5,
        fit: FlexFit.loose,
        child: SizedBox(height: 20,)),
    Flexible(
        flex: 1,
        fit: FlexFit.loose,
        child:
        Row(children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: SizedBox(width: 5,)),
          Flexible(
              fit: FlexFit.tight,
              flex: 10,
              child: Container(
                  width: 50,
                  child: DefaultTextStyle(child: Text('$title:'), style: boldContent, softWrap: true,))),
          Flexible(
              fit: FlexFit.tight,
              flex:11,
              child: Container(
                width: 250,
                child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      textStyle: smallInfoLink,
                    ),
                    onPressed: () {
                      download(url);
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(path, softWrap: true, textAlign: TextAlign.left,),
                    )
                ),
              )),
        ]))];
}

Widget requiredField(String title, String isRequired) {
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: title,
          style: TextStyle(fontSize:20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        TextSpan(
          text: isRequired,
          style: const TextStyle(fontSize:20, color: Colors.red),
        ),
        TextSpan(
          text: ':',
          style: const TextStyle(fontSize:20, color: Colors.black),
        ),
      ],
    ),
  );
}