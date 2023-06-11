import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import '../resources/colours.dart';
import '../resources/components.dart';
import '../resources/fonts.dart';
import '../resources/globals.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

import '../resources/objects.dart';

// HOSPITAL VISIT HISTORY PAGE
class HospitalVisitPage extends StatelessWidget {
  const HospitalVisitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> medHis = {'20/4/23': 'Broke a leg, fixed leg zsdfgasdfsdfasfdssdf', '30/4/23': 'died'};
    return Scaffold(
      body: Stack(
        children: [
          TitlePageFormat(
              children: [SizedBox(height: 15,),HealthcareVisitTitle(), SizedBox(height: 30,),] +
                  showHealthcareVisitHistory(patientData!.getHealthcareVisits(), context)
                  ),
          homeIcon,
          const ProfileLogo(),
        ],
      ),
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
            DefaultTextStyle(style: smallInfo, child: Text('Last Updated: 25/4/2023')),
          ],
        ));
  }
}

List<Widget> showHealthcareVisitHistory(Map<String, HealthcareHistoryDataEntry> data, BuildContext context) {
  print('show hospital visit history: ${data}');
  List<Widget> widgets = [];
  widgets.add(
    Row(children: [
      Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: SizedBox(width: 5,)),
      Flexible(
          fit: FlexFit.tight,
          flex: 20,
          child: Container(
              width: 50,
              child: DefaultTextStyle(child: Text('Dates'), style: boldContent, softWrap: true,))),
      Flexible(
          fit: FlexFit.tight,
          flex: 25,
          child: Container(
              width: 250,
              child: DefaultTextStyle(child: Text('Consultant'), style: boldContent, softWrap: true,)
          )),
      Flexible(
          fit: FlexFit.tight,
          flex: 24,
          child: Container(
              width: 250,
              child: DefaultTextStyle(child: Text('Letter'), style: boldContent, softWrap: true,)
          )),
    ]),
  );
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
              flex: 4,
              child: Container(
                  width: 50,
                  // alignment: Alignment.center,
                  child: Column(
                    children: [
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
              flex: 6,
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
              flex: 5,
              child: Container(
                  width: 250,
                  child: DefaultTextStyle(
                    child: data.letterUrl != null ? LetterButton(isHospital: isHospital, letterUrl: data.letterUrl!): Text(''),
                    style: content, softWrap: true,)
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
        textStyle: content,
        backgroundColor: isHospital ? letterButtonBlue : letterButtonPink,
        foregroundColor: Colors.black,
        elevation: 10,
        minimumSize: const Size(100, 20),
      ),
      // onPressed: () {FileDownloader.downloadFile(
      //   url: letterUrl
      // );},
      onPressed: () {
        addTask(letterUrl);
      },
      child: Text(buttonText, textAlign: TextAlign.center,),
    );
  }
}

void addTask(String url) async {
  // Get File path to download
  List<String> splitted = url.split('/');
  String path = splitted.last;
  Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
  String appDocumentsPath = appDocumentsDirectory.path;
  String filePath = appDocumentsPath;

  final taskId = await FlutterDownloader.enqueue(
    url: url,
    headers: {}, // optional: header send with url (auth token etc)
    savedDir: filePath,
    fileName: path,
    showNotification: true, // show download progress in status bar (for Android)
    openFileFromNotification: true, // click on notification to open downloaded file (for Android)
  );
  FlutterDownloader.registerCallback(downloadCallback);
  final tasks = await FlutterDownloader.loadTasks();
  FlutterDownloader.open(taskId: taskId!);
}

void downloadCallback(String id, int status, int progress) {
  final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
  send.send([id, status, progress]);
}
