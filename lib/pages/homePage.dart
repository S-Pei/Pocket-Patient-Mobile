import 'dart:convert';

import 'package:flutter/material.dart';
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
    fetchData('https://patientoncall.herokuapp.com/api/patient-data/')
        .then((val) => {patientData = val});
    print('toHide: ${toHide}');
    if (firstRender == true) {
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
    print(patientData);
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
                          height: 120,
                        ),
                        MainPageTitle(),
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
          homeIcon,
          MedInsAcc()
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
    Future<Patient> _patientData = fetchData('https://patientoncall.herokuapp.com/api/patient-data/');
    return ColouredBox(
        height: 160,
        width: MediaQuery.of(context).size.width,
        padding: 15.0,
        colour: superLightCyan,
        radius: 10.0,
        outerPadding: 0.0,
        child: FutureBuilder<Patient>(
          future: _patientData, // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<Patient> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              _patientData.then((value) => patientData = value);
              String patientName = '${patientData?.first_name} ${patientData?.last_name}';
              String dob = '${patientData?.dob}';
              String address = '${patientData?.patient_address}';
              children = <Widget>[Expanded(child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle(style: smallTitle, child: Text(patientName, style: smallTitle, softWrap: true)),
                    DefaultTextStyle(style: smallInfo, child: InfoFormat(title: 'NHS Number', info: '123 456 7890'), softWrap: true),
                    DefaultTextStyle(style: smallInfo, child: InfoFormat(title: 'D.O.B', info: dob), softWrap: true),
                    DefaultTextStyle(style: smallInfo, child: InfoFormat(title: 'Address', info: address), softWrap: true),
                  ],
                ),
              ))
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
    return Positioned(
      bottom: 60.0,
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: contentButton,
        ),
        onPressed: () {},
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(right: 40, left: 40),
          child: const Text('Manage Medical Institutions with access to your data', softWrap: true,),
        )
      ),
      );
  }

}

