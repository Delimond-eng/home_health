import 'nurse.dart';
import 'schedule.dart';

class NurseHomeModel {
  String? status;
  Response? response;

  NurseHomeModel({this.status, this.response});

  NurseHomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response =
        json['response'] != null ? Response.fromJson(json['response']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (response != null) {
      data['response'] = response!.toJson();
    }
    return data;
  }
}

class Response {
  List<Delegate>? delegates;
  List<Visit>? visits;

  Response({this.visits});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['delegates'] != null) {
      delegates = <Delegate>[];
      json['delegates'].forEach((v) {
        delegates!.add(Delegate.fromJson(v));
      });
    }
    if (json['visits'] != null) {
      visits = <Visit>[];
      json['visits'].forEach((v) {
        visits!.add(Visit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (delegates != null) {
      data['delegates'] = delegates!.map((v) => v.toJson()).toList();
    }
    if (visits != null) {
      data['visits'] = visits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Delegate {
  int? id;
  int? delegateNurseId;
  int? visitId;
  String? visitDelegateStatus;
  String? visitDelegateCreatedAt;
  Nurse? nurseDelegate;
  Visit? visit;

  Delegate(
      {this.id,
      this.delegateNurseId,
      this.visitId,
      this.visitDelegateStatus,
      this.visitDelegateCreatedAt,
      this.nurseDelegate,
      this.visit});

  Delegate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    delegateNurseId = json['delegate_nurse_id'];
    visitId = json['visit_id'];
    visitDelegateStatus = json['visit_delegate_status'];
    visitDelegateCreatedAt = json['visit_delegate_created_at'];
    nurseDelegate = json['nurse_delegate'] != null
        ? Nurse.fromJson(json['nurse_delegate'])
        : null;
    visit = json['visit'] != null ? Visit.fromJson(json['visit']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['delegate_nurse_id'] = delegateNurseId;
    data['visit_id'] = visitId;
    data['visit_delegate_status'] = visitDelegateStatus;
    data['visit_delegate_created_at'] = visitDelegateCreatedAt;
    if (nurseDelegate != null) {
      data['nurse_delegate'] = nurseDelegate!.toJson();
    }
    if (visit != null) {
      data['visit'] = visit!.toJson();
    }
    return data;
  }
}
