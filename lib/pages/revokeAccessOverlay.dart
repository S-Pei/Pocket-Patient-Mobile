import 'package:flutter/material.dart';
import 'package:patient_mobile_app/pages/medInsAccPage.dart';
import '../resources/colours.dart';
import '../resources/fonts.dart';
import '../resources/globals.dart';
import '../resources/components.dart';

// REVOKE ACCESS OVERLAY
class RevokeAccessOverlay extends StatelessWidget {
  const RevokeAccessOverlay({super.key, required this.toRevokeId});

  final String toRevokeId;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.5),
      child: Center(
          child: Material(child:
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ColouredBox(colour: bgGrey,
                height: MediaQuery.of(context).size.height/7 * 3,
                width: MediaQuery.of(context).size.width,
                padding: 35.0,
                radius: 30.0,
                outerPadding: 25.0,
                child: SingleChildScrollView(
                    child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Are you sure you want to revoke access for St Mary Hospital?',
                            style: title,
                            softWrap: true,),
                            SizedBox(height: 10,),
                            Text('The hospital would no longer have access to any medical information on this app',
                              style: infoFont, softWrap: true,),
                            SizedBox(height: 10,),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children :[
                                  SmallButton(
                                      text: 'cancel',
                                      color: buttonRed,
                                      onPress: () => {
                                        medAccIncVisibility[toRevokeId] = true,
                                        overlay.hideOverlay(),
                                        Navigator.pop(context),
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => MedAccInsPage()),
                                        ),
                                      }),
                                  SmallButton(
                                      text: 'confirm',
                                      color: buttonGreen,
                                      onPress: () => {
                                        overlay.hideOverlay(),
                                        revokeAccess(),
                                        medAccIncVisibility.remove(toRevokeId),
                                        Navigator.pop(context),
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => MedAccInsPage()),
                                        ),
                                      }),
                                ]
                            )
                        ]),
              ))]),
          )),
    );
  }
}