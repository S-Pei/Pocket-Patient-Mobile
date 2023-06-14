library globals;

import 'dart:convert';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:patient_mobile_app/pages/diaryPage.dart';
import 'package:patient_mobile_app/pages/fullMedicationPage.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:patient_mobile_app/pages/hospitalVisitPage.dart';

import 'package:patient_mobile_app/resources/components.dart';
import 'package:patient_mobile_app/resources/fonts.dart';
import 'package:patient_mobile_app/resources/objects.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../pages/homePage.dart';
import 'package:http/http.dart' as http;
import '../pages/loginPage.dart';
import '../pages/medicalHistoryPage.dart';
import '../pages/medicationPage.dart';
import 'dart:async';

bool ios = true;
String localHost = ios ? '127.0.0.1:8000' : '10.0.2.2:8000';
const deployedHost = 'patientoncall.herokuapp.com';
String localHostUrl = 'http://$localHost';
const deployedHostUrl = 'https://$deployedHost';


String autoUrl = debug ? localHostUrl : deployedHostUrl;

const debug = true;


// WEBSOCKET INITIALISATION
WebSocketChannel? channel;

void initWebsocket(context, listenFunc) {
  channel = connectWebsocket(context);
  websocketActions(context, listenFunc);
}

void websocketActions(context, listenFunc) {
  channel!.stream.listen((data) {
    listenFunc(data);
  }, onDone: () async {
    print("conecting aborted, attempting to reconnect...");

    await Future.delayed(const Duration(milliseconds: 4000));
    initWebsocket(context, listenFunc);
  }, onError: (e) async {
    print('Server error, attempting to reconnect...');
    await Future.delayed(const Duration(milliseconds: 4000));
    initWebsocket(context, listenFunc);
  },
  cancelOnError: true);
}

WebSocketChannel connectWebsocket(context) {
  return WebSocketChannel.connect(
    Uri.parse(debug ? 'ws://$localHost/ws/patientoncall/${patientUser!.username}/' :
    'wss://$deployedHost/ws/patientoncall/${patientUser!.username}/')
  );
}


// AUTH TOKEN REFRESHING
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


// CUSTOM OVERLAY
final overlay = CustomOverlay();

const homeIcon = HomeIcon();

final medicalHistoryTitle = MedicalHistoryTitle();

final medicationTitle = MedicationTitle();

const diaryPageTitle = DiaryPageTitle();

var firstRender = true;

final homePage = HomePage();

final loginPage = LoginPage();

final MedicationNotifier medicationNotifier = MedicationNotifier(patientData!.medication);

final HospitalVisitNotifier mhNotifier = HospitalVisitNotifier(patientData!.medical_history);

Map<String, Pair<String,String>> hosps = {'1': Pair('St Mary Hospital', '25/4/2023'), '2': Pair('St John Hospital', '26/4/2023')};

Map<String, Widget> medAccIncEntries = {};
Map<String, bool> medAccIncVisibility = {'1': true, '2': true};

Map<String, Widget> idToHospVisitDet = {};

List<String> letterFilePaths = [];
List<String> scanFilePaths = [];
List<String> labFilePaths = [];

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
  print('fetching token');
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

List<Widget> showMedicalHistory(List<HealthcareHistoryDataEntry> data, BuildContext context, bool editMode) {
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
  for (var entry in data) {
    widgets.add(VisibilityTile(data: entry, editMode: editMode));
    widgets.add(SizedBox(height: 10,));
  }
  return widgets;
}

List<TableRow> showMedications(List<MedicationEntry> data, BuildContext context) {
  List<TableRow> tableRow = [];
  for (var entry in data) {
    tableRow.add(TableRow(
      children: [
        TableCell(
          child: Text(entry.drug, textAlign: TextAlign.center,),
        ),
        TableCell(
          child: Text(entry.dosage, textAlign: TextAlign.center,),
        ),
        TableCell(
          child: InkWell(
            onTap: () {
              // Handle button tap here
              // Navigate to another page

            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  // Handle button tap here if needed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FullMedicationPage(fullData: entry)),
                  );
                },
                child: Text('More Info'),
              ),
            ),
          ),
        ),
      ],
    ),);
  }
  return tableRow;
}

