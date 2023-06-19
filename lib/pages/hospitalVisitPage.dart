import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:patient_mobile_app/pages/hospitalVisitDetails.dart';
import '../resources/colours.dart';
import '../resources/components.dart';
import '../resources/fonts.dart';
import '../resources/globals.dart';

import '../resources/objects.dart';
import 'addHospitalVisit.dart';

class HospitalVisitNotifier extends ValueNotifier<List<HealthcareHistoryDataEntry>> {
  HospitalVisitNotifier(List<HealthcareHistoryDataEntry> mh) : super(mh);

  void updateMh(List<HealthcareHistoryDataEntry> mh) {
    print("print mh of update: ");
    print(mh);
    value = mh;
  }
}

class HospitalVisitDetailsNotifier extends ValueNotifier<bool> {
  HospitalVisitDetailsNotifier(updateDets) : super(updateDets);

  void updateMhDet(bool val) {
    print("print mh of update: ");
    value = val;
  }
}

// HOSPITAL VISIT HISTORY PAGE
class HospitalVisitPage extends StatelessWidget {
  const HospitalVisitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> medHis = {
      '20/4/23': 'Broke a leg, fixed leg zsdfgasdfsdfasfdssdf',
      '30/4/23': 'died'
    };
    return ValueListenableBuilder<List<HealthcareHistoryDataEntry>>(
        valueListenable: mhNotifier,
        builder: (context, value, child) {
          return Scaffold(
            body: Stack(
              children: [
            Center(
            child: Container(
            padding: const EdgeInsets.only(left: 28.0, right: 28.0),
              child: Column(children: [
                const Flexible(
                    flex: 4,
                    fit: FlexFit.tight,
                    child: SizedBox(
                      height: 90,
                    )),
                Flexible(
                    flex: 5,
                    fit: FlexFit.loose,
                    child: Container(
                        height: 120,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15,),
                              HealthcareVisitTitle(),
                              SizedBox(height: 15,),
                          Row(children: [
                            Flexible(
                                fit: FlexFit.tight,
                                flex: 1,
                                child: SizedBox(width: 5,)),
                            Flexible(
                                fit: FlexFit.tight,
                                flex: 11,
                                child: Container(
                                    width: 50,
                                    child: DefaultTextStyle(child: Text('Dates'), style: boldContent, softWrap: true,))),
                            Flexible(
                                fit: FlexFit.tight,
                                flex: 22,
                                child: Container(
                                    width: 250,
                                    child: DefaultTextStyle(child: Text('Consultant'), style: boldContent, softWrap: true,)
                                )),
                              ])
                      ]))
                ),
                Flexible(
                    flex: 15,
                    child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                              showHealthcareVisitHistory(
                                patientData!.getHealthcareVisits(), context)))
                ),
                const Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: SizedBox(
                      height: 20,
                    )),
                Flexible(
                  flex: 3,
                  child: NavigateLongButton(word: 'Add Visit Entry', nextPage: AddHospitalVisitPage())
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

class HealthcareVisitTitle extends StatelessWidget {
  const HealthcareVisitTitle({super.key});

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
            DefaultTextStyle(style: smallTitle, child: Text('Healthcare Visit History')),
            DefaultTextStyle(style: smallInfo, child: Text('Last Updated: 20/6/2023')),
          ],
        ));
  }
}

List<Widget> showHealthcareVisitHistory(Map<String, HealthcareHistoryDataEntry> data, BuildContext context) {
  print('show hospital visit history: ${data}');
  List<Widget> widgets = [];

  widgets.add(SizedBox(height: 10,));
  for (var entry in data.entries) {
    widgets.add(HealthcareVisitEntry(data: entry.value, uuid: entry.key));
    widgets.add(SizedBox(height: 10,));
  }
  return widgets;
}

class HealthcareVisitEntry extends StatelessWidget {
  const HealthcareVisitEntry({super.key, required this.data, required this.uuid});
  final HealthcareHistoryDataEntry data;
  final String uuid;

  @override
  Widget build(BuildContext context) {
    bool isHospital = data.visitType == 'Hospital Visit';

    return ColouredBox(
        height: 70,
        width: MediaQuery.of(context).size.width,
        padding: 10.0,
        colour: contentCyan,
        child: Row(
            children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 5,
              child: Container(
                  width: 50,
                  // alignment: Alignment.center,
                  child: Column(
                    children: data.admissionDate == data.dischargeDate ?
                    [DefaultTextStyle(style: content, child: Text(data.admissionDate), softWrap: true,)] :
                    [
                      DefaultTextStyle(child: Text(data.admissionDate), style: content, softWrap: true,),
                      DefaultTextStyle(child: Text('-'), style: content, softWrap: true,),
                      DefaultTextStyle(child: Text(data.dischargeDate), style: content, softWrap: true,),
                    ],
                  )
              )
          ),
          Flexible(flex: 1,
              fit: FlexFit.tight,
              child: SizedBox(width: 10,)),
          Flexible(
              fit: FlexFit.tight,
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(child: Text(data.consultant), style: content, softWrap: true,),
                  DefaultTextStyle(child: Text('St Mary Hospital'), style: content, softWrap: true,),
                ],
              )
          ),
          Flexible(
              fit: FlexFit.tight,
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  data.letterUrl != null ? LetterButton(isHospital: isHospital, letterUrl: data.letterUrl!): Text(''),
                  MoreInfoButton(data: data)
                ]
              ))]),
        radius: 0,
        outerPadding: 0);
  }

}

// LETTER BUTTON
class LetterButton extends StatelessWidget {
  const LetterButton({super.key, required this.isHospital, required this.letterUrl});
  final bool isHospital;
  final String letterUrl;

  @override
  Widget build(BuildContext context) {
    String buttonText = isHospital ? 'Discharge Letter' : 'GP Letter';
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: EdgeInsets.all(3),
        textStyle: boldContent,
        backgroundColor: isHospital ? letterButtonBlue : letterButtonPink,
        foregroundColor: Colors.black,
        elevation: 10,
        minimumSize: const Size(100, 20),
      ),
      onPressed: () {
        download(letterUrl);
      },
      child: Text(buttonText, textAlign: TextAlign.center,),
    );
  }
}

class MoreInfoButton extends StatelessWidget {
  const MoreInfoButton({super.key, required this.data});
  final HealthcareHistoryDataEntry data;

  @override
  Widget build(BuildContext context) {
    Widget detailsPage = HospitalVisitDetailsPage(id: data.id,);
    if (idToHospVisitDet[data.id] == null) {
      idToHospVisitDet[data.id] = detailsPage;
    } else {
      detailsPage = idToHospVisitDet[data.id]!;
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: EdgeInsets.all(3),
        textStyle: boldContent,
        backgroundColor: lightGrey,
        foregroundColor: Colors.black,
        elevation: 10,
        minimumSize: const Size(100, 20),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              detailsPage),
        );
      },
      child: Text('More Info', textAlign: TextAlign.center,),
    );
  }

}


