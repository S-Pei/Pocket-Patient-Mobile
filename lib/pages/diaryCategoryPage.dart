import 'package:flutter/material.dart';
import 'package:patient_mobile_app/resources/objects.dart';
import '../resources/colours.dart';
import '../resources/components.dart';
import '../resources/fonts.dart';
import '../resources/globals.dart';
import 'addDiaryCategoryPage.dart';

class CategoryNotifier extends ValueNotifier<bool> {
  CategoryNotifier(bool state) : super(state);

  void updateCategory(bool changeState) {
    print("updates diary");
    value = changeState;
  }
}

class DiaryCategoryPage extends StatelessWidget {
  const DiaryCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: categoryUpdate,
        builder: (context, value, child) {
          return Scaffold(
            body: Stack(
              children: [
                Center(
                    child: Container(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Column(children: [
                          const Flexible(
                              flex: 5,
                              fit: FlexFit.tight,
                              child: SizedBox(
                                height: 90,
                              )),
                          Flexible(
                              flex: 7,
                              fit: FlexFit.tight,
                              child: Container(
                                  height: 120,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          flex: 8,
                                          child: BackButtonBlue()
                                        ),
                                        const SizedBox(height: 12,),
                                        const DiaryCategoryTitle(),
                                        const SizedBox(height: 10,),
                                        const Flexible(
                                            flex: 3,
                                            fit: FlexFit.loose,
                                            child: SizedBox(
                                              height: 15,
                                            )),
                                        Flexible(
                                            flex: 5,
                                            child: Row(children: [
                                              Flexible(
                                                  fit: FlexFit.tight,
                                                  flex: 11,
                                                  child: Container(
                                                      width: 50,
                                                      child: DefaultTextStyle(child: Text('Categories'), style: boldContent, softWrap: true,))),
                                            ])
                                        ),
                                      ]))
                          ),
                          Flexible(
                              flex: 15,
                              child: SingleChildScrollView(
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:
                                      showDiaryCategory(
                                          patientData!.diaryClass.keys.toList(), context)))
                          ),
                          const Flexible(
                              flex: 1,
                              fit: FlexFit.loose,
                              child: SizedBox(
                                height: 20,
                              )),
                          Flexible(
                              flex: 3,
                              child: NavigateLongButton(word: 'Add Diary Category', nextPage: AddDiaryCategoryPage())
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
            DefaultTextStyle(style: smallInfo, child: Text('Last Updated: 20/6/2023')),
          ],
        ));
  }
}

class BackButtonWrapper extends StatelessWidget {
  const BackButtonWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          // padding: const EdgeInsets.only(left: 20),
          child: const BackButtonBlue(),
        ),
      ],
    );
  }
}
