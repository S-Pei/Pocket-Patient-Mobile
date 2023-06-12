library globals;

import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dartx/dartx.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:patient_mobile_app/resources/components.dart';
import 'package:patient_mobile_app/resources/fonts.dart';
import 'package:patient_mobile_app/resources/objects.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../pages/hideInfoOverlay.dart';
import '../pages/homePage.dart';
import 'package:http/http.dart' as http;

import '../pages/medicalHistoryPage.dart';

bool debug = false;
bool ios = true;
String debugWebSocket = ios ?  'ws://127.0.0.1:8000/ws/patientoncall/12345/bobchoy/' : 'ws://10.0.2.2:8000/ws/patientoncall/12345/bobchoy/';
String webSocketUrl = debug ? debugWebSocket : 'wss://patientoncall.herokuapp.com/ws/patientoncall/12345/bobchoy/';

final channel = WebSocketChannel.connect(
  Uri.parse(webSocketUrl),
);

final overlay = CustomOverlay();

const homeIcon = HomeIcon();

final medicalHistoryTitle = MedicalHistoryTitle();

var firstRender = true;

final homePage = HomePage();

Map<String, Pair<String,String>> hosps = {'1': Pair('St Mary Hospital', '25/4/2023'), '2': Pair('St John Hospital', '26/4/2023')};

Map<String, Widget> medAccIncEntries = {};
Map<String, bool> medAccIncVisibility = {'1': true, '2': true};

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
  widgets.add(
      Row(children: [
        Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: SizedBox(width: 5,)),
        Flexible(
            fit: FlexFit.tight,
            flex: 10,
            child: Container(
                width: 50,
                child: DefaultTextStyle(child: Text('Date'), style: boldContent, softWrap: true,))),
        Flexible(
            fit: FlexFit.tight,
            flex: 25,
            child: Container(
                width: 250,
                child: DefaultTextStyle(child: Text('Condition'), style: boldContent, softWrap: true,)
            )),
      ]),
  );
  widgets.add(SizedBox(height: 10,));
  for (var entry in data.entries) {
    widgets.add(VisibilityTile(data: entry.value, editMode: editMode, uuid : entry.key));
    widgets.add(SizedBox(height: 10,));
  }
  return widgets;
}

// Sends permission to server
void grantAccess(Set<String> ids) {
  Map<String, dynamic> data = {};
  data['event'] = 'GRANT_PATIENT_DATA_ACCESS';
  data['ids'] = ids.toList();
  final json = jsonEncode(data);
  print(data);
  channel.sink.add(json);
  toHide.clear();
}

// denies access to server
void denyAccess() {
  Map<String, dynamic> data = {};
  data['event'] = 'DENY_PATIENT_DATA_ACCESS';
  final json = jsonEncode(data);
  print(data);
  channel.sink.add(json);
  toHide.clear();
}

// denies access to server
void revokeAccess() {
  Map<String, dynamic> data = {};
  data['event'] = 'REVOKE_PATIENT_DATA_ACCESS';
  final json = jsonEncode(data);
  print(data);
  channel.sink.add(json);
  toHide.clear();
}

void sendAuthNotif() {
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: 'Authorisation Request',
          body: 'St Mary Hospital is requesting for access to your data. Click here to take action'
      ),
  );
}