import 'package:flutter/material.dart';
import '../resources/colours.dart';
import '../resources/components.dart';
import '../resources/fonts.dart';
import '../resources/globals.dart';
import '../resources/objects.dart';

// PRESCRIPTION PAGE
class FullMedicationPage extends StatelessWidget {
  final MedicationEntry fullData;

  FullMedicationPage({
    required this.fullData
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TitlePageFormat(
              children: [
                Row(children: [
                  BackButton(),
                ]),
                Container(
                  height:1000,
                    child: ListView(
                  children: [
                    ListTile(
                      title: Text('Drug: ' + fullData.drug),
                    ),
                    ListTile(
                      title: Text('Dosage: ' + fullData.dosage),
                    ),
                    ListTile(
                      title: Text('Start Date: ' + fullData.startDate),
                    ),
                    ListTile(
                      title: Text('End Date: ' + fullData.endDate),
                    ),
                    ListTile(
                      title: Text('Duration: ' + fullData.duration),
                    ),
                    ListTile(
                      title: Text('Route: ' + fullData.route),
                    ),
                    ListTile(
                      title: Text('Comments: ' + fullData.comments),
                    ),
                  ],
                )),
              ]
          ),
          homeIcon,
          const ProfileLogo(),
        ],
      ),
    );
  }
}