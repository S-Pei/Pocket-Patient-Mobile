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
                              flex: 4,
                              fit: FlexFit.tight,
                              child: SizedBox(
                                height: 90,
                              )),
                          Flexible(
                              flex: 5,
                              fit: FlexFit.tight,
                              child: Container(
                                  height: 120,
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 15,),
                                        DiaryCategoryTitle(),
                                        Flexible(
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
                                              Flexible(
                                                  fit: FlexFit.tight,
                                                  flex: 10,
                                                  child: Container(
                                                      width: 50,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(5.0),
                                                          ),
                                                          padding: EdgeInsets.all(3),
                                                          textStyle: boldContent,
                                                          backgroundColor: mainCyan,
                                                          foregroundColor: Colors.black,
                                                          elevation: 10,
                                                          minimumSize: const Size(100, 20),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text(
                                                          'Back',
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ))
                                              )
                                            ])
                                        ),
                                        const Flexible(
                                            flex: 1,
                                            fit: FlexFit.tight,
                                            child: SizedBox(
                                              height: 20,
                                            )),
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
                const ProfileLogo(),
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
            DefaultTextStyle(style: smallInfo, child: Text('Last Updated: 25/4/2023')),
          ],
        ));
  }
}

