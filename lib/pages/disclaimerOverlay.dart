import 'dart:convert';

import 'package:flutter/material.dart';
import '../resources/colours.dart';
import '../resources/fonts.dart';
import '../resources/globals.dart';
import '../resources/components.dart';

// DISCLAIMER OVERLAY
class DisclaimerWidget extends StatelessWidget {
  const DisclaimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white.withOpacity(0.5),
      child: Center(
          child: Material(child:
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ColouredBox(colour: bgGrey,
                height: MediaQuery.of(context).size.height/3,
                width: MediaQuery.of(context).size.width,
                padding: 35.0,
                radius: 30.0,
                outerPadding: 25.0,
                // child: SingleChildScrollView(
                    child: Column(
                        children: [
                          RichText(text: const TextSpan(text: 'DISCLAIMER', style: redTitle,
                          children: [
                            TextSpan(text: ': Hiding medical data might post serious risk to your medical diagnosis.',
                            style: title,)
                          ])),
                          const Text('Are you sure you would like to hide your data selection?', style: content, softWrap: true,),
                          const SizedBox(height: 20,),
                          Column(
                              children: [
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
                                            overlay.hideOverlay(),
                                            grantAccess(toHide)
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