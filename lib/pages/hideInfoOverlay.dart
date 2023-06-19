import 'package:flutter/material.dart';
import 'package:patient_mobile_app/pages/disclaimerOverlay.dart';
import '../resources/globals.dart';
import '../resources/components.dart';

// SELECT MEDICAL HISTORY PAGE
class SelectMedicalHistoryOverlay extends StatefulWidget {
  const SelectMedicalHistoryOverlay({super.key});

  @override
  State<StatefulWidget> createState() => _SelectMedicalHistoryOverlayState();

}

class _SelectMedicalHistoryOverlayState extends State<SelectMedicalHistoryOverlay> {

  @override
  Widget build(BuildContext context) {
    List<Widget> entriesWidgets = showMedicalHistory(patientData!.getMedHisSummary(), context, true);
    return Container(
        color: Colors.white.withOpacity(0.5),
        child: Center(
          child:
          Stack(
              children: [Column(
                children: [Flexible(
                    child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30, bottom: 30),
                        child: SingleChildScrollView(
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              medicalHistoryTitle,
                              SizedBox(height: 30,),
                            ] + entriesWidgets +
                                [
                                  SizedBox(height: 30,),
                                  LongButton(word: 'Confirm Data Selection', onPress: () {
                                    overlay.hideOverlay();
                                    overlay.showOverlay(context, const DisclaimerWidget());
                                  })
                                ])))),
                  // Container(height: 100, color: Colors.transparent,),
                ],),
                homeIcon,
              ]),
        )
    );
  }
}

