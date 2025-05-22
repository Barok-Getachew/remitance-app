import 'package:get/get.dart';

import '../controller/hivecontroller.dart';

class HiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HiveController>(HiveController(), permanent: true);
  }
}
