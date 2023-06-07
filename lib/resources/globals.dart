library globals;

import 'dart:convert';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:patient_mobile_app/resources/components.dart';
import 'package:patient_mobile_app/resources/objects.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../pages/hideInfoOverlay.dart';
import '../pages/homePage.dart';
import 'package:http/http.dart' as http;

import '../pages/medicalHistoryPage.dart';

final channel = WebSocketChannel.connect(
  Uri.parse('wss://patientoncall.herokuapp.com/ws/patientoncall/12345/bobchoy/'),
);

final overlay = CustomOverlay();

const homeIcon = HomeIcon();

final medicalHistoryTitle = MedicalHistoryTitle();

var firstRender = true;

final homePage = HomePage();

Patient? patientData;

Future<Patient> fetchData(String url) async {

  final response = await http.get(
      Uri.parse(url));
  if (response.statusCode == 200) {
    print('patient data: ${json.decode(response.body)}');
    return Patient.fromJson(json.decode(response.body));
  } else {
    // Handle error if the request fails
    throw Future.error('Failed to fetch data');
  }
}

Set<String> toHide = {};

List<Widget> showMedicalHistory(Map<String, Pair<String, String>> data, BuildContext context, bool editMode) {
  print('show medical history: ${data}');
  List<Widget> widgets = [];
  for (var entry in data.entries) {
    widgets.add(VisibilityTile(data: entry.value, editMode: editMode, uuid : entry.key));
    widgets.add(SizedBox(height: 10,));
  }
  return widgets;
}