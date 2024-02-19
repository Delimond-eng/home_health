import 'package:get/get.dart';
import 'package:home_health/services/api.manger.dart';

import '../models/nurse.dart';
import '../models/patient.dart';
import '../models/schedule.dart';

class DataController extends GetxController {
  static DataController instance = Get.find();

  var nurses = <Nurse>[].obs;
  var patients = <Patient>[].obs;
  var allVisits = <Visit>[].obs;

/*   @override
  void onInit() {
    super.onInit();
  } */

  Future<void> initDoctorData() async {
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
      allVisits.addAll(modelVisit.visits!);
    }
  }
}
