import 'dart:convert';
import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:patient_mobile_app/pages/diaryPage.dart';
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
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications()
      }
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
        }
        else if (map['event'] == 'CHANGE-IN-MEDICATION') {
          patientData?.setNewMedication(map['currentMedication']);
          medicationNotifier.updateMedication(patientData!.medication);
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
          TitlePageFormat(children: [MainPageTitle(),
                        const SizedBox(
                          height: 50,
                        ),
                        const NavigateLongButton(
                            word: 'My Medications',
                            nextPage: InfoPage(selectedIndex: 0)),
                        const SizedBox(
                          height: 40,
                        ),
                        const NavigateLongButton(
                            word: 'My Medical History',
                            nextPage: InfoPage(selectedIndex: 1)),
                        const SizedBox(
                          height: 40,
                        ),
                        const NavigateLongButton(
                            word: 'Hospital Visit History',
                            nextPage: InfoPage(selectedIndex: 2)),
                        const SizedBox(height: 40,),
                        NavigateLongButton(
                            word: 'Data Access Control',
                            nextPage: MedAccInsPage()),
                        const SizedBox(height: 40,),
                        const NavigateLongButton(
                            word: 'Diary',
                            nextPage: DiaryPage()),
                        ]),
          homeIcon,
          const ProfileLogo(),
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
          future: fetchData('$autoUrl/api/patient-data/').then((value) => patientData = value), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<Patient> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              String patientName = '${patientData?.first_name} ${patientData?.last_name}';
              String dob = '${patientData?.dob}';
              String address = '${patientData?.patient_address}';
              children = <Widget>[Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DefaultTextStyle(style: smallTitle, child: Text(patientName, style: smallTitle, softWrap: true)),
                    DefaultTextStyle(style: smallInfo, child: InfoFormat(title: 'NHS Number', info: '123 456 7890'), softWrap: true),
                    DefaultTextStyle(style: smallInfo, child: InfoFormat(title: 'D.O.B', info: dob), softWrap: true),
                    DefaultTextStyle(style: smallInfo, child: InfoFormat(title: 'Address', info: address), softWrap: true),
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
        onPressed: () {Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MedAccInsPage()),
        );},
        child: Container(
          width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.only(right: 40, left: 40),
          child: const Text('Manage Medical Institutions with access to your data', softWrap: true,),
        )
      );
  }

}

