class PatientModel {
  String? status;
  List<Patient>? patients;

  PatientModel({this.status, this.patients});

  PatientModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['patients'] != null) {
      patients = <Patient>[];
      json['patients'].forEach((v) {
        patients!.add(Patient.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (patients != null) {
      data['patients'] = patients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Patient {
  int? id;
  String? patientFullname;
  String? patientPhone;
  String? patientAddress;
  String? patientGender;
  String? patientStatus;
  int? doctorId;
  String? patientCreatedAt;
  Doctor? doctor;
  List<Visits>? visits;

  Patient(
      {this.id,
      this.patientFullname,
      this.patientPhone,
      this.patientAddress,
      this.patientGender,
      this.patientStatus,
      this.doctorId,
      this.patientCreatedAt,
      this.doctor,
      this.visits});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientFullname = json['patient_fullname'];
    patientPhone = json['patient_phone'];
    patientAddress = json['patient_address'];
    patientGender = json['patient_gender'];
    patientStatus = json['patient_status'];
    doctorId = json['doctor_id'];
    patientCreatedAt = json['patient_created_at'];
    doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    if (json['visits'] != null) {
      visits = <Visits>[];
      json['visits'].forEach((v) {
        visits!.add(Visits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['patient_fullname'] = patientFullname;
    data['patient_phone'] = patientPhone;
    data['patient_address'] = patientAddress;
    data['patient_gender'] = patientGender;
    data['patient_status'] = patientStatus;
    data['doctor_id'] = doctorId;
    data['patient_created_at'] = patientCreatedAt;
    if (doctor != null) {
      data['doctor'] = doctor!.toJson();
    }
    if (visits != null) {
      data['visits'] = visits!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return patientFullname!;
  }
}

class Doctor {
  int? id;
  String? doctorFullname;
  String? doctorPhone;
  String? doctorHospital;
  String? doctorOrderNum;
  String? doctorStatus;
  String? doctorCreatedAt;

  Doctor(
      {this.id,
      this.doctorFullname,
      this.doctorPhone,
      this.doctorHospital,
      this.doctorOrderNum,
      this.doctorStatus,
      this.doctorCreatedAt});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorFullname = json['doctor_fullname'];
    doctorPhone = json['doctor_phone'];
    doctorHospital = json['doctor_hospital'];
    doctorOrderNum = json['doctor_order_num'];
    doctorStatus = json['doctor_status'];
    doctorCreatedAt = json['doctor_created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['doctor_fullname'] = doctorFullname;
    data['doctor_phone'] = doctorPhone;
    data['doctor_hospital'] = doctorHospital;
    data['doctor_order_num'] = doctorOrderNum;
    data['doctor_status'] = doctorStatus;
    data['doctor_created_at'] = doctorCreatedAt;
    return data;
  }
}

class Visits {
  int? id;
  String? visitDate;
  int? patientId;
  int? nurseId;
  String? visitStatus;
  String? visitCreatedAt;
  List<Treatment>? treatments;

  Visits(
      {this.id,
      this.visitDate,
      this.patientId,
      this.nurseId,
      this.visitStatus,
      this.visitCreatedAt,
      this.treatments});

  Visits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    visitDate = json['visit_date'];
    patientId = json['patient_id'];
    nurseId = json['nurse_id'];
    visitStatus = json['visit_status'];
    visitCreatedAt = json['visit_created_at'];
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
    data['visit_status'] = visitStatus;
    data['visit_created_at'] = visitCreatedAt;
    if (treatments != null) {
      data['treatments'] = treatments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Treatment {
  int? id;
  String? patientTreatmentLibelle;
  String? patientTreatmentStatus;
  int? visitId;
  String? patientTreatmentCreatedAt;

  Treatment(
      {this.id,
      this.patientTreatmentLibelle,
      this.patientTreatmentStatus,
      this.visitId,
      this.patientTreatmentCreatedAt});

  Treatment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientTreatmentLibelle = json['patient_treatment_libelle'];
    patientTreatmentStatus = json['patient_treatment_status'];
    visitId = json['visit_id'];
    patientTreatmentCreatedAt = json['patient_treatment_created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['patient_treatment_libelle'] = patientTreatmentLibelle;
    data['patient_treatment_status'] = patientTreatmentStatus;
    data['visit_id'] = visitId;
    data['patient_treatment_created_at'] = patientTreatmentCreatedAt;
    return data;
  }
}