List<Widget> showDiaryList(Map<String, Pair<String, String>> data, BuildContext context) {
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
          flex: 12,
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
  for (var entry in data.entries) {
    widgets.add(TwoInfoTile(data1: entry.value.first, data2: entry.value.second, id : entry.key));
    widgets.add(const SizedBox(height: 10,));
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
  channel!.sink.add(json);
  toHide.clear();
}

// denies access to server
void denyAccess() {
  Map<String, dynamic> data = {};
  data['event'] = 'DENY_PATIENT_DATA_ACCESS';
  final json = jsonEncode(data);
  print(data);
  channel!.sink.add(json);
  toHide.clear();
}

// denies access to server
void revokeAccess() {
  Map<String, dynamic> data = {};
  data['event'] = 'REVOKE_PATIENT_DATA_ACCESS';
  final json = jsonEncode(data);
  print(data);
  channel!.sink.add(json);
  toHide.clear();
}

void submitNewDiaryEntry(DateTime date, String content) {
  Map<String, dynamic> data = {};
  data['event'] = 'NEW_DIARY_ENTRY';
  data['date'] = date.date.toString();
  data['content'] = content;
  data['patientId'] = patientData!.patient_id;
  final json = jsonEncode(data);
  channel!.sink.add(json);
}

void submitNewMedicationEntry(String drug, String dosage, DateTime startDate, String duration, String route, String comments) {
  Map<String, dynamic> data = {};
  data['event'] = 'NEW_MEDICATION_ENTRY';
  data['drug'] = drug;
  data['dosage'] = dosage;
  data['startDate'] = startDate.date.toString();
  data['duration'] = duration;
  data['route'] = route;
  data['comments'] = comments;
  data['patientId'] = patientData!.patient_id;
  final json = jsonEncode(data);
  channel!.sink.add(json);
  // patientData?.setNewMedication(json);
  // medicationNotifier.updateMedication(patientData!.medication);
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

Future askRequiredPermission() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
    Permission.manageExternalStorage,
    Permission.accessMediaLocation
  ].request();
}

void download(String url) async {

  List<String> splitted = url.split('/');
  String path = splitted.last;

  String downloadDirPath;
  if (Platform.isAndroid) {
    // For Android, use the getExternalStorageDirectory() method
    final directory = await getExternalStorageDirectory();
    downloadDirPath = directory!.path;
  } else if (Platform.isIOS) {
    // For iOS, use the getApplicationDocumentsDirectory() method
    final directory = await getApplicationDocumentsDirectory();
    downloadDirPath = directory.path;
  } else {
    downloadDirPath = '';
  }

  Dio dio = Dio();
  await dio.download(url, "$downloadDirPath/$path");

  // opens the file
  OpenFile.open("$downloadDirPath/$path", type: 'application/pdf');
}

addHospVisitEntry(String filePath, HealthcareHistoryDataEntry newMedHis) async {
  var postUri = Uri.parse('$autoUrl/api/patient-data/patient-add-visit/');
  Map<String, String> headers = {'Authorization': 'Bearer ${patientUser!.access}',
  "Content-Type": "multipart/form-data"};
  var request = http.MultipartRequest("POST", postUri);
  request.headers.addAll(headers);
  request.fields['patient-id'] = patientData!.patient_id.toString();
  request.fields['admissionDate'] = newMedHis.admissionDate;
  request.fields['dischargeDate'] = newMedHis.dischargeDate;
  request.fields['summary'] = newMedHis.summary;
  request.fields['consultant'] = newMedHis.consultant;
  request.fields['visitType'] = newMedHis.visitType;
  request.fields['addToMedicalHistory'] = newMedHis.addToMedicalHistory ? 'on' : 'off';

  letterFilePaths.clear();

  request.files.add(await http.MultipartFile.fromPath(
      'letter', filePath));
  print(request.fields);
  request.send().then((response) {
    if (response.statusCode == 201) {
      print("Uploaded!");
      Map<String, dynamic> data = {};
      data['event'] = 'NEW_HOSP_VISIT_ENTRY';
      data['patientId'] = patientData!.patient_id;
      final json = jsonEncode(data);
      channel!.sink.add(json);
    } else {
      print("TT file upload failed");
    }
  });
}