// OBJECT CLASSES
class Patient {
    final String first_name;
    final String last_name;
    final List<MedicalHistoryEntry> medical_history;

    Patient({
      required this.first_name,
      required this.last_name,
      required this.medical_history
    });

    factory Patient.fromJson(Map<String, dynamic> json) {
      var list = json['medical-history'];
      List<MedicalHistoryEntry> mh_list = list.map<MedicalHistoryEntry>((mh) => MedicalHistoryEntry.fromDic(mh)).toList();
      return Patient(
        first_name: json['patient-first-name'],
        last_name: json['patient-last-name'],
        medical_history: mh_list,
      );
  } 
  @override
    String toString() {
      return '{ ${this.first_name}, ${this.last_name}, ${this.medical_history}}';
    }
  
}

  class MedicalHistoryEntry {
    final String date;
    final String summary;

    MedicalHistoryEntry({
      required this.date,
      required this.summary
    });

    factory MedicalHistoryEntry.fromDic(Map<String, dynamic> dic) {
      return MedicalHistoryEntry(
        date: dic['date'],
        summary: dic['summary']
      );
    }
    @override
    String toString() {
      return '{ ${this.date}, ${this.summary}}';
    }
  }