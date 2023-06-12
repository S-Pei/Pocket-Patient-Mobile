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
    final List<HealthcareHistoryDataEntry> medical_history;

    Patient({
      required this.patient_id,
      required this.patient_name,
      required this.first_name,
      required this.last_name,
      required this.dob,
      required this.patient_address,
      required this.medical_history,
      required this.medication
    });

    factory Patient.fromJson(Map<String, dynamic> json) {
      var medicalHistoryList = json['medical-history'];
      var medicationList = json['current-medication'];
      List<HealthcareHistoryDataEntry> mh_list = medicalHistoryList.map<HealthcareHistoryDataEntry>((mh) => HealthcareHistoryDataEntry.fromDic(mh)).toList();
      List<MedicationEntry> cm_list = medicationList.map<MedicationEntry>((cm) => MedicationEntry.fromDic(cm)).toList();
      return Patient(
        patient_id: json['patient-id'],
        patient_name: json['patient-name-small'],
        first_name: json['patient-first-name'],
        last_name: json['patient-last-name'],
        dob: json['patient-dob'],
        patient_address: json['patient-address'],
        medical_history: mh_list,
        medication: cm_list
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

  @override
    String toString() {
      return '{ ${first_name}, ${last_name}, ${medical_history}}';
    }
}

class MedicalHistoryEntry {
  final String id;
  final String admissionDate;
  final String dischargeDate;
  final String consultant;
  final String summary;
  final String visitType;
  final String? letterUrl;

  MedicalHistoryEntry({
    required this.id,
    required this.admissionDate,
    required this.dischargeDate,
    required this.consultant,
    required this.visitType,
    this.letterUrl,
    required this.summary
  });

  factory MedicalHistoryEntry.fromDic(Map<String, dynamic> dic) {
    return MedicalHistoryEntry(
      id: dic['id'],
      admissionDate: dic['admissionDate'],
      dischargeDate: dic['dischargeDate'],
      consultant: dic['consultant'],
      visitType: dic['visitType'],
      letterUrl: dic['letter'],
      summary: dic['summary']
    );
  }

  @override
  String toString() {
    return '{ ${admissionDate} : ${summary}}';
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
