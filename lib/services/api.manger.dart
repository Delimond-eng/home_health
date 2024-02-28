import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:home_health/global/controllers.dart';
import 'package:home_health/global/storage.dart';
import 'package:home_health/models/nurse_home.dart';
import 'package:home_health/services/api.dart';

import '../models/nurse.dart';
import '../models/patient.dart';
import '../models/schedule.dart';

class ApiManager {
  /// Make login and return result
  static Future login({Map<String, dynamic>? data}) async {
    var res = await Api.request("/login", method: "post", body: {
      "email": data!["email"],
      "password": data["pwd"],
    });
    if (res == null) {
      return null;
    }
    if (res.containsKey("errors")) {
      EasyLoading.showInfo(res["errors"].toString());
      return null;
    }
    if (res.containsKey("status")) {
      storage.write("user-data", res["user"]);
      authController.init();
      return res["user"];
    }
    return null;
  }

  ///Register doctor
  static Future registerDoctor({Map<String, dynamic>? data}) async {
    var res = await Api.request("/doctor.register", method: "post", body: {
      "email": data!["email"],
      "password": data["pwd"],
      "name": data["fullname"],
      "phone": data["phone"],
      "order_num": data["order_num"],
      "hospital": data["hospital"]
    });
    if (res.containsKey("errors")) {
      EasyLoading.showInfo(res["errors"].toString());
      return null;
    }
    if (res.containsKey("status")) {
      storage.write("user-data", res["doctor"]["user"]);
      authController.init();
      dataController.initDoctorData();
      return res["doctor"]["user"];
    } else {
      return null;
    }
  }

  ///Create nurse
  static Future createNurse({Map<String, dynamic>? data}) async {
    //Recupere la session de l'utilisateur courant !
    var user = authController.user.value;

    //Lance la requete d'enregistrement de l'infirmier
    var res = await Api.request("/nurse.create", method: "post", body: {
      "email": data!["email"],
      "password": data["pwd"],
      "name": data["fullname"],
      "phone": data["phone"],
      "doctor_id": user.id
    });
    if (res.containsKey("errors")) {
      EasyLoading.showInfo(res["errors"].toString());
      return null;
    }
    if (res.containsKey("status")) {
      dataController.initDoctorData();
      return res;
    } else {
      return null;
    }
  }

  //Permet au medecin de voir ses infirmiers créés dans le système
  static Future<NurseModel> viewAllNurseForDoctor() async {
    var data = NurseModel();
    var user = authController.user.value;
    var response = null;
    if (user.doctorId == null) {
      response = await Api.request("/nurses.all/${user.id}");
    } else {
      response = await Api.request("/nurses.all/${user.doctorId}/${user.id}");
    }
    if (response.containsKey("status")) {
      data = NurseModel.fromJson(response);
    }
    return data;
  }

  //Permet de creer un nouveau patient dans le systeme
  static Future createPatient({required Map<String, String> data}) async {
    //Recupere la session de l'utilisateur courant !
    var user = authController.user.value;

    //Lance la requete d'enregistrement de l'infirmier
    var res = await Api.request("/patient.create", method: "post", body: {
      "name": data["fullname"],
      "phone": data["phone"],
      "address": data["address"],
      "gender": data["gender"],
      "doctor_id": user.id
    });
    if (res.containsKey("errors")) {
      EasyLoading.showInfo(res["errors"].toString());
      return null;
    }
    if (res.containsKey("status")) {
      dataController.initDoctorData();
      return res;
    } else {
      return null;
    }
  }

  //Permet au medecin de voir ses patients créés dans le système
  static Future<PatientModel> viewAllPatientsForDoctor() async {
    var data = PatientModel();
    var user = authController.user.value;
    var response = await Api.request("/patients.all/${user.id}");
    if (response.containsKey("status")) {
      data = PatientModel.fromJson(response);
    }
    return data;
  }

  static Future createSchedule({Map<String, dynamic>? data}) async {
    //Recupere la session de l'utilisateur courant !
    var user = authController.user.value;

    //Lance la requete d'enregistrement de l'infirmier
    var res = await Api.request("/visit.create", method: "post", body: {
      "visit_date": data!["date"],
      "nurse_id": data["nurse_id"],
      "patient_id": data["patient_id"],
      "doctor_id": user.id,
      "treatments": data["treatments"]
    });
    if (res.containsKey("errors")) {
      EasyLoading.showInfo(res["errors"].toString());
      return null;
    }
    if (res.containsKey("status")) {
      dataController.initDoctorData();
      return res;
    } else {
      return null;
    }
  }

  static Future addTreatments({Map<String, dynamic>? data}) async {
    //Lance la requete d'enregistrement de l'infirmier
    var res = await Api.request("/treatments.add", method: "post", body: {
      "visit_id": data!["visit_id"],
      "treatments": data["treatments"]
    });
    if (res.containsKey("errors")) {
      EasyLoading.showInfo(res["errors"].toString());
      return null;
    }
    if (res.containsKey("status")) {
      nurseDataController.refreshSelectedVisitTreatments();
      return res;
    } else {
      return null;
    }
  }

  //Permet au medecin de voir toutes ses visites
  static Future<VisitModel> viewAllVisitsForDoctor({int? nurseId}) async {
    var data = VisitModel();
    var user = authController.user.value;
    var response = null;
    if (nurseId != null) {
      response = await Api.request("/doctor.visites/${user.id}/$nurseId");
    } else {
      response = await Api.request("/doctor.visites/${user.id}");
    }
    if (response != null) {
      if (response.containsKey("status")) {
        data = VisitModel.fromJson(response);
      }
    }
    return data;
  }

  //Permet à l'Infirmier d'avoir un accès à ses données d'accueil
  static Future<NurseHomeModel> viewNurseHomeData() async {
    var user = authController.user.value;
    var homeData = NurseHomeModel();
    var response = await Api.request("/nurse.agenda/${user.id}");
    if (response.containsKey("status")) {
      homeData = NurseHomeModel.fromJson(response);
    }
    return homeData;
  }

  static Future<List<Visit>> getNurseSchedule({String? date}) async {
    var user = authController.user.value;
    List<Visit> data = [];
    String selectedDate = "";
    if (date != null) {
      selectedDate = date;
    } else {
      var now = DateTime.now();
      selectedDate =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    }
    var response =
        await Api.request("/nurse.schedules/${user.id}/$selectedDate");
    if (response.containsKey("status")) {
      data = <Visit>[];
      response['schedules'].forEach((v) {
        data.add(Visit.fromJson(v));
      });
    }
    return data;
  }

  static Future<List<Treatment>> getTreatmentOfVisit({int? visitId}) async {
    List<Treatment> data = [];
    var response = await Api.request("/visit.treatments/$visitId");
    if (response.containsKey("status")) {
      data = <Treatment>[];
      response['treatments'].forEach((v) {
        data.add(Treatment.fromJson(v));
      });
    }
    return data;
  }

  static Future completVisit({Map<String, dynamic>? data}) async {
    //Recupere la session de l'utilisateur courant !
    var user = authController.user.value;

    //Lance la requete d'enregistrement de l'infirmier
    var res = await Api.request("/visit.validate", method: "post", body: {
      "visit_id": data!["visit_id"],
      "treatments": data["treatments"],
      "nurse_id": user.id
    });
    if (res.containsKey("errors")) {
      EasyLoading.showInfo(res["errors"].toString());
      return null;
    }
    if (res.containsKey("status")) {
      nurseDataController.viewHomeData();
      return res;
    } else {
      return null;
    }
  }

  //Deleguer une visite à un autre collègue infirmier
  static Future delegateVisit({Map<String, dynamic>? data}) async {
    //Lance la requete d'enregistrement de l'infirmier
    var res = await Api.request("/visit.delegate", method: "post", body: {
      "visit_id": data!['visit_id'],
      "nurse_id": data['nurse_id'],
    });
    if (res.containsKey("errors")) {
      EasyLoading.showInfo(res["errors"].toString());
      return null;
    }
    if (res.containsKey("status")) {
      nurseDataController.viewHomeData();
      return res;
    } else {
      return null;
    }
  }
}
