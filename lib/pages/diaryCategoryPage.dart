import 'package:flutter/material.dart';
import '../resources/colours.dart';
import '../resources/components.dart';
import '../resources/fonts.dart';
import '../resources/globals.dart';

// MEDICAL HISTORY PAGE
class DiaryCategoryPage extends StatelessWidget {
  const DiaryCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TitlePageFormat(
              children: [SizedBox(height: 15,),diaryCategoryTitle, SizedBox(height: 30,),] +
                  showDiaryCategory(patientData!.diaryClass.keys.toList(), context)),
          homeIcon,
          const ProfileLogo(),
        ],
      ),
    );
  }
}

class DiaryCategoryTitle extends StatelessWidget {
  const DiaryCategoryTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return ColouredBox(
        height: 70,
        width: MediaQuery.of(context).size.width,
        padding: 10.0,
        colour: superLightCyan,
        radius: 10.0,
        outerPadding: 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextStyle(style: smallTitle, child: Text('My Diary Categories')),
            DefaultTextStyle(style: smallInfo, child: Text('Last Updated: 25/4/2023')),
          ],
        ));
  }
}

