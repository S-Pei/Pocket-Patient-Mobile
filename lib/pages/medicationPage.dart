import 'package:flutter/material.dart';
import '../resources/colours.dart';
import '../resources/components.dart';
import '../resources/fonts.dart';
import '../resources/globals.dart';

// PRESCRIPTION PAGE
class MedicationPage extends StatelessWidget {
  const MedicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TitlePageFormat(
              children: [SizedBox(height: 15,),medicationTitle, SizedBox(height: 30,),
                Row(children: [
                      Expanded(child: SizedBox(width: 70)),
                      PrintButton(),
                    ]),
                Table(
                  border: TableBorder.all(), // Add border to the table
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Text('Drug', textAlign: TextAlign.center,), // Content of column 1
                        ),
                        TableCell(
                          child: Text('Dosage', textAlign: TextAlign.center,), // Content of column 2
                        ),
                        TableCell(
                          child: Text('More Info', textAlign: TextAlign.center,), // Content of column 3
                        ),
                      ],
                    ),
                  ] + showMedications(patientData!.medication),
                ),
              ]
          ),
          homeIcon,
          const ProfileLogo(),
        ],
      ),
    );
  }
}

class MedicationTitle extends StatelessWidget {
  const MedicationTitle({super.key});

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
            DefaultTextStyle(style: smallTitle, child: Text('My Medications')),
            DefaultTextStyle(style: smallInfo, child: Text('Last Updated: 25/4/2023')),
          ],
        ));
  }
}