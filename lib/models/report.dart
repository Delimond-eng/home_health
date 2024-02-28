import 'nurse.dart';
import 'schedule.dart';

class ReportModel {
  String? status;
  List<Report>? reports;

  ReportModel({this.status, this.reports});

  ReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['reports'] != null) {
      reports = <Report>[];
      json['reports'].forEach((v) {
        reports!.add(Report.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (reports != null) {
      data['reports'] = reports!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Report {
  int? id;
  int? visitId;
  int? nurseId;
  int? doctorId;
  String? reportStatus;
  String? reportCreatedAt;
  Nurse? nurse;
  Visit? visit;

  Report({
    this.id,
    this.visitId,
    this.nurseId,
    this.doctorId,
    this.reportStatus,
    this.reportCreatedAt,
    this.nurse,
    this.visit,
  });

  Report.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    visitId = json['visit_id'];
    nurseId = json['nurse_id'];
    doctorId = json['doctor_id'];
    reportStatus = json['report_status'];
    reportCreatedAt = json['report_created_at'];
    nurse = json['nurse'] != null ? Nurse.fromJson(json['nurse']) : null;
    visit = json['visit'] != null ? Visit.fromJson(json['visit']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['visit_id'] = visitId;
    data['nurse_id'] = nurseId;
    data['doctor_id'] = doctorId;
    data['report_status'] = reportStatus;
    data['report_created_at'] = reportCreatedAt;
    if (nurse != null) {
      data['nurse'] = nurse!.toJson();
    }
    if (visit != null) {
      data['visit'] = visit!.toJson();
    }
    return data;
  }
}
