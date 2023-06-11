import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_mobile_app/resources/colours.dart';
import 'package:patient_mobile_app/resources/components.dart';
import 'package:patient_mobile_app/resources/globals.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginInput nhsNum = LoginInput(label: 'Enter username', isPassword: false,);
  final LoginInput password = LoginInput(label: 'Enter password', isPassword: true,);

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
                  child: ShortButton(word: 'login',
                      onPress: () {
                        fetchToken(context,
                            nhsNum.inputController.text,
                            password.inputController.text
                        );
                      }),
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
  LoginInput({super.key, required this.label, required this.isPassword});

  final inputController = TextEditingController();
  final String label;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
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