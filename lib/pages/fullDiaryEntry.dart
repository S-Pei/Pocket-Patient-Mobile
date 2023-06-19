import 'package:flutter/material.dart';
import 'package:patient_mobile_app/resources/globals.dart';
import '../resources/colours.dart';
import '../resources/fonts.dart';
import '../resources/components.dart';
import '../resources/objects.dart';

class FullDiaryPage extends StatelessWidget {
  final DiaryEntry entry;
  const FullDiaryPage(this.entry, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TitlePageFormat(
              children: [BackButtonBlue(), SizedBox(height: 15,),
                FullDiaryTitle(entry.date),
                SizedBox(height: 30,),
                Container(
                  color: superLightCyan,
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.6,
                    minWidth: MediaQuery.of(context).size.width * 0.9,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 25.0, // Padding value for top and bottom
                    horizontal: 20.0, // Padding value for left and right
                  ),
                  child: Text(entry.content, style: TextStyle(fontSize: 20),)
                ),
                SizedBox(height: 15,),
              ]
          ),
          homeIcon,
        ],
      ),
    );
  }

}

class FullDiaryTitle extends StatelessWidget {
  final String date;
  const FullDiaryTitle(this.date, {super.key});

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DefaultTextStyle(style: smallTitle, child: Text(date)),
            DefaultTextStyle(style: smallInfo, child: Text('Last Updated: 25/4/2023')),
          ],
        ));
  }
}