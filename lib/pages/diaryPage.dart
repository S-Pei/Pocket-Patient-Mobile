import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_mobile_app/pages/addDiaryEntryPage.dart';
import 'package:patient_mobile_app/resources/colours.dart';
import 'package:patient_mobile_app/resources/components.dart';
import 'package:patient_mobile_app/resources/fonts.dart';
import 'package:patient_mobile_app/resources/globals.dart';

import '../resources/objects.dart';

class DiaryNotifier extends ValueNotifier<bool> {
  DiaryNotifier(bool state) : super(state);

  void updateDiary(bool changeState) {
    print("updates diary");
    value = changeState;
  }
}

class DiaryPage extends StatelessWidget {
  final String category;
  const DiaryPage(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    List<DiaryEntry>? entries = patientData?.getDiaryEntries(category);
    return ValueListenableBuilder<bool>(
        valueListenable: diaryUpdate,
        builder: (context, value, child) {
          return Scaffold(
            body: Stack(
              children: [
                Center(
                    child: Container(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Column(children: [
                          const Flexible(
                              flex: 4,
                              fit: FlexFit.tight,
                              child: SizedBox(
                                height: 90,
                              )),
                          const Flexible(
                              flex: 5,
                              fit: FlexFit.tight,
                              child: SizedBox(
                                  height: 100,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        BackButtonBlue(),
                                        SizedBox(height: 5,),
                                        DiaryPageTitle(),
                                        Flexible(
                                            flex: 1,
                                            fit: FlexFit.loose,
                                            child: SizedBox(
                                              height: 20,
                                            )),
                                      ]))
                          ),
                          Flexible(
                              flex: 18,
                              child: SingleChildScrollView(
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:
                                      showDiaryList(
                                          entries, context)))
                          ),
                          const Flexible(
                              flex: 1,
                              fit: FlexFit.loose,
                              child: SizedBox(
                                height: 20,
                              )),
                          Flexible(
                              flex: 3,
                              child: NavigateLongButton(word: 'Add Diary Entry', nextPage: AddDiaryEntryPage(category))
                          )
                        ]))),
                homeIcon,
              ],
            ),
          );
        }
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
  final String category;
  const AddDiaryEntryButton(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height - 100,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: const EdgeInsets.only(
            left: 25,
            right: 25
        ),
        child: LongButton(word: 'Add Diary Entry', onPress: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDiaryEntryPage(category)),
          );
        }),
      ),
    );
  }
}