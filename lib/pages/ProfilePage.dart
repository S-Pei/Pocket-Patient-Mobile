import 'package:flutter/material.dart';
import 'package:patient_mobile_app/pages/PersonalInfoSubPage.dart';
import '../resources/globals.dart';
import '../resources/fonts.dart';
import '../resources/components.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    String patientName = '${patientData?.first_name} ${patientData?.last_name}';
    String dob = '${patientData?.dob}';
    String address = '${patientData?.patient_address}';
    return Scaffold(
      body: Stack(
        children: [
          Center(
              child: Container(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(children: [
                    Flexible(flex: 2,
                    fit: FlexFit.loose,
                    child: SizedBox(
                      height: 110,
                    )),
                    Flexible(flex: 8, child: SingleChildScrollView(  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleColouredBox(widgets: [Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DefaultTextStyle(style: smallTitle, child: Text(patientName, style: smallTitle, softWrap: true)),
                            DefaultTextStyle(style: smallInfo, child: InfoFormat(title: 'NHS Number', info: '123 456 7890'), softWrap: true),
                            DefaultTextStyle(style: smallInfo, child: InfoFormat(title: 'D.O.B', info: dob), softWrap: true),
                            DefaultTextStyle(style: smallInfo, child: InfoFormat(title: 'Address', info: address), softWrap: true),
                            DefaultTextStyle(style: smallInfo, child: InfoFormat(title: 'Contact', info: '7435 123128'), softWrap: true),
                            DefaultTextStyle(style: smallInfo, child: InfoFormat(title: 'Emergency Contact', info: '7786 112345'), softWrap: true),
                            DefaultTextStyle(style: smallInfo, child: InfoFormat(title: 'Blood Type', info: 'A+'), softWrap: true),
                            DefaultTextStyle(style: smallInfo, child: InfoFormat(title: 'Weight', info: '95kg'), softWrap: true),
                            DefaultTextStyle(style: smallInfo, child: InfoFormat(title: 'Height', info: '170cm'), softWrap: true),
                            DefaultTextStyle(style: smallInfo, child: InfoFormat(title: 'BMI', info: '32.87'), softWrap: true),
                          ],
                        ),
                        ),], height: 320),
                        SizedBox(height: 20,),
                        rowOfTwoButtons('Drugs and Allergies', 'Vaccinations',
                            const PersonalInfoSubPage(), const PersonalInfoSubPage()),
                        SizedBox(height: 20,),
                        rowOfTwoButtons('Treatment Escalation Plans', 'Power of Attorney',
                            const PersonalInfoSubPage(), const PersonalInfoSubPage()),
                        SizedBox(height: 20,),
                        rowOfTwoButtons('Advanced Care Plan', 'Organ Donation',
                            const PersonalInfoSubPage(), const PersonalInfoSubPage()),
                        SizedBox(height: 20,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 5,
                                child: NavigateShortButton(
                                    word: 'Social History',
                                    nextPage: const PersonalInfoSubPage()
                                ),),
                              Flexible(flex: 1,child: SizedBox(width: 10,)),
                              Flexible(
                                flex: 5,
                                child: SizedBox(width: 170,))
                            ])
                        ])))]))),
          homeIcon,
        ],
      ),
    );
  }

  Widget rowOfTwoButtons(String word1, String word2, Widget page1, Widget page2) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 5,
            child: NavigateShortButton(
              word: word1,
              nextPage: page1
          ),),
          Flexible(flex: 1,child: SizedBox(width: 10,)),
          Flexible(
            flex: 5,
            child: NavigateShortButton(
              word: word2,
              nextPage: page2
          ),),
        ]);
  }

}