import 'package:flutter/material.dart';
import 'package:patient_mobile_app/resources/globals.dart';

// PERSONAL INFO SUB PAGE
class PersonalInfoSubPage extends StatelessWidget {
  const PersonalInfoSubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [Center(
          child: Text('Personal Info SubPage'),
        ),
        homeIcon],
      )

    );
  }
}
