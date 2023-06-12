import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_mobile_app/resources/colours.dart';
import 'package:patient_mobile_app/resources/components.dart';
import 'package:patient_mobile_app/resources/fonts.dart';
import 'package:patient_mobile_app/resources/globals.dart';

class DiaryPage extends StatelessWidget {
  const DiaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TitlePageFormat(
              children: [
                const SizedBox(height: 15,),
                diaryPageTitle,
                const SizedBox(height: 30,),
              ] + showDiaryList(patientData!.getDiarySummary(), context)),
          homeIcon,
          const ProfileLogo(),
          const AddDiaryEntryButton(),
        ],
      ),
    );
  }
}

class DiaryPageTitle extends StatelessWidget {
  const DiaryPageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return ColouredBox(
        height: 70,
        width: MediaQuery.of(context).size.width,
        padding: 10.0,
        colour: superLightCyan,
        radius: 10.0,
        outerPadding: 0.0,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextStyle(style: smallTitle, child: Text('My Diary')),
            DefaultTextStyle(style: smallInfo, child: Text('Last Updated: 25/4/2023')),
          ],
        ));
  }
}

class AddDiaryEntryButton extends StatelessWidget {
  const AddDiaryEntryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height - 100,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LongButton(word: 'add diary entry', onPress: (){}),
        ],
      ),
    );
  }


}