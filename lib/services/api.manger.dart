import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:home_health/global/controllers.dart';
import 'package:home_health/global/storage.dart';
import 'package:home_health/services/api.dart';

import '../models/nurse.dart';

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
    var response = await Api.request("/nurses.all/${user.id}");
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
  static Future<NurseModel> viewAllPatientsForDoctor() async {
    var data = NurseModel();
    var user = authController.user.value;
    var response = await Api.request("/patients.all/${user.id}");
    if (response.containsKey("status")) {
      data = NurseModel.fromJson(response);
    }
    return data;
  }
}
