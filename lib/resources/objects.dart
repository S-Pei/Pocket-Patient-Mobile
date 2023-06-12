// OBJECT CLASSES
import 'package:dartx/dartx.dart';

class Patient {
    final int patient_id;
    final String patient_name;
    final String first_name;
    final String last_name;
    final String dob;
    final String patient_address;
    final List<MedicalHistoryEntry> medical_history;
    final List<MedicationEntry> medication;
    final List<DiaryEntry> diary;

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
      List<MedicalHistoryEntry> mhList = medicalHistoryList.map<MedicalHistoryEntry>((mh) => MedicalHistoryEntry.fromDic(mh)).toList();
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

    Map<String, Pair<String, String>> getMedHisSummary() {
      Map<String, Pair<String, String>> data = {};
      for (var mh in medical_history) {
        data[mh.id] = Pair(mh.admissionDate, mh.summary);
      }
      return data;
    }

    List<Pair<String, String>> getDiaryEntries() {
      List<Pair<String, String>> data = [];
      for (var dr in diary) {
        data.add(Pair(dr.date, dr.content));
      }
      return data;
    }

    // Map<String, Pair<String, String>> getMedicationBasics() {
    //   Map<String, Pair<String, String>> data = {};
    //   for (var cm in medication) {
    //     data[cm.id] = Pair(cm.drug, cm.dosage);
    //   }
    //   return data;
    // }

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