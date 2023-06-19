import 'package:flutter/material.dart';
import 'package:patient_mobile_app/pages/addHospitalVisit.dart';
import '../resources/colours.dart';
import '../resources/components.dart';
import '../resources/fonts.dart';
import '../resources/globals.dart';
import '../resources/objects.dart';
import 'addMedication.dart';

class MedicationNotifier extends ValueNotifier<List<MedicationEntry>> {
  MedicationNotifier(List<MedicationEntry> medication) : super(medication);

  void updateMedication(List<MedicationEntry> medication) {
    print("print medication of update: ");
    print(medication);
      value = medication;
  }
}

class MedicationPage extends StatelessWidget {
  const MedicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<MedicationEntry>>(
      valueListenable: medicationNotifier,
      builder: (context, value, child) {
        return Scaffold(
            body: Stack(
                children: [
              Center(
              child: Container(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(children: [
                const Flexible(
                    flex: 4,
                    fit: FlexFit.tight,
                    child: SizedBox(
                      height: 90,
                    )),
                Flexible(
                    flex: 7,
                    fit: FlexFit.loose,
                    child: Container(
                        height: 300,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15,),medicationTitle, SizedBox(height: 10,),
                              Row(children: [
                                Expanded(child: SizedBox(width: 70)),
                                PrintButton(),
                              ])],
                    ))
              ),
              Flexible(
                  flex: 15,
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Container(
                          color: superLightCyan,
                          child: Table(
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
                          ] + showMedications(patientData!.medication, context),
                        ),
                    )
                    ]
              ))),
              const Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: SizedBox(
                    height: 20,
                  )),
              const Flexible(
                  flex: 3,
                  child: NavigateLongButton(word: 'Add Medication Entry', nextPage: AddMedicationPage(oldData: null,))
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
            DefaultTextStyle(style: smallInfo, child: Text('Last Updated: 20/6/2023')),
          ],
        ));
  }
}