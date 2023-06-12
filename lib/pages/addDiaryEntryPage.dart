import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:patient_mobile_app/resources/colours.dart';
import 'package:patient_mobile_app/resources/components.dart';
import 'package:patient_mobile_app/resources/globals.dart';


class AddDiaryEntryPage extends StatelessWidget {
  const AddDiaryEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          homeIcon,
          const ProfileLogo(),
          Positioned(
            top: 120,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Column(
                children: [
                  AddDiaryEntryTitle(),
                  DiaryInputs(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// ADD ENTRY TITLE
class AddDiaryEntryTitle extends StatelessWidget {
  const AddDiaryEntryTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 120,
      width: MediaQuery.of(context).size.width,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Add Diary Entry',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}


// WRAPPER FOR BOTH DATE AND CONTENT FIELD
class DiaryInputs extends StatefulWidget {
  const DiaryInputs({super.key});

  @override
  State<StatefulWidget> createState() => _DiaryInputsState();
}

class _DiaryInputsState extends State<DiaryInputs> {
  DateTime selectedDate = DateTime.now();

  final inputController = TextEditingController();

  void updateSelectedDate(DateTime newDate) {
    selectedDate = newDate;
  }

  DateTime getSelectedDate() {
    return selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          padding: const EdgeInsets.only(
            left: 25,
            right: 25
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DiaryDateField(getDateFunc: getSelectedDate, updateDateFunc: updateSelectedDate,),
              Container(height: 30, width: 100,),
              DiaryContentTextField(inputController: inputController,),
              LongButton(word: 'Submit diary', onPress: (){
                submitNewDiaryEntry(selectedDate, inputController.text);
              }),
            ],
          ),
        ),
    );
  }
}


// DATE FIELD
class DiaryDateField extends StatefulWidget {
  const DiaryDateField({super.key, required this.getDateFunc, required this.updateDateFunc});

  final ValueGetter<DateTime> getDateFunc;
  final ValueSetter<DateTime> updateDateFunc;

  @override
  State<StatefulWidget> createState() => _DiaryDateFieldState(getDateFunc: getDateFunc, updateDateFunc: updateDateFunc);
}

class _DiaryDateFieldState extends State<DiaryDateField> {
  _DiaryDateFieldState({required this.getDateFunc, required this.updateDateFunc});
  DateTime selectedData = DateTime.now();

  final ValueGetter<DateTime> getDateFunc;
  final ValueSetter<DateTime> updateDateFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 50,
        child: DateTimeField(
            onDateSelected: (DateTime value) {
              updateDateFunc(value);
              setState(() {
                selectedData = value;
              });
            },
            dateFormat: DateFormat.yMd(),
            selectedDate: getDateFunc()
        ),
      );
  }
}


// CONTENT FIELD
class DiaryContentTextField extends StatelessWidget {
  const DiaryContentTextField({super.key, required this.inputController});

  final TextEditingController inputController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 400,
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: inputController,
        decoration: const InputDecoration(
            hintText: "Enter diary",
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: medCyan)
            )
        ),
      ),
    );
  }
}

// class DiarySubmitButton extends StatelessWidget {
//   const DiarySubmitButton({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       top: MediaQuery.of(context).size.height - 100,
//       width: MediaQuery.of(context).size.width,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//
//         ],
//       ),
//     );
//   }
// }