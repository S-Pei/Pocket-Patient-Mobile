import 'dart:convert';

import 'package:flutter/material.dart';
import '../resources/colours.dart';
import '../resources/fonts.dart';
import '../resources/globals.dart';
import '../resources/components.dart';

// MEDICAL INSTITUTIONS WITH ACCESS TO MY DATA PAGE
class MedAccInsPage extends StatefulWidget {
  const MedAccInsPage({super.key});

  @override
  State<StatefulWidget> createState() => _MedAccInsPageState();
}

class _MedAccInsPageState extends State<MedAccInsPage> {
  Widget title = TitleColouredBox(
      widgets: [Text('Medical Institutions with Access to My Data', style: subtitle, softWrap: true,)], height: 80);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              padding: const EdgeInsets.all(30.0),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 120,
                        ),
                        title,
                        SizedBox(height: 30,),
                      ] ))),
          homeIcon,
        ],
      ),
    );
  }
}

