import 'package:flutter/material.dart';
import 'package:patient_mobile_app/pages/editHospVisit.dart';
import 'package:patient_mobile_app/resources/globals.dart';
import '../resources/colours.dart';
import '../resources/fonts.dart';
import '../resources/components.dart';
import '../resources/objects.dart';

class HospitalVisitDetailsPage extends StatelessWidget {
  const HospitalVisitDetailsPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: hospVisitDetsNotifier,
        builder: (context, value, child) {
          HealthcareHistoryDataEntry data = patientData!.getHealthcareVisits()[id]!;
          return Scaffold(
            body: Stack(
              children: [
                TitlePageFormat(
                    children: [BackButtonBlue(), SizedBox(height: 15,),
                      HospitalVisitDetailsTitle(data: data,),
                      SizedBox(height: 20,),
                      HospitalVisitInfo(data: data),
                      SizedBox(height: 30,),
                      NavigateLongButton(word: 'Edit Entry',
                          nextPage: EditHospitalVisitPage(data: data)),
                      SizedBox(height: 20,)
                    ]
                ),
                homeIcon,
              ],
            ),
          );
        }
    );
  }
}

class HospitalVisitDetailsTitle extends StatelessWidget {
  const HospitalVisitDetailsTitle({super.key, required this.data});
  final HealthcareHistoryDataEntry data;

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
            const DefaultTextStyle(style: smallTitle, child: Text('St Mary Hospital')),
            DefaultTextStyle(style: smallInfo, child: Text('Last Updated: 20/6/2023 by ${data.consultant}')),
          ],
        ));
  }
}

class HospitalVisitInfo extends StatelessWidget {

  const HospitalVisitInfo({super.key, required this.data});

  final HealthcareHistoryDataEntry data;

  @override
  Widget build(BuildContext context) {
    String letter = data.letterUrl == null ? '' : data.letterUrl!;
    String lab = data.labUrl;
    String imaging = data.imagingUrl;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children:
        generateVisitDetail('Date of Admission', data.admissionDate) +
        generateVisitDetail('Date Discharged', data.dischargeDate) +
        generateVisitDetail('Discharge Summary', data.summary) +
        generateVisitDetail('Consultant', data.consultant) +
        generateVisitDetail('Type of Visit', data.visitType) +
        getUrlInfo('Discharge Letter', letter) +
        getUrlInfo('Lab Report', lab) +
        getUrlInfo('Imaging Report', imaging) +
        addToMedHist(data.addToMedicalHistory)
      ,
    );
  }

}

class VisitDetails extends StatelessWidget {
  const VisitDetails({super.key, required this.title, required this.info});

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: SizedBox(width: 5,)),
      Flexible(
          fit: FlexFit.tight,
          flex: 10,
          child: Container(
              width: 50,
              child: DefaultTextStyle(child: Text('$title:'), style: boldContent, softWrap: true,))),
      Flexible(
          fit: FlexFit.tight,
          flex:11,
          child: Container(
              width: 250,
              child: DefaultTextStyle(child: Text(info), style: content, softWrap: true,)
          )),
    ]);
  }
}

List<Widget> generateVisitDetail(String title, String info) {
  return [
    Flexible(
        flex: 5,
        fit: FlexFit.loose,
        child: SizedBox(height: 20,)),
    Flexible(
        flex: 1,
        fit: FlexFit.loose,
        child: DefaultTextStyle(style: smallInfo,
          child: VisitDetails(title: title, info: info), softWrap: true)),
  ];
}

List<Widget> addToMedHist(bool added) {
  return [
    Flexible(
        flex: 5,
        fit: FlexFit.loose,
        child: SizedBox(height: 20,)),
    Flexible(
        flex: 1,
        fit: FlexFit.loose,
        child:
      Row(children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: SizedBox(width: 5,)),
          Flexible(
            fit: FlexFit.loose,
            flex: 15,
            child: Container(
            width: 250,
            child: DefaultTextStyle(child: Text('Added to my medical history:'), style: boldContent, softWrap: true,))),
          Flexible(
            fit: FlexFit.loose,
            flex:9,
            child: Container(
            width: 20,
            child: added ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank)
          ))])
  )];
}

List<Widget> getUrlInfo(String title, String url) {
  List<String> splitted = url.split('/');
  String path = splitted.last;
  return [
    Flexible(
        flex: 5,
        fit: FlexFit.loose,
        child: SizedBox(height: 20,)),
    Flexible(
      flex: 1,
      fit: FlexFit.loose,
      child:
      Row(children: [
        Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: SizedBox(width: 5,)),
        Flexible(
            fit: FlexFit.tight,
            flex: 10,
            child: Container(
                width: 50,
                child: DefaultTextStyle(child: Text('$title:'), style: boldContent, softWrap: true,))),
        Flexible(
            fit: FlexFit.tight,
            flex:11,
            child: Container(
                width: 250,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                      textStyle: smallInfoLink,
                  ),
                  onPressed: () {
                    download(url);
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(path, softWrap: true, textAlign: TextAlign.left,),
                  )
                ),
            )),
  ]))];
}