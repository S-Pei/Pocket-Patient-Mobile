// OBJECT CLASSES
import 'dart:convert';

import 'package:dartx/dartx.dart';
import 'package:patient_mobile_app/resources/globals.dart';

class Patient {
    final int patient_id;
    final String patient_name;
    final String first_name;
    final String last_name;
    final String dob;
    final String patient_address;
    List<MedicationEntry> medication;
    final Map<String, List<DiaryEntry>> diaryClass;
    List<HealthcareHistoryDataEntry> medical_history;
    List<LabHistoryDataEntry> lab_history;
    List<ImagingHistoryDataEntry> imaging_history;

    Patient({
      required this.patient_id,
      required this.patient_name,
      required this.first_name,
      required this.last_name,
      required this.dob,
      required this.patient_address,
      required this.medical_history,
      required this.medication,
      required this.diaryClass,
      required this.lab_history,
      required this.imaging_history
    });

    factory Patient.fromJson(Map<String, dynamic> json) {
      var medicalHistoryList = json['medical-history'];
      var medicationList = json['current-medication'];
      var labHistoryList = json['lab-history'];
      var imagingHistoryList = json['imaging-history'];
      var diaryMapClass = json['diary-info'];
      var diaryKeys = diaryMapClass.keys.toList();
      List<LabHistoryDataEntry> lhList = labHistoryList.map<LabHistoryDataEntry>((lh)
        => LabHistoryDataEntry.fromDict(lh)).toList();
      List<ImagingHistoryDataEntry> imList = imagingHistoryList.map<ImagingHistoryDataEntry>((im)
        => ImagingHistoryDataEntry.fromDict(im)).toList();
      List<HealthcareHistoryDataEntry> mhList = medicalHistoryList.map<HealthcareHistoryDataEntry>((mh)
        => HealthcareHistoryDataEntry.fromDic(mh, lhList, imList)).toList();
      List<MedicationEntry> cmList = medicationList.map<MedicationEntry>((cm) => MedicationEntry.fromDic(cm)).toList();
      Map<String, List<DiaryEntry>> drMap = {};
      diaryKeys.map((dk)
      {
        var value = diaryMapClass[dk];
        drMap[dk] = value.map<DiaryEntry>((cm) => DiaryEntry.fromDic(cm)).toList();
      }
      ).toList();
      return Patient(
        patient_id: json['patient-id'],
        patient_name: json['patient-name-small'],
        first_name: json['patient-first-name'],
        last_name: json['patient-last-name'],
        dob: json['patient-dob'],
        patient_address: json['patient-address'],
        medical_history: mhList,
        medication: cmList,
        diaryClass: drMap,
        lab_history: lhList,
        imaging_history: imList
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

    List<DiaryEntry>? getDiaryEntries(String category) {
      return diaryClass[category];
    }

    void addNewDiaryEntry(String category, DateTime date, String content) {
      String dateStr = date.toString().split(" ")[0];
      diaryClass[category]?.add(DiaryEntry(date: dateStr, content: content));
    }

    bool changeDiaryState() {
      diaryState = !diaryState;
      return diaryState;
    }

    void addNewDiaryCategory(String category) {
      diaryClass[category] = [];
    }

    bool changeCategoryState() {
      categoryState = !categoryState;
      return categoryState;
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

    bool deleteMedication(medicationId) {
      for (var med in medication) {
        if (med.id == medicationId) {
          medication.remove(med);
          return true;
        }
      }
      return false;
    }

    void setNewMedicalHistory(medicalHistoryList) {
      // print("print medHis: ");
      // print(medical_history);
      // print("print medication list: ");
      List<HealthcareHistoryDataEntry> mhList = medicalHistoryList.map<HealthcareHistoryDataEntry>((mh)
        => HealthcareHistoryDataEntry.fromDic(mh, lab_history, imaging_history)).toList();
      // print("print mh list: ");
      // print(mhList);
      medical_history = mhList;
    }

    void addNewLabHistory(Map<String, dynamic> labHistoryDict) {
      LabHistoryDataEntry newLabEntry = LabHistoryDataEntry.fromDict(labHistoryDict);
      lab_history.add(newLabEntry);
    }

    void addNewImagingHistory(Map<String, dynamic> imagingHistoryDict) {
      ImagingHistoryDataEntry newImagingEntry = ImagingHistoryDataEntry.fromDict(imagingHistoryDict);
      imaging_history.add(newImagingEntry);
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
  final bool byPatient;

  MedicationEntry({
    required this.id,
    required this.drug,
    required this.dosage,
    required this.startDate,
    required this.endDate,
    required this.duration,
    required this.route,
    required this.comments,
    required this.byPatient
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
        comments: dic['comments'],
        byPatient: dic['byPatient']
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

  @override
  String toString() {
    // TODO: implement toString
    return "${date}: ${content}\n";
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
    final String labUrl;
    final String imagingUrl;

    HealthcareHistoryDataEntry({
      required this.id,
      required this.admissionDate,
      required this.dischargeDate,
      required this.consultant,
      required this.visitType,
      this.letterUrl,
      required this.summary,
      required this.addToMedicalHistory,
      required this.labUrl,
      required this.imagingUrl
    });

    factory HealthcareHistoryDataEntry.fromDic(Map<String, dynamic> dic, List<LabHistoryDataEntry>? lhList, List<ImagingHistoryDataEntry>? imList) {
      String labUrl = '';
      String imagingUrl = '';
      for (var lh in lhList ?? patientData!.lab_history) {
        if (lh.visitEntry == dic['id']) { labUrl = lh.labReportUrl; }
      }
      for (var im in imList ?? patientData!.imaging_history) {
        if (im.visitEntry == dic['id']) { imagingUrl = im.report; }
      }

      return HealthcareHistoryDataEntry(
        id: dic['id'],
        admissionDate: dic['admissionDate'],
        dischargeDate: dic['dischargeDate'],
        consultant: dic['consultant'],
        visitType: dic['visitType'],
        letterUrl: dic['letter'],
        summary: dic['summary'],
        addToMedicalHistory: dic['addToMedicalHistory'],
        labUrl: labUrl,
        imagingUrl: imagingUrl
      );
    }

    @override
    String toString() {
      return '{ ${admissionDate} : ${summary}}';
    }
  }

class LabHistoryDataEntry {
  final String id;
  final String date;
  final String labType;
  final String labReportUrl;
  final String visitEntry;

  LabHistoryDataEntry({
    required this.id,
    required this.date,
    required this.labType,
    required this.labReportUrl,
    required this.visitEntry
  });

  factory LabHistoryDataEntry.fromDict(Map<String, dynamic> lh) {
    return LabHistoryDataEntry(
        id: lh['id'],
        date: lh['date'],
        labType: lh['labType'],
        labReportUrl: lh['report'],
        visitEntry: lh['visitEntry']
    );
  }
}

class ImagingHistoryDataEntry {
  final String id;
  final String date;
  final String scanType;
  final String region;
  final String indication;
  final String report;
  final String visitEntry;


  ImagingHistoryDataEntry({
    required this.id,
    required this.date,
    required this.scanType,
    required this.region,
    required this.indication,
    required this.report,
    required this.visitEntry
  });

  factory ImagingHistoryDataEntry.fromDict(Map<String, dynamic> lh) {
    return ImagingHistoryDataEntry(
        id: lh['id'],
        date: lh['date'],
        scanType: lh['scanType'],
        region: lh['region'],
        indication: lh['indication'],
        report: lh['report'],
        visitEntry: lh['visitEntry']
    );
  }
}