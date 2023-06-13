import 'dart:convert';

import 'package:flutter/material.dart';
import '../resources/colours.dart';
import '../resources/fonts.dart';
import '../resources/globals.dart';
import '../resources/components.dart';
import 'hideInfoOverlay.dart';

// AUTHENTICATION OVERLAY WIDGET
class OverlayWidget extends StatefulWidget {
  const OverlayWidget({super.key});

  @override
  State<StatefulWidget> createState() => _OverlayState();
}

class _OverlayState extends State<OverlayWidget> {
  final List<bool> _isCheckedList = [false, false];
  List<String> strs = ['I consent to share all medical data to this hospital for treatment '
      'purposes only for 7 days', 'I wish to share selected data only for 7 days'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.5),
      alignment: Alignment.center,
      child: Center(
        child: Material(child:
            Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ColouredBox(colour: bgGrey,
          height: MediaQuery.of(context).size.height/2,
          width: MediaQuery.of(context).size.width,
          padding: 35.0,
          radius: 30.0,
          outerPadding: 25.0,
          // child: SingleChildScrollView(
              child: Column(
                  children: [
                    Text('St Mary Hospital is requesting for your data.',
                      style: title,
                      softWrap: true,),
                    Column(
                        children: [
                          ListTileTheme(
                            contentPadding: EdgeInsets.all(0),
                            child: CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(strs[0]),
                              value: _isCheckedList[0],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedList[0] = value!;
                                  _isCheckedList[1] = !value!;
                                });
                              },
                            ),),
                          ListTileTheme(
                            contentPadding: EdgeInsets.all(0),
                            child: CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text(strs[1]),
                              value: _isCheckedList[1],
                              onChanged: (bool? value) {
                                setState(() {
                                  _isCheckedList[1] = value!;
                                  _isCheckedList[0] = !value!;
                                });
                              },
                            ),),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children :[
                                SmallButton(
                                    text: 'decline',
                                    color: buttonRed,
                                    onPress: () => {overlay.hideOverlay(), denyAccess()}),
                                SmallButton(
                                    text: 'accept',
                                    color: buttonGreen,
                                    onPress: () => {
                                      if (_isCheckedList[1]) {
                                        overlay.hideOverlay(),
                                        overlay.showOverlay(context, const SelectMedicalHistoryOverlay()),
                                      } else if (_isCheckedList[0] && !_isCheckedList[1]){
                                        grantAccess({}),
                                        overlay.hideOverlay(),
                                      }
                                    }),
                              ]
                          )
                        ]
                    )
                  ]),
        )]),
        )),
    );
  }
}