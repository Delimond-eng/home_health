import 'package:get/get.dart';
import 'package:home_health/models/auth.dart';

import '../global/storage.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  var user = Auth().obs;

  @override
  onInit() {
    super.onInit();
    init();
  }

  init() async {
    var umap = storage.read("user-data");
    if (umap != null) {
      user.value = Auth.fromJson(umap);
    }
  }
}
