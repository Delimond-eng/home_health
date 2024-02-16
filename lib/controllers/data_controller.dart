import 'package:get/get.dart';
import 'package:home_health/services/api.manger.dart';

import '../models/nurse.dart';

class DataController extends GetxController {
  static DataController instance = Get.find();

  var nurses = <Nurse>[].obs;

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
  }
}
