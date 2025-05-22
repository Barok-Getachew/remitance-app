import 'package:remitance/src/modules/auth/data/model/user_model.dart';

import '../entity/user_entity.dart';

abstract class UserRepository {
  Future<bool> registerUser(UserEntity user, String password);
  Future<UserEntity?> getUser(String email, String password);
}
