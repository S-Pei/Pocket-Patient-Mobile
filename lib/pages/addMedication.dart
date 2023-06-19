import 'dart:async';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patient_mobile_app/pages/medicationPage.dart';
import 'package:patient_mobile_app/resources/globals.dart';
import 'package:patient_mobile_app/resources/objects.dart';
import '../resources/colours.dart';
import '../resources/fonts.dart';
import '../resources/components.dart';

class AddMedicationPage extends StatefulWidget {
  const AddMedicationPage({super.key, required this.oldData});

  final MedicationEntry? oldData;

  @override
  State<StatefulWidget> createState() => _AddMedicationPageState(oldData: oldData);

}
class _AddMedicationPageState extends State<AddMedicationPage> {
  _AddMedicationPageState({required this.oldData});

  String dropdownValue = 'Day';
  DateTime startDate = DateTime.now();
  bool isVisible = false;

  MedicationEntry? oldData;

  String getNumFromDurationElseNone() {
    if (oldData == null) {
      return '';
    } else {
      return getNumFromDuration(oldData!.duration);
    }
  }

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
  void initState() {
    super.initState();
    dropdownValue = oldData == null ? 'Day' : getTimeFromDuration(oldData!.duration);
    drugController.text = oldData == null ? '' : oldData!.drug;
    dosageController.text = oldData == null ? '' : oldData!.dosage;
    durationController.text = getNumFromDurationElseNone();
    routeController.text = oldData == null ? '' : oldData!.route;
    commentsController.text = oldData == null ? '' : oldData!.comments;
  }

  @override
  Widget build(BuildContext context) {
    Widget dropDown = DropdownButton<String>(
        focusColor: lighterGrey,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        value: dropdownValue,
        isExpanded: true,
        items: const [
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
        print(value);
        dropdownValue = value!;
      });
    });
    return Scaffold(
      body: Stack(
        children: [
          TitlePageFormat(
              children: [
                const BackButtonBlue(),
                const SizedBox(height: 20,),
                AddMedicationInfo(
                  drugController: drugController,
                  dosageController: dosageController,
                  durationController: durationController,
                  routeController: routeController,
                  commentsController: commentsController,
                  dropDown: dropDown, setDates: updateStartDate,
                  getDates: getStartDate,
                  oldData: oldData,
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 20,
                      child: Visibility(
                          visible: isVisible,
                          child: const Text(
                            "* Incomplete Field *",
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          )
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                LongButton(word: 'Submit Medication', onPress: (){
                  if (drugController.text == "" ||
                      dosageController.text == "" ||
                      durationController.text == "" ||
                      routeController.text == "") {
                    setState(() {
                      isVisible = true;
                    });
                    Timer(const Duration(seconds: 3), () {
                      if(mounted){
                        setState(() {
                        isVisible = false;
                      });}
                    });
                  }
                  else {
                    if (oldData == null) {
                      submitNewMedicationEntry(drugController.text,
                          dosageController.text,
                          startDate,
                          "${durationController.text} $dropdownValue",
                          routeController.text,
                          commentsController.text
                      );
                      Navigator.pop(context);
                    } else {
                      submitUpdateMedicationEntry(
                          oldData!.id,
                          drugController.text,
                          dosageController.text,
                          startDate,
                          "${durationController.text} $dropdownValue",
                          routeController.text,
                          commentsController.text
                      );
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  }
                }
                ),
              ]
          ),
          homeIcon,
        ],
      ),
    );
  }

}

class AddMedicationInfo extends StatelessWidget {

  const AddMedicationInfo({super.key, required this.drugController,
    required this.dosageController, required this.durationController,
    required this.routeController, required this.commentsController,
    required this.dropDown, required this.getDates,
    required this.setDates, required this.oldData});
  final TextEditingController drugController;
  final TextEditingController dosageController;
  final TextEditingController durationController;
  final TextEditingController routeController;
  final TextEditingController commentsController;
  final Widget dropDown;
  final ValueGetter<DateTime> getDates;
  final ValueSetter<DateTime> setDates;
  final MedicationEntry? oldData;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children:
      addMedicationText('Drug', drugController, 'Drug', oldData == null ? null : oldData!.drug) +
          addMedicationText('Dosage', dosageController, 'Dosage', oldData == null ? null: oldData!.dosage) +
          addDateField('Start Date', getDates, setDates, oldData == null ? null : oldData!.startDate) +
          addDropDown(dropDown, durationController, 'Duration', oldData == null ? null: oldData!.duration) +
          addMedicationText('Route', routeController, 'Route', oldData == null ? null: oldData!.route) +
          addMedicationText('Comments', commentsController, 'Comments', oldData == null ? null: oldData!.comments)
      ,
    );
  }

}

class AddMedicationDetailsText extends StatelessWidget {
  const AddMedicationDetailsText({super.key, required this.title,
    required this.controller, required this.hint, required this.oldValue});

  final String title;
  final TextEditingController controller;
  final String hint;
  final String? oldValue;

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
      const Flexible(
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
                softWrap: true,
                child: requiredField(title, isRequired),))),
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
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  hintText: hint,
                  hintStyle: const TextStyle(color: bgGrey),
                  constraints: const BoxConstraints(
                      maxHeight: 40
                  ),
                  contentPadding: const EdgeInsets.only(left: 10.0)
              ),
            ),
          )),
    ]);
  }
}

List<Widget> addMedicationText(String title, TextEditingController controller, String hint, String? oldValue) {
  return [
    const Flexible(
        flex: 5,
        fit: FlexFit.loose,
        child: SizedBox(height: 20,)),
    Flexible(
        flex: 1,
        fit: FlexFit.loose,
        child: DefaultTextStyle(style: smallInfo, softWrap: true,
            child: AddMedicationDetailsText(title: title, controller: controller, hint: hint, oldValue: oldValue,))),
  ];
}

List<Widget> addDropDown(Widget dropDown, TextEditingController controller, String hint, String? oldValue) {
  return [
    const Flexible(
        flex: 5,
        fit: FlexFit.loose,
        child: SizedBox(height: 20,)),
    Flexible(
        flex: 1,
        fit: FlexFit.loose,
        child:
        Row(children: [
          const Flexible(
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
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      hintText: hint,
                      hintStyle: const TextStyle(color: bgGrey),
                      constraints: const BoxConstraints(
                          maxHeight: 40
                      ),
                      contentPadding: const EdgeInsets.only(left: 10.0)
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
                    borderRadius: const BorderRadius.all(
                        Radius.circular(10.0) //                 <--- border radius here
                    ),
                    color: lighterGrey,
                  ),
                  constraints: const BoxConstraints(maxHeight: 40),
                  padding: const EdgeInsets.only(left: 10.0),
                  width: 200,
                  child: dropDown
              )
          )
        ]))];
}

List<Widget> addDateField(String title, ValueGetter<DateTime> getDate, ValueSetter<DateTime> setDate, String? oldValue) {
  return [
    const Flexible(
        flex: 5,
        fit: FlexFit.loose,
        child: SizedBox(height: 20,)),
    Flexible(
        flex: 1,
        fit: FlexFit.loose,
        child:
        Row(children: [
          const Flexible(
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
                  constraints: const BoxConstraints(maxHeight: 60),
                  padding: EdgeInsets.zero,
                  width: 250,
                  child: DateTimeFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: lighterGrey,
                      suffixIcon: Icon(Icons.edit_calendar),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    onDateSelected: (DateTime value) {
                      print("Hello");
                      setDate(value);
                    },
                    dateFormat: DateFormat.yMd(),
                    initialValue: ((){
                      return oldValue == null ? getDate() : DateTime.parse(oldValue);
                    }()),
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


String getNumFromDuration(String duration) {
  return duration.split(' ')[0];
}

String getTimeFromDuration(String duration) {
  return duration.split(' ')[1];
}