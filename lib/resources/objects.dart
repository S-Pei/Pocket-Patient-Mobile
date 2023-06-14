// OBJECT CLASSES
import 'dart:convert';

import 'package:dartx/dartx.dart';

class Patient {
    final int patient_id;
    final String patient_name;
    final String first_name;
    final String last_name;
    final String dob;
    final String patient_address;
    List<MedicationEntry> medication;
    final List<DiaryEntry> diary;
    List<HealthcareHistoryDataEntry> medical_history;

    Patient({
      required this.patient_id,
      required this.patient_name,
      required this.first_name,
      required this.last_name,
      required this.dob,
      required this.patient_address,
      required this.medical_history,
      required this.medication,
      required this.diary,
    });

    factory Patient.fromJson(Map<String, dynamic> json) {
      var medicalHistoryList = json['medical-history'];
      var medicationList = json['current-medication'];
      var diarylist = json['diary'];
      List<HealthcareHistoryDataEntry> mhList = medicalHistoryList.map<HealthcareHistoryDataEntry>((mh) => HealthcareHistoryDataEntry.fromDic(mh)).toList();
      List<MedicationEntry> cmList = medicationList.map<MedicationEntry>((cm) => MedicationEntry.fromDic(cm)).toList();
      List<DiaryEntry> drList = diarylist.map<DiaryEntry>((dr) => DiaryEntry.fromDic(dr)).toList();
      return Patient(
        patient_id: json['patient-id'],
        patient_name: json['patient-name-small'],
        first_name: json['patient-first-name'],
        last_name: json['patient-last-name'],
        dob: json['patient-dob'],
        patient_address: json['patient-address'],
        medical_history: mhList,
        medication: cmList,
        diary: drList,
      );
    }

    List<HealthcareHistoryDataEntry> getMedHisSummary() {
     List<HealthcareHistoryDataEntry> data = [];
      for (var mh in medical_history) {
        if (mh.addToMedicalHistory) {
          data.add(mh);
        }
      }
      return data;
    }

    Map<String, Pair<String, String>> getDiarySummary() {
      Map<String, Pair<String, String>> data = {};
      var i = 0;
      for (var dr in diary) {
        data['$i'] = Pair(dr.date, dr.content);
        i++;
      }
      return data;
    }

    void addNewDiaryEntry(DateTime date, String content) {
      String dateStr = date.toString().split(" ")[0];
      diary.add(DiaryEntry(date: dateStr, content: content));
    }

    Map<String, HealthcareHistoryDataEntry> getHealthcareVisits() {
      print('healthcare visit history: ${medical_history}');
      Map<String, HealthcareHistoryDataEntry> data = {};
      for (var mh in medical_history) {
          data[mh.id] = mh;
      }
      return data;
    }

    void setNewMedication(medication) {
      print("print medication: ");
      print(medication);
      var medicationList = jsonDecode(medication);
      print("print medication list: ");
      print(medicationList);
      List<MedicationEntry> cm_list = medicationList.map<MedicationEntry>((cm) => MedicationEntry.fromDic(cm)).toList();
      print("print cm list: ");
      print(cm_list);
      this.medication = cm_list;
    }

    void setNewMedicalHistory(medicalHistoryList) {
      print("print medHis: ");
      print(medical_history);
      print("print medication list: ");
      List<HealthcareHistoryDataEntry> mhList = medicalHistoryList.map<HealthcareHistoryDataEntry>((mh) => HealthcareHistoryDataEntry.fromDic(mh)).toList();
      print("print mh list: ");
      print(mhList);
      this.medical_history = mhList;
    }


  @override
    String toString() {
      return '{ ${first_name}, ${last_name}, ${medical_history}}';
    }
}

class MedicationEntry {
  final String id;
  final String drug;
  final String dosage;
  final String startDate;
  final String endDate;
  final String duration;
  final String route;
  final String comments;

  MedicationEntry({
    required this.id,
    required this.drug,
    required this.dosage,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.route,
    required this.comments,
  });

  factory MedicationEntry.fromDic(Map<String, dynamic> dic) {
    return MedicationEntry(
        id: dic['id'],
        drug: dic['drug'],
        dosage: dic['dosage'],
        startDate: dic['startDate'],
        endDate: dic['endDate'],
        duration: dic['duration'],
        route: dic['route'],
        comments: dic['comments']
    );
  }

  @override
  String toString() {
    return '{ ${drug} : ${dosage}}';
  }
}

class DiaryEntry {
  final String date;
  final String content;

  DiaryEntry({
    required this.date,
    required this.content,
  });

  factory DiaryEntry.fromDic(Map<String, dynamic> dic) {
    return DiaryEntry(
      date: dic['date'],
      content: dic['content']);
  }
}

class PatientUser {
  String username;
  String refresh;
  String access;

  PatientUser({
    required this.username,
    required this.refresh,
    required this.access
  });

  factory PatientUser.fromJson(String username, Map<String, dynamic> json) {
    String refresh = json['refresh']!;
    String access = json['access']!;
    return PatientUser(username: username, refresh: refresh, access: access);
  }

  void refreshToken(String access, String refresh) {
    this.refresh = refresh;
    this.access = access;
  }
}

  class HealthcareHistoryDataEntry {
    final String id;
    final String admissionDate;
    final String dischargeDate;
    final String consultant;
    final String summary;
    final String visitType;
    final String? letterUrl;
    final bool addToMedicalHistory;

    HealthcareHistoryDataEntry({
      required this.id,
      required this.admissionDate,
      required this.dischargeDate,
      required this.consultant,
      required this.visitType,
      this.letterUrl,
      required this.summary,
      required this.addToMedicalHistory
    });

    factory HealthcareHistoryDataEntry.fromDic(Map<String, dynamic> dic) {
      return HealthcareHistoryDataEntry(
        id: dic['id'],
        admissionDate: dic['admissionDate'],
        dischargeDate: dic['dischargeDate'],
        consultant: dic['consultant'],
        visitType: dic['visitType'],
        letterUrl: dic['letter'],
        summary: dic['summary'],
        addToMedicalHistory: dic['addToMedicalHistory']
      );
    }

    @override
    String toString() {
      return '{ ${admissionDate} : ${summary}}';
    }
  }
