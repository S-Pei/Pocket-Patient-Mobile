library globals;

import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:patient_mobile_app/pages/diaryPage.dart';
import 'package:patient_mobile_app/resources/components.dart';
import 'package:patient_mobile_app/resources/fonts.dart';
import 'package:patient_mobile_app/resources/objects.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../pages/hideInfoOverlay.dart';
import '../pages/homePage.dart';
import 'package:http/http.dart' as http;

import '../pages/loginPage.dart';
import '../pages/medInsAccPage.dart';
import '../pages/medicalHistoryPage.dart';
import '../pages/medicationPage.dart';
import 'dart:async';


const localHost = '10.0.2.2:8000';
const deployedHost = 'patientoncall.herokuapp.com';
const localHostUrl = 'http://$localHost';
const deployedHostUrl = 'https://$deployedHost';

const autoUrl = debug ? localHostUrl : deployedHostUrl;

const debug = true;

final channel = WebSocketChannel.connect(
  Uri.parse(debug ? 'ws://$localHost/ws/patientoncall/${patientUser!.username}/' :
                    'wss://$deployedHost/ws/patientoncall/${patientUser!.username}/'),
);

Timer refreshTokenTimer = Timer.periodic(const Duration(minutes: 7), (timer) async {
  refreshTokenApi();
});

void refreshTokenApi() async {
  final response = await http.post(
      Uri.parse('${debug ? localHostUrl : deployedHostUrl}/api/token/refresh/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'refresh': patientUser!.refresh,
      })
  );

  if (response.statusCode == 200) {
    dynamic data = json.decode(response.body);
    patientUser!.refreshToken(data['access'], data['refresh']);
  } else {
    // Handle error if the request fails
    throw Future.error('Failed to refresh token');
  }
}

final overlay = CustomOverlay();

const homeIcon = HomeIcon();

final medicalHistoryTitle = MedicalHistoryTitle();

final medicationTitle = MedicationTitle();

const diaryPageTitle = DiaryPageTitle();

var firstRender = true;

final homePage = HomePage();

final loginPage = LoginPage();

Map<String, Pair<String,String>> hosps = {'1': Pair('St Mary Hospital', '25/4/2023'), '2': Pair('St John Hospital', '26/4/2023')};

Map<String, Widget> medAccIncEntries = {};
Map<String, bool> medAccIncVisibility = {'1': true, '2': true};

Patient? patientData;

PatientUser? patientUser;

Future<Patient> fetchData(String url) async {

  final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${patientUser!.access}'
      },
  );
  if (response.statusCode == 200) {
    print('patient data: ${json.decode(response.body)}');
    return Patient.fromJson(json.decode(response.body));
  } else {
    // Handle error if the request fails
    throw Future.error('Failed to fetch data');
  }
}

void fetchToken(context, username, password) async {
  final response = await http.post(
    Uri.parse(debug ? 'http://$localHost/api/token/' : 'https://$deployedHost/api/token/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    patientUser = PatientUser.fromJson(username, json.decode(response.body));
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
  } else {
    print("Invalid user");
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
    print(entry.value);
    widgets.add(VisibilityTile(data: entry.value, editMode: editMode, uuid : entry.key));
    widgets.add(SizedBox(height: 10,));
  }
  return widgets;
}

List<TableRow> showMedications(List<MedicationEntry> data) {
  print('show medical history: ${data}');
  List<TableRow> tableRow = [];
  for (var entry in data) {
    tableRow.add(TableRow(
      children: [
        TableCell(
          child: Text(entry.drug, textAlign: TextAlign.center,), // Content of column 1
        ),
        TableCell(
          child: Text(entry.dosage, textAlign: TextAlign.center,), // Content of column 2
        ),
        TableCell(
          child: Text('More Info', textAlign: TextAlign.center,), // Content of column 3
        ),
      ],
    ),);
  }
  return tableRow;
}

List<Widget> showDiaryList(List<Pair<String, String>> data, BuildContext context) {
  List<Widget> widgets = [];
  widgets.add(
    const Row(children: [
      Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: SizedBox(width: 5),
      ),
      Flexible(
          fit: FlexFit.tight,
          flex: 10,
          child: SizedBox(
              width: 50,
              child: DefaultTextStyle(
                style: boldContent,
                softWrap: true,
                child: Text('Date'),
              ),
          ),
      ),
      Flexible(
          fit: FlexFit.tight,
          flex: 25,
          child: SizedBox(
              width: 250,
              child: DefaultTextStyle(
                  style: boldContent,
                  softWrap: true,
                  child: Text('Content'),
              ),
          ),
      ),
    ]),
  );
  widgets.add(const SizedBox(height: 10));
  print('data $data');
  for (var entry in data) {
    print(entry);
    widgets.add(VisibilityTile(data: entry, editMode: false, uuid : 'null'));
    widgets.add(const SizedBox(height: 10));
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