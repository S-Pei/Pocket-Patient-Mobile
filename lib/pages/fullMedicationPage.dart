import 'package:flutter/material.dart';
import '../resources/colours.dart';
import '../resources/components.dart';
import '../resources/globals.dart';
import '../resources/objects.dart';

// PRESCRIPTION PAGE
class FullMedicationPage extends StatelessWidget {
  final MedicationEntry fullData;

  const FullMedicationPage({super.key,
    required this.fullData
  });

  @override
  Widget build(BuildContext context) {
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
                            ]))
                  ]
              ), homeIcon,
              const ProfileLogo(),
            ]
        ));
  }
}