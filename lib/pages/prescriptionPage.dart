import 'package:flutter/material.dart';
import '../resources/globals.dart';
import '../resources/fonts.dart';
import '../resources/components.dart';

// PRESCRIPTION PAGE
class PrescriptionPage extends StatelessWidget {
  const PrescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
              child: Container(
                  padding: const EdgeInsets.all(50.0),
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 150,
                        ),
                        Row(children: [
                          Text('Prescriptions', style: subtitle),
                          Expanded(child: SizedBox(width: 70)),
                          PrintButton(),
                        ]),
                      ]))),
          homeIcon,
        ],
      ),
    );
  }
}