import 'dart:convert';

import 'package:flutter/material.dart';
import '../resources/colours.dart';
import '../resources/globals.dart';
import '../resources/fonts.dart';
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
    print('toHide: ${toHide}');
    if (firstRender == true) {
      fetchData('https://patientoncall.herokuapp.com/api/patient-data/')
          .then((val) => {patientData = val});
      channel.stream.listen((data) {
        print('Received: ${data}');
        final map = jsonDecode(data);
        if (map['event'] == 'REQUEST_PATIENT_DATA_ACCESS') {
          setState(() {
            overlay.showOverlay(context, const OverlayWidget());
          });
        }
      });
      firstRender = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
              child: Container(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        Text('Bob Choy', style: title, softWrap: true),
                        InfoFormat(title: 'NHS Number', info: '123 456 7890'),
                        InfoFormat(title: 'D.O.B', info: '29 Feb 1983'),
                        InfoFormat(
                            title: 'Address',
                            info: '12, Smith Road, AB 321 London'),
                        SizedBox(
                          height: 50,
                        ),
                        NavigateLongButton(
                            word: 'My Prescriptions',
                            nextPage: InfoPage(selectedIndex: 0)),
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
                            word: 'Hospital Visit History',
                            nextPage: InfoPage(selectedIndex: 2)),]))),
          const MedInsAccLogo(),
          homeIcon,
        ],
      ),
    );
  }
}

// MAIN PAGE TITLE
class MainPageTitle extends StatelessWidget {
  const MainPageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return ColouredBox(
        height: 80,
        width: MediaQuery.of(context).size.width,
        padding: 10.0,
        colour: superLightCyan,
        radius: 10.0,
        outerPadding: 0.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultTextStyle(style: smallTitle, child: Text('My Medical History')),
            DefaultTextStyle(style: smallInfo, child: Text('Last Updated: 25/4/2023')),
          ],
        ));
  }

}

