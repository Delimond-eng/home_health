import 'package:get/get.dart';
import 'package:home_health/services/api.manger.dart';

import '../models/nurse_home.dart';
import '../models/schedule.dart';

class NurseDataController extends GetxController {
  static NurseDataController instance = Get.find();

  RxList<Delegate> delegates = RxList.empty();
  RxList<Visit> visits = RxList.empty();

  Future viewHomeData() async {
    var data = await ApiManager.viewNurseHomeData();
    if (data.status != null) {
      delegates.clear();
      visits.clear();
      delegates.addAll(data.response!.delegates!);
      visits.addAll(data.response!.visits!);
    }
  }
}
