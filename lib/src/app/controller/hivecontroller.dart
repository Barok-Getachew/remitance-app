import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hive/hive.dart';

import '../../core/enum/box_types.dart';
import '../../modules/auth/data/model/user_model.dart';

class HiveController extends GetxController {
  final RxBool isReady = false.obs;
  late final Box settingsBox;
  late final Box cacheBox;
  late final Box accountBox;
  late final Box profileBox;
  late final Box transactionBox;
  @override
  Future<void> onInit() async {
    try {
      settingsBox = await Hive.openBox(BoxType.settings.name);
      cacheBox = await Hive.openBox(BoxType.cache.name);
      accountBox = await Hive.openBox(BoxType.account.name);
      profileBox = await Hive.openBox(BoxType.profile.name);
      transactionBox = await Hive.openBox(BoxType.transactions.name);
    } catch (e) {
      print("Error opening settings box: $e");
    }

    isReady.value = true;
    super.onInit();
  }

  Box getBox(BoxType type) {
    switch (type) {
      case BoxType.settings:
        return settingsBox;
      case BoxType.cache:
        return cacheBox;
      case BoxType.account:
        return accountBox;
      case BoxType.profile:
        return profileBox;
      case BoxType.transactions:
        return profileBox;
    }
  }
}
