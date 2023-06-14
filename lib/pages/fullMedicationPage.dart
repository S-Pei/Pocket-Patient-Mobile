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
                              Container(
                                  alignment: Alignment.bottomLeft,
                                  child: DefaultTextStyle(
                                    style: const TextStyle(fontSize: 26, color: Colors.black),
                                    child: RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: 'Drug: ',
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: fullData.drug,
                                            style: const TextStyle(fontSize: 20, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                              const SizedBox(height: 16),
                              Container(
                                  alignment: Alignment.bottomLeft,

                                  child: DefaultTextStyle(
                                    style: const TextStyle(fontSize: 26, color: Colors.black),
                                    child: RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: 'Dosage: ',
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: fullData.dosage,
                                            style: const TextStyle(fontSize: 20, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                              const SizedBox(height: 16),
                              Container(
                                  alignment: Alignment.bottomLeft,

                                  child: DefaultTextStyle(
                                    style: const TextStyle(fontSize: 26, color: Colors.black),
                                    child: RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: 'StartDate: ',
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: fullData.startDate,
                                            style: const TextStyle(fontSize: 20, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                              const SizedBox(height: 16),
                              Container(
                                  alignment: Alignment.bottomLeft,

                                  child: DefaultTextStyle(
                                    style: const TextStyle(fontSize: 26, color: Colors.black),
                                    child: RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: 'End Date: ',
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: fullData.endDate,
                                            style: const TextStyle(fontSize: 20, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                              const SizedBox(height: 16),
                              Container(
                                  alignment: Alignment.bottomLeft,

                                  child: DefaultTextStyle(
                                    style: const TextStyle(fontSize: 26, color: Colors.black),
                                    child: RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: 'Duration: ',
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: fullData.duration,
                                            style: const TextStyle(fontSize: 20, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                              const SizedBox(height: 16),
                              Container(
                                  alignment: Alignment.bottomLeft,

                                  child: DefaultTextStyle(
                                    style: const TextStyle(fontSize: 26, color: Colors.black),
                                    child: RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: 'Route: ',
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: fullData.route,
                                            style: const TextStyle(fontSize: 20, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                              const SizedBox(height: 16),
                              Container(
                                  alignment: Alignment.bottomLeft,

                                  child: DefaultTextStyle(
                                    style: const TextStyle(fontSize: 26, color: Colors.black),
                                    child: RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: 'Comments: ',
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: fullData.comments,
                                            style: const TextStyle(fontSize: 20, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                              ),
                              const SizedBox(height: 16),
                              Container(
                                  alignment: Alignment.bottomLeft,

                                  child: DefaultTextStyle(
                                    style: const TextStyle(fontSize: 26, color: Colors.black),
                                    child: RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          const TextSpan(
                                            text: 'Submitted by: ',
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: submittedBy,
                                            style: const TextStyle(fontSize: 20, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                              ),
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