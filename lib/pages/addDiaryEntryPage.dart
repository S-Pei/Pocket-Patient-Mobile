import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient_mobile_app/pages/diaryPage.dart';

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
            top: 100,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Column(
                children: [
                  BackButtonWrapper(),
                  SizedBox(height: 15),
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

class BackButtonWrapper extends StatelessWidget {
  const BackButtonWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: const BackButtonBlue(),
        ),
      ],
    );
  }

}

// ADD ENTRY TITLE
class AddDiaryEntryTitle extends StatelessWidget {
  const AddDiaryEntryTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
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
              DiaryDateField(
                width: 200.0,
                height: 50.0,
                getDateFunc: getSelectedDate,
                updateDateFunc: updateSelectedDate,),
              Container(height: 30, width: 100,),
              DiaryContentTextField(inputController: inputController,),
              LongButton(word: 'Submit diary', onPress: () {
                submitNewDiaryEntry(selectedDate, inputController.text);
                patientData!.addNewDiaryEntry(selectedDate, inputController.text);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DiaryPage()),
                );
              }),
            ],
          ),
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