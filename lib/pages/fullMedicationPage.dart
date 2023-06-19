import 'dart:async';

import 'package:flutter/material.dart';
import 'package:patient_mobile_app/pages/addMedication.dart';
import 'package:patient_mobile_app/pages/medicationPage.dart';
import '../resources/colours.dart';
import '../resources/components.dart';
import '../resources/fonts.dart';
import '../resources/globals.dart';
import '../resources/objects.dart';

class FullMedicationPage extends StatelessWidget {
  const FullMedicationPage({super.key, required this.data});

  final MedicationEntry data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TitlePageFormat(
              children: [
                const BackButtonBlue(),
                const SizedBox(height: 15,),
                MedicationDetailsTitle(data: data,),
                const SizedBox(height: 30,),
                MedicationInfo(data: data),
              ]
          ),
          homeIcon,
        ],
      ),
    );
  }
}

class MedicationDetailsTitle extends StatelessWidget {
  const MedicationDetailsTitle({super.key, required this.data});

  final MedicationEntry data;

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
            DefaultTextStyle(style: smallTitle, child: Text(data.drug)),
            DefaultTextStyle(style: smallInfo, child: Text('Dosage: ${data.dosage}')),
          ],
        ),
    );
  }
}


class MedicationInfo extends StatefulWidget {

  const MedicationInfo({super.key, required this.data});

  final MedicationEntry data;

  @override
  State<StatefulWidget> createState() => _MedicationInfo(data: data);
}

class _MedicationInfo extends State<MedicationInfo> {
  _MedicationInfo({required this.data});

  MedicationEntry data;
  String delete = "Delete";

  @override
  void initState() {
    delete = "Delete";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children:
        generateMedicationDetail('Start Date', data.startDate) +
            generateMedicationDetail('End Date', data.endDate) +
            generateMedicationDetail('Duration', data.duration) +
            generateMedicationDetail('Method', data.route) +
            generateMedicationDetail('Comments', data.comments) +
            [ const SizedBox(height: 30,),
              (() {
                if (data.byPatient) {
                  return NavigateLongButton(word: 'Edit', nextPage: AddMedicationPage(oldData: data,));
                } else {
                  return const SizedBox(height: 10,);
                }
              }()),
              const SizedBox(height: 15,),
              (() {
                if (data.byPatient) {
                  return DeleteButton(word: delete, onPress: () {
                    if (delete == "Delete") {
                      setState(() {
                        delete = "Confirm";
                      });
                      Timer(const Duration(seconds: 3), () {
                        if (mounted) {
                          setState(() {
                            delete = "Delete";
                          });
                        }
                      });
                    } else if (delete == "Confirm") {
                      deleteOnPress(data, context);
                    }
                  });
                } else {
                  return const SizedBox(height: 10,);
                }
              }()),
            ]
      // addToMedHist(data.addToMedicalHistory)
    );
  }

}

List<Widget> generateMedicationDetail(String title, String info) {
  return [
    const Flexible(
        flex: 5,
        fit: FlexFit.loose,
        child: SizedBox(height: 20,)),
    Flexible(
        flex: 1,
        fit: FlexFit.loose,
        child: DefaultTextStyle(style: smallInfo, softWrap: true,
            child: MedicationDetail(title: title, info: info))),
  ];
}

class MedicationDetail extends StatelessWidget {
  const MedicationDetail({super.key, required this.title, required this.info});

  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: SizedBox(width: 5,)),
      Flexible(
          fit: FlexFit.tight,
          flex: 10,
          child: SizedBox(
              width: 50,
              child: DefaultTextStyle(style: boldContent, softWrap: true, child: Text('$title:'),))),
      Flexible(
          fit: FlexFit.tight,
          flex:11,
          child: Container(
              width: 250,
              child: DefaultTextStyle(style: content, softWrap: true, child: Text(info),)
          )),
    ]);
  }
}

void deleteOnPress(MedicationEntry data, BuildContext context) {
  deleteMedicationEntry(data.id);
  if (patientData!.deleteMedication(data.id)) {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const MedicationPage()));
  }
}

// class FullMedicationPage extends StatefulWidget {
//   final MedicationEntry fullData;
//
//   const FullMedicationPage({super.key, required this.fullData});
//
//   @override
//   State<StatefulWidget> createState() => _FullMedicationPage(fullData: fullData);
//
// }
//
// class _FullMedicationPage extends State<FullMedicationPage> {
//   final MedicationEntry fullData;
//   var delete = "Delete";
//
//   _FullMedicationPage({
//     required this.fullData
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     var submittedBy;
//     if (fullData.byPatient) {
//       submittedBy = "Me";
//     }
//     else {
//       submittedBy = "Doctors";
//     }
//     // if (fullData.byPatient == "true")
//     return Scaffold(
//         body: Stack(
//             children: [
//               TitlePageFormat(
//                   children: [
//                     const Row(children: [
//                       BackButton(),
//                     ]),
//                     Container(
//                         color: superLightCyan,
//                         constraints: BoxConstraints(
//                           minHeight: MediaQuery.of(context).size.height * 0.7, // Set the minimum height as a percentage
//                         ),
//                         padding: EdgeInsets.symmetric(
//                           vertical: 25.0, // Padding value for top and bottom
//                           horizontal: 20.0, // Padding value for left and right
//                         ),
//                         child: Column(
//
//                             children: [
//                               medData("Drug: " , fullData.drug),
//                               const SizedBox(height: 16),
//                               medData("Dosage: " , fullData.dosage),
//                               const SizedBox(height: 16),
//                               medData("Start Date: " , fullData.startDate),
//                               const SizedBox(height: 16),
//                               medData("End Date: " , fullData.endDate),
//                               const SizedBox(height: 16),
//                               medData("Duration: " , fullData.duration),
//                               const SizedBox(height: 16),
//                               medData("Route: " , fullData.route),
//                               const SizedBox(height: 16),
//                               medData("Comments: " , fullData.comments),
//                               const SizedBox(height: 16),
//                               medData("Submitted by: " , submittedBy),
//                               const SizedBox(height: 16),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   if (fullData.byPatient)
//                                     SizedBox(
//                                 height: 45,
//                                 width: 150,
//                                 child: ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(10.0),
//                                       ),
//                                       elevation: 10,
//                                       textStyle: boldContent,
//                                       backgroundColor: Colors.red,
//                                       foregroundColor: Colors.white),
//                                   onPressed: () {
//                                     if (delete == "Delete") {
//                                       setState(() {
//                                         delete = "Confirm";
//                                       });
//                                       Timer(Duration(seconds: 3), () {
//                                         if (mounted) {
//                                           setState(() {
//                                             delete = "Delete";
//                                           });
//                                         }
//                                       });
//                                     }
//                                     else {
//                                       deleteMedicationEntry(fullData.id);
//                                       Navigator.pop(context);
//                                     }
//                                   },
//                                   child: Text(
//                                     delete,
//                                     softWrap: true,
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                             )]
//                             )
//                     ]))
//                   ]
//               ), homeIcon,
//               const ProfileLogo(),
//             ]
//         ));
//   }
// }
//
//
// Widget medData(String title, String value) {
//   return Container(
//     alignment: Alignment.bottomLeft,
//     child: DefaultTextStyle(
//       style: const TextStyle(fontSize: 26, color: Colors.black),
//       child: Row(
//         children: [
//           Flexible(
//             flex: 14,
//             fit: FlexFit.tight,
//             child: RichText(
//                 text: TextSpan(
//                   text: title,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//                 )
//             ),
//           ),
//           Flexible(
//               flex: 20,
//               fit: FlexFit.tight,
//               child: RichText(
//                 text: TextSpan(
//                   text: value,
//                   style: const TextStyle(fontSize: 20, color: Colors.black),
//                 ),
//               )
//           )
//         ],
//       ),
//     ),
//   );
// }