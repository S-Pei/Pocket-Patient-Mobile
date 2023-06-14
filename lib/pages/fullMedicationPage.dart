import 'dart:async';

import 'package:flutter/material.dart';
import '../resources/colours.dart';
import '../resources/components.dart';
import '../resources/fonts.dart';
import '../resources/globals.dart';
import '../resources/objects.dart';

class FullMedicationPage extends StatefulWidget {
  final MedicationEntry fullData;

  const FullMedicationPage({super.key, required this.fullData});

  @override
  State<StatefulWidget> createState() => _FullMedicationPage(fullData: fullData);

}

class _FullMedicationPage extends State<FullMedicationPage> {
  final MedicationEntry fullData;
  var delete = "Delete";

  _FullMedicationPage({
    required this.fullData
  });

  @override
  Widget build(BuildContext context) {
    var submittedBy;
    if (fullData.byPatient) {
      submittedBy = "Me";
    }
    else {
      submittedBy = "Doctors";
    }
    // if (fullData.byPatient == "true")
    return Scaffold(
        body: Stack(
            children: [
              TitlePageFormat(
                  children: [
                    const Row(children: [
                      BackButton(),
                    ]),
                    Container(
                        color: superLightCyan,
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height * 0.7, // Set the minimum height as a percentage
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 25.0, // Padding value for top and bottom
                          horizontal: 20.0, // Padding value for left and right
                        ),
                        child: Column(

                            children: [
                              medData("Drug: " , fullData.drug),
                              const SizedBox(height: 16),
                              medData("Dosage: " , fullData.dosage),
                              const SizedBox(height: 16),
                              medData("Start Date: " , fullData.startDate),
                              const SizedBox(height: 16),
                              medData("End Date: " , fullData.endDate),
                              const SizedBox(height: 16),
                              medData("Duration: " , fullData.duration),
                              const SizedBox(height: 16),
                              medData("Route: " , fullData.route),
                              const SizedBox(height: 16),
                              medData("Comments: " , fullData.comments),
                              const SizedBox(height: 16),
                              medData("Submitted by: " , submittedBy),
                              const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (fullData.byPatient)
                                    SizedBox(
                                height: 45,
                                width: 150,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 10,
                                      textStyle: boldContent,
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white),
                                  onPressed: () {
                                    if (delete == "Delete") {
                                      setState(() {
                                        delete = "Confirm";
                                      });
                                      Timer(Duration(seconds: 3), () {
                                        if (mounted) {
                                          setState(() {
                                            delete = "Delete";
                                          });
                                        }
                                      });
                                    }
                                    else {
                                      deleteMedicationEntry(fullData.id);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text(
                                    delete,
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                            )]
                            )
                    ]))
                  ]
              ), homeIcon,
              const ProfileLogo(),
            ]
        ));
  }
}

Widget medData(String title, String value) {
  return Container(
    alignment: Alignment.bottomLeft,
    child: DefaultTextStyle(
      style: const TextStyle(fontSize: 26, color: Colors.black),
      child: Row(
        children: [
          Flexible(
            flex: 14,
            fit: FlexFit.tight,
            child: RichText(
                text: TextSpan(
                  text: title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                )
            ),
          ),
          Flexible(
              flex: 20,
              fit: FlexFit.tight,
              child: RichText(
                text: TextSpan(
                  text: value,
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
              )
          )
        ],
      ),
    ),
  );
}