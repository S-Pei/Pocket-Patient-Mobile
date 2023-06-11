// OBJECT CLASSES
import 'package:dartx/dartx.dart';

class Patient {
    final String first_name;
    final String last_name;
    final String dob;
    final String patient_address;
    final List<HealthcareHistoryDataEntry> medical_history;

    Patient({
      required this.first_name,
      required this.last_name,
      required this.dob,
      required this.patient_address,
      required this.medical_history
    });

    factory Patient.fromJson(Map<String, dynamic> json) {
      var list = json['medical-history'];
      List<HealthcareHistoryDataEntry> mh_list = list.map<HealthcareHistoryDataEntry>((mh) => HealthcareHistoryDataEntry.fromDic(mh)).toList();
      return Patient(
        first_name: json['patient-first-name'],
        last_name: json['patient-last-name'],
        dob: json['patient-dob'],
        patient_address: json['patient-address'],
        medical_history: mh_list,
      );
    }

    Map<String, Pair<String, String>> getMedHisSummary() {
      print('medical history: ${medical_history}');
      Map<String, Pair<String, String>> data = {};
      for (var mh in medical_history) {
        if (mh.addToMedicalHistory) {
          data[mh.id] = Pair(mh.admissionDate, mh.summary);
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

  @override
    String toString() {
      return '{ ${first_name}, ${last_name}, ${medical_history}}';
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
