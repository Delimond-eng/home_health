class NurseModel {
  String? status;
  List<Nurse>? nurses;

  NurseModel({this.status, this.nurses});

  NurseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['nurses'] != null) {
      nurses = <Nurse>[];
      json['nurses'].forEach((v) {
        nurses!.add(Nurse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (nurses != null) {
      data['nurses'] = nurses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Nurse {
  int? id;
  String? nurseFullname;
  String? nursePhone;
  String? nurseStatus;
  String? nurseCreatedAt;
  int? doctorId;
  User? user;
  Doctor? doctor;
  List<Visits>? visits;

  Nurse(
      {this.id,
      this.nurseFullname,
      this.nursePhone,
      this.nurseStatus,
      this.nurseCreatedAt,
      this.doctorId,
      this.user,
      this.doctor,
      this.visits});

  Nurse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nurseFullname = json['nurse_fullname'];
    nursePhone = json['nurse_phone'];
    nurseStatus = json['nurse_status'];
    nurseCreatedAt = json['nurse_created_at'];
    doctorId = json['doctor_id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
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
    data['nurse_fullname'] = nurseFullname;
    data['nurse_phone'] = nursePhone;
    data['nurse_status'] = nurseStatus;
    data['nurse_created_at'] = nurseCreatedAt;
    data['doctor_id'] = doctorId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (doctor != null) {
      data['doctor'] = doctor!.toJson();
    }
    if (visits != null) {
      data['visits'] = visits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? email;
  String? password;
  int? profileId;
  String? profileType;
  String? userCreatedAt;

  User(
      {this.id,
      this.email,
      this.password,
      this.profileId,
      this.profileType,
      this.userCreatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    profileId = json['profile_id'];
    profileType = json['profile_type'];
    userCreatedAt = json['user_created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['password'] = password;
    data['profile_id'] = profileId;
    data['profile_type'] = profileType;
    data['user_created_at'] = userCreatedAt;
    return data;
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
  Patient? patient;

  Visits(
      {this.id,
      this.visitDate,
      this.patientId,
      this.nurseId,
      this.visitStatus,
      this.visitCreatedAt,
      this.patient});

  Visits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    visitDate = json['visit_date'];
    patientId = json['patient_id'];
    nurseId = json['nurse_id'];
    visitStatus = json['visit_status'];
    visitCreatedAt = json['visit_created_at'];
    patient =
        json['patient'] != null ? Patient.fromJson(json['patient']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['visit_date'] = visitDate;
    data['patient_id'] = patientId;
    data['nurse_id'] = nurseId;
    data['visit_status'] = visitStatus;
    data['visit_created_at'] = visitCreatedAt;
    if (patient != null) {
      data['patient'] = patient!.toJson();
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

  Patient(
      {this.id,
      this.patientFullname,
      this.patientPhone,
      this.patientAddress,
      this.patientGender,
      this.patientStatus,
      this.doctorId,
      this.patientCreatedAt});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientFullname = json['patient_fullname'];
    patientPhone = json['patient_phone'];
    patientAddress = json['patient_address'];
    patientGender = json['patient_gender'];
    patientStatus = json['patient_status'];
    doctorId = json['doctor_id'];
    patientCreatedAt = json['patient_created_at'];
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
    return data;
  }
}
