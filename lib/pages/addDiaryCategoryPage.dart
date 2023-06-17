import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient_mobile_app/pages/diaryCategoryPage.dart';
import 'package:patient_mobile_app/pages/diaryPage.dart';

import 'package:patient_mobile_app/resources/colours.dart';
import 'package:patient_mobile_app/resources/components.dart';
import 'package:patient_mobile_app/resources/globals.dart';


class AddDiaryCategoryPage extends StatelessWidget {
  const AddDiaryCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          homeIcon,
          const ProfileLogo(),
          Positioned(
            top: 100,
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Column(
                  children: [
                    BackButtonWrapper(),
                    SizedBox(height: 15),
                    AddDiaryCategoryTitle(),
                    CategoryInputs(),
                  ],
                ),
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
class AddDiaryCategoryTitle extends StatelessWidget {
  const AddDiaryCategoryTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Add Diary Category',
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
class CategoryInputs extends StatefulWidget {
  const CategoryInputs({super.key});

  @override
  State<StatefulWidget> createState() => _CategoryInputsState();
}

class _CategoryInputsState extends State<CategoryInputs> {
  final inputController = TextEditingController();

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
            // Container(height: 30, width: 100,),
            DiaryContentTextField(inputController: inputController,),
            LongButton(word: 'Submit category', onPress: () {
              submitNewDiaryCategory(inputController.text);
              Navigator.pop(context);
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
            hintText: "Enter Category",
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: medCyan)
            )
        ),
      ),
    );
  }
}