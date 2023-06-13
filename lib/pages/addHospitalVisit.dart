import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patient_mobile_app/resources/globals.dart';
import '../resources/colours.dart';
import '../resources/fonts.dart';
import '../resources/components.dart';
import '../resources/objects.dart';

class AddHospitalVisitPage extends StatefulWidget {
  const AddHospitalVisitPage({super.key});

  @override
  State<StatefulWidget> createState() => _AddHospitalVisitPageState();

}
class _AddHospitalVisitPageState extends State<AddHospitalVisitPage> {
  bool addToMh = true;
  String dropdownValue = 'GP Consultation';
  DateTime admissionDate = DateTime.now();
  DateTime dischargeDate = DateTime.now();

  void updateAdmissionDate(DateTime newDate) {
    admissionDate = newDate;
  }

  void updateDischargeDate(DateTime newDate) {
    dischargeDate = newDate;
  }

  DateTime getAdmissionDate() {
    return admissionDate;
  }

  DateTime getDischargeDate() {
    return dischargeDate;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController summaryController = TextEditingController();
    TextEditingController consultantController = TextEditingController();
    Widget checkBox = Checkbox(
      value: addToMh,
      onChanged: (bool? value) {
        setState(() {
          addToMh = value!;
        });
      },
    );
    Widget dropDown = DropdownButton<String>(
        focusColor: lighterGrey,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        value: dropdownValue,
        isExpanded: true,
        items: [
          DropdownMenuItem(
            value: 'GP Consultation',
            child: Text('GP Consultation')),
          DropdownMenuItem(
              value: 'Hospital Visit',
              child: Text('Hospital Visit'))
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
                SizedBox(height: 30,),
                AddHospitalVisitInfo(
                  summaryController: summaryController, consultantController: consultantController, checkBox: checkBox,
                  dropDown: dropDown, setDates: [updateAdmissionDate, updateDischargeDate],
                  getDates: [getAdmissionDate, getDischargeDate],
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

class AddHospitalVisitInfo extends StatelessWidget {

  const AddHospitalVisitInfo({super.key, required this.summaryController, required this.consultantController, required this.checkBox, required this.dropDown, required this.getDates, required this.setDates});
  final TextEditingController summaryController;
  final TextEditingController consultantController;
  final Widget checkBox;
  final Widget dropDown;
  final List<ValueGetter<DateTime>> getDates;
  final List<ValueSetter<DateTime>> setDates;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children:
        addDateField('Date of Admission', getDates[0], setDates[0]) +
        addDateField('Date Dischar ged', getDates[1], setDates[1]) +
        addVisitText('Discharge Summary', summaryController, 'Summary') +
        addVisitText('Consultant', consultantController, 'Consultant') +
        addDropDown(dropDown) +
        addToMedHistCheck(checkBox)
        // generateVisitDetail('Type of Visit', data.visitType) +
        // getUrlInfo('Discharge Letter', letter) +
      ,
    );
  }

}

class AddVisitDetailsText extends StatelessWidget {
  const AddVisitDetailsText({super.key, required this.title,  required this.controller, required this.hint});

  final String title;
  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
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
              child: DefaultTextStyle(child: Text('$title:'), style: boldContent, softWrap: true,))),
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

List<Widget> addVisitText(String title, TextEditingController controller, String hint) {
  return [
    Flexible(
        flex: 5,
        fit: FlexFit.loose,
        child: SizedBox(height: 20,)),
    Flexible(
        flex: 1,
        fit: FlexFit.loose,
        child: DefaultTextStyle(style: smallInfo,
            child: AddVisitDetailsText(title: title, controller: controller, hint: hint,), softWrap: true)),
  ];
}

List<Widget> addToMedHistCheck(Widget checkBox) {
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
              flex: 15,
              child: Container(
                  width: 250,
                  child: DefaultTextStyle(child: Text('Added to my medical history:'), style: boldContent, softWrap: true,))),
          Flexible(
              fit: FlexFit.loose,
              flex:9,
              child: Container(
                  width: 20,
                  child: checkBox
              )
          )
    ]))];
}

List<Widget> addDropDown(Widget dropDown) {
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
                  child: DefaultTextStyle(child: Text('Type of Visit:'), style: boldContent, softWrap: true,))),
          Flexible(
              fit: FlexFit.loose,
              flex:15,
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
                  width: 250,
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
                  child: DefaultTextStyle(child: Text('$title:'), style: boldContent, softWrap: true,))),
          Flexible(
              fit: FlexFit.loose,
              flex:15,
              child: Container(
                // padding: EdgeInsets.only(left: 38),
                //   decoration: BoxDecoration(
                //     border: Border.all(
                //         width: 1.0
                //     ),
                //     borderRadius: BorderRadius.all(
                //         Radius.circular(10.0) //                 <--- border radius here
                //     ),
                //     color: lighterGrey,
                //   ),
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