library globals;

import 'dart:convert';

import 'package:patient_mobile_app/components.dart';
import 'package:patient_mobile_app/pages.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'objects.dart' as objects;
import 'package:http/http.dart' as http;

final channel = WebSocketChannel.connect(
  Uri.parse('wss://patientoncall.herokuapp.com/ws/patientoncall/12345/bobchoy/'),
);

final overlay = CustomOverlay();

const homeIcon = HomeIcon();

final medicalHistoryTitle = MedicalHistoryTitle();

var firstRender = true;

final homePage = HomePage();

objects.Patient? patientData;

Future<objects.Patient> fetchData(String url) async {

  final response = await http.get(
      Uri.parse(url));
  if (response.statusCode == 200) {
    return objects.Patient.fromJson(json.decode(response.body));
  } else {
    // Handle error if the request fails
    throw Future.error('Failed to fetch data');
  }
}

Set<String> toHide = {};