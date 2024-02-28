import 'package:get/get.dart';
import 'package:home_health/global/controllers.dart';
import 'package:home_health/services/api.manger.dart';

import '../global/storage.dart';
import '../models/nurse.dart';
import '../models/nurse_home.dart';
import '../models/patient.dart';
import '../models/report.dart';
import '../models/schedule.dart';

class NurseDataController extends GetxController {
  static NurseDataController instance = Get.find();

  RxList<Delegate> delegates = RxList.empty();
  RxList<Visit> visits = RxList.empty();
  RxList<Nurse> nurses = RxList.empty();
  RxList<Report> reports = RxList.empty();
  var selectScheduleTreatments = <Treatment>[].obs;

  @override
  void onInit() {
    super.onInit();
    viewHomeData();
  }

  Future viewHomeData() async {
    if (storage.read('user-data') != null) {
      if (storage.read('user-data')['profile'] == 'nurse') {
        dataController.dataLoading.value = true;
        var data = await ApiManager.viewNurseHomeData();
        dataController.dataLoading.value = false;
        if (data.status != null) {
          delegates.clear();
          visits.clear();
          delegates.addAll(data.response!.delegates!);
          visits.addAll(data.response!.visits!);
        }

        /***/

        var nurseModel = await ApiManager.viewAllNurseForDoctor();
        nurses.clear();
        nurses.addAll(nurseModel.nurses!);

        /***/
        var reportModel = await ApiManager.viewReportByNurse();
        reports.clear();
        reports.addAll(reportModel.reports!);
      }
      return true;
    }
  }

  Future<void> refreshSchedule({String? date}) async {
    visits.clear();
    dataController.dataLoading.value = true;
    var schedules = await ApiManager.getNurseSchedule(date: date);
    dataController.dataLoading.value = false;
    visits.clear();
    visits.addAll(schedules);
  }

  Future<void> refreshSelectedVisitTreatments({int? visitId}) async {
    var treatments = await ApiManager.getTreatmentOfVisit(visitId: visitId);
    selectScheduleTreatments.value = treatments;
  }

  Future<void> refreshReport({String? key}) async {
    reports.clear();
    dataController.dataLoading.value = true;
    var reportModel = await ApiManager.viewReportByNurse(key: key!);
    dataController.dataLoading.value = false;
    reports.addAll(reportModel.reports!);
  }
}
