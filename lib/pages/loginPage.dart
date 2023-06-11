import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_mobile_app/resources/colours.dart';
import 'package:patient_mobile_app/resources/components.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../resources/globals.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginInput nhsNum = LoginInput(label: 'Enter username');
  final LoginInput password = LoginInput(label: 'Enter password');

  Future<http.Response> buttonPress() {
    int number = nhsNum.inputController.text as int;
    String pwd = password.inputController.text;
    return http.post(
      Uri.parse(debug ? 'http://10.0.2.2:8000/api/token' : 'https://patientoncall.herokuapp.com/api/token'),
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode(<String, String>{
        'number': ,
      }),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: medCyan,
      body: Center(
        child: FractionallySizedBox(
          heightFactor: 1,
          widthFactor: 0.9,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                nhsNum,
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: password,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  width: 200,
                  child: ShortButton(word: 'login', onPress: (){}),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// LOGIN INPUT WIDGET
class LoginInput extends StatelessWidget {
  LoginInput({super.key, required this.label});

  final inputController = TextEditingController();
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inputController,
      decoration: InputDecoration(
        label: Text.rich(
          TextSpan(
            children: <InlineSpan>[
              WidgetSpan(
                child: Text(
                  label,
                ),
              ),
              const WidgetSpan(
                child: Text(
                  '*',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}