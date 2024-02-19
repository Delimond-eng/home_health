import 'nurse.dart';
import 'patient.dart';

class VisitModel {
  String? status;
  List<Visit>? visits;

  VisitModel({this.status, this.visits});

  VisitModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['visits'] != null) {
      visits = <Visit>[];
      json['visits'].forEach((v) {
        visits!.add(Visit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (visits != null) {
      data['visits'] = visits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Visit {
  int? id;
  String? visitDate;
  int? patientId;
  int? nurseId;
  int? doctorId;
  String? visitStatus;
  String? visitCreatedAt;
  Nurse? nurse;
  Patient? patient;
  List<Treatment>? treatments;

  Visit(
      {this.id,
      this.visitDate,
      this.patientId,
      this.nurseId,
      this.doctorId,
      this.visitStatus,
      this.visitCreatedAt,
      this.nurse,
      this.patient,
      this.treatments});

  Visit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    visitDate = json['visit_date'];
    patientId = json['patient_id'];
    nurseId = json['nurse_id'];
    doctorId = json['doctor_id'];
    visitStatus = json['visit_status'];
    visitCreatedAt = json['visit_created_at'];
    nurse = json['nurse'] != null ? Nurse.fromJson(json['nurse']) : null;
    patient =
        json['patient'] != null ? Patient.fromJson(json['patient']) : null;
    if (json['treatments'] != null) {
      treatments = <Treatment>[];
      json['treatments'].forEach((v) {
        treatments!.add(Treatment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['visit_date'] = visitDate;
    data['patient_id'] = patientId;
    data['nurse_id'] = nurseId;
    data['doctor_id'] = doctorId;
    data['visit_status'] = visitStatus;
    data['visit_created_at'] = visitCreatedAt;
    if (nurse != null) {
      data['nurse'] = nurse!.toJson();
    }
    if (patient != null) {
      data['patient'] = patient!.toJson();
    }
    if (treatments != null) {
      data['treatments'] = treatments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
