import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_mobile_app/resources/colours.dart';
import 'package:patient_mobile_app/resources/components.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                const LoginInput(label: 'Enter NHS number'),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: const LoginInput(label: 'Enter password'),
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

class LoginInput extends StatelessWidget {
  const LoginInput({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
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