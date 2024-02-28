import 'package:get/get.dart';
import 'package:home_health/services/api.manger.dart';

import '../global/storage.dart';
import '../models/nurse.dart';
import '../models/patient.dart';
import '../models/report.dart';
import '../models/schedule.dart';

class DataController extends GetxController {
  static DataController instance = Get.find();

  var nurses = <Nurse>[].obs;
  var patients = <Patient>[].obs;
  var allVisits = <Visit>[].obs;
  var reports = <Report>[].obs;
  RxBool dataLoading = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    initDoctorData();
  }

  Future initDoctorData() async {
    if (storage.read("user-data") != null) {
      var data = storage.read("user-data");
      if (data["profile"] == "doctor") {
        dataLoading.value = true;
        var data = await ApiManager.viewAllNurseForDoctor();
        if (data.status != null) {
          nurses.clear();
          nurses.addAll(data.nurses!);
        }
        var modelPatient = await ApiManager.viewAllPatientsForDoctor();
        if (modelPatient.status != null) {
          patients.clear();
          patients.addAll(modelPatient.patients!);
        }

        var modelVisit = await ApiManager.viewAllVisitsForDoctor();
        if (modelVisit.status != null) {
          allVisits.clear();
          allVisits.addAll(modelVisit.visits!);
        }

        /***/
        var reportModel = await ApiManager.viewReportByDoctor();
        if (reportModel.status != null) {
          reports.clear();
          reports.addAll(reportModel.reports!);
        }
        dataLoading.value = false;
      }
    }
    return true;
  }

  Future<void> viewAllVisitsByDoctor({int? nurseId}) async {
    dataLoading.value = true;
    var modelVisit = await ApiManager.viewAllVisitsForDoctor(nurseId: nurseId);
    dataLoading.value = false;
    if (modelVisit.status != null) {
      allVisits.clear();
      allVisits.addAll(modelVisit.visits!);
    }
  }

  Future<void> refreshReport({String? key}) async {
    reports.clear();
    dataLoading.value = true;
    var reportModel = await ApiManager.viewReportByDoctor(key: key!);
    dataLoading.value = false;
    reports.addAll(reportModel.reports!);
  }
}
