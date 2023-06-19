import 'dart:convert';
import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:patient_mobile_app/pages/addHospitalVisit.dart';
import 'package:patient_mobile_app/pages/diaryPage.dart';
import 'package:patient_mobile_app/pages/hospitalVisitDetails.dart';
import 'package:patient_mobile_app/pages/medInsAccPage.dart';
import '../resources/colours.dart';
import '../resources/globals.dart';
import '../resources/fonts.dart';
import '../resources/objects.dart';
import 'authenticationOverlay.dart';
import '../resources/components.dart';
import '../resources/navBar.dart';

// HOME PAGE
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String message = 'No message received';

  @override
  void initState() {
    super.initState();
    askRequiredPermission();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) => {
          if (!isAllowed)
            {AwesomeNotifications().requestPermissionToSendNotifications()}
        });
    print('toHide: ${toHide}');
    if (firstRender == true) {
      initWebsocket(context, (data) {
        print('Received: ${data}');
        final map = jsonDecode(data);
        if (map['event'] == 'REQUEST_PATIENT_DATA_ACCESS') {
          sendAuthNotif();
          setState(() {
            overlay.showOverlay(context, const OverlayWidget());
          });
        } else if (map['event'] == 'CHANGE-IN-MEDICATION' ||
                    map['event'] == 'NEW_MEDICATION_ENTRY' ||
                    map['event'] == 'REMOVE_MEDICATION_ENTRY' ||
                    map['event'] == 'EDIT_MEDICATION_ENTRY') {
          print("in the event of " + map['event']);
          patientData?.setNewMedication(map['currentMedication']);
          medicationNotifier.updateMedication(patientData!.medication);
        } else if (map['event'] == 'NEW_HOSP_VISIT_ENTRY') {
          if (!map["new_lab_history"].isEmpty) { patientData?.addNewLabHistory(map['new_lab_history']); }
          if (!map["new_imaging_history"].isEmpty) { patientData?.addNewImagingHistory(map['new_imaging_history']); }
          patientData?.setNewMedicalHistory(map['hospital_visit_history']);
          mhNotifier.updateMh(patientData!.medical_history);
        } else if (map['event'] == 'NEW_DIARY_CLASS') {
          patientData!.addNewDiaryCategory(map['category']);
          categoryUpdate.updateCategory(patientData!.changeCategoryState());
        } else if (map['event'] == 'EDIT_HOSP_VISIT_ENTRY') {
          print('map: $map');
          if (!map["new_lab_history"].isEmpty) { patientData?.addNewLabHistory(map['new_lab_history']); }
          if (!map["new_imaging_history"].isEmpty) { patientData?.addNewImagingHistory(map['new_imaging_history']); }
          patientData?.setNewMedicalHistory(map['hospital_visit_history']);
          mhNotifier.updateMh(patientData!.medical_history);
          idToHospVisitDet[map['mhId']] = HospitalVisitDetailsPage(id: map['mhId'],);
          hospVisitDetsNotifier.updateMhDet(!updateDets);
          updateDets = !updateDets;
        }
      });
      firstRender = false;
    }
    Timer refreshTimer = refreshTokenTimer;
  }

  @override
  Widget build(BuildContext context) {
    print(patientData);
    return Scaffold(
      body: Stack(
        children: [
          TitlePageFormat(children: [
            MainPageTitle(),
            SizedBox(
              height: 50,
            ),
            NavigateLongButton(
                word: 'My Medications', nextPage: InfoPage(selectedIndex: 0)),
            SizedBox(
              height: 50,
            ),
            NavigateLongButton(
                word: 'My Medical History',
                nextPage: InfoPage(selectedIndex: 1)),
            SizedBox(
              height: 50,
            ),
            NavigateLongButton(
                word: 'Healthcare Visit History',
                nextPage: InfoPage(selectedIndex: 2)),
            SizedBox(
              height: 50,
            ),
            NavigateLongButton(
                word: 'Data Access Control', nextPage: MedAccInsPage()),
            SizedBox(
              height: 50,
            ),
            NavigateLongButton(word: 'My Diary', nextPage: InfoPage(selectedIndex: 3,)),
            SizedBox(
              height: 50,
            ),
          ]),
          homeIcon,
        ],
      ),
    );
  }
}

// MAIN PAGE TITLE
class MainPageTitle extends StatelessWidget {
  MainPageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return ColouredBox(
      height: 180,
      width: MediaQuery.of(context).size.width,
      padding: 15.0,
      colour: superLightCyan,
      radius: 10.0,
      outerPadding: 0.0,
      child: FutureBuilder<Patient>(
        future: fetchData('$autoUrl/api/patient-data/').then((value) =>
            patientData =
                value), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<Patient> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            String patientName =
                '${patientData?.first_name} ${patientData?.last_name}';
            String dob = '${patientData?.dob}';
            String address = '${patientData?.patient_address}';
            String id = '${patientData?.patient_id}';
            children = <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DefaultTextStyle(
                      style: smallTitle,
                      child:
                          Text(patientName, style: smallTitle, softWrap: true)),
                  DefaultTextStyle(
                      style: smallInfo,
                      child:
                          InfoFormat(title: 'NHS Number', info: id),
                      softWrap: true),
                  DefaultTextStyle(
                      style: smallInfo,
                      child: InfoFormat(title: 'D.O.B', info: dob),
                      softWrap: true),
                  DefaultTextStyle(
                      style: smallInfo,
                      child: InfoFormat(title: 'Address', info: address),
                      softWrap: true),
                  // DefaultTextStyle(style: smallInfo, child: InfoFormat(title: 'Contact', info: '7435 123128'), softWrap: true),
                  // DefaultTextStyle(style: smallInfo, child: InfoFormat(title: 'Emergency Contact', info: '7786 112345'), softWrap: true),
                ],
              ),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}

// HOSPITALS WITH ACCESS
class MedInsAcc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          textStyle: contentButton,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MedAccInsPage()),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.only(right: 40, left: 40),
          child: const Text(
            'Manage Medical Institutions with access to your data',
            softWrap: true,
          ),
        ));
  }
}
