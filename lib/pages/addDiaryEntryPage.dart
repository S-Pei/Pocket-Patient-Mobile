import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
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
          const AddDiaryEntryTitle(),
          const DiaryDateField(),
          DiaryContentTextField(),
          const DiarySubmitButton(),
        ],
      ),
    );
  }
}

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
          )
        ],
      ),
    );
  }
}

class DiaryDateField extends StatefulWidget {
  const DiaryDateField({super.key});

  @override
  State<StatefulWidget> createState() => _DiaryDateFieldState();
}

class _DiaryDateFieldState extends State<DiaryDateField> {
  DateTime? selectedData;

  @override
  void initState() {
    super.initState();
    selectedData = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 170,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            child: DateTimeField(
                onDateSelected: (DateTime value) {
                  setState(() {
                    selectedData = value;
                  });
                },
                dateFormat: DateFormat.yMd(),
                selectedDate: selectedData
            ),
          ),
        ],
      ),
    );
  }

}

class DiaryContentTextField extends StatelessWidget {
  DiaryContentTextField({super.key});

  final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 250,
        left: 25,
        width: MediaQuery.of(context).size.width - 50,
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

class DiarySubmitButton extends StatelessWidget {
  const DiarySubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height - 100,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LongButton(word: 'Submit diary', onPress: (){}),
        ],
      ),
    );
  }


}