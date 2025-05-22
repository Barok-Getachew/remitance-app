// lib/data/datasources/local/user_local_data_source.dart
import 'package:hive/hive.dart';
import '../../../../../core/error/error.dart';
import '../../model/user_model.dart';

abstract class UserLocalDataSource {
  Future<UserModel?> getUser(String email, String password);
  Future<bool> saveUser(UserModel user);
  // Future<void> updateUser(UserModel user);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Box userBox;

  UserLocalDataSourceImpl({required this.userBox});
  @override
  Future<UserModel?> getUser(String email, String password) async {
    if (!userBox.containsKey(email)) return null;

    final data = userBox.get(email);

    if (data is Map) {
      if (data['password'] != password.trim()) {
        throw OneorMoreFieldIsInvalidException();
      }

      return UserModel(
        id: data['id'],
        name: data['name'],
        email: data['email'],
        password: data['password'],
        balance: data['balance'] ?? 0.0,
      );
    }

    return null;
  }

  @override
  Future<bool> saveUser(UserModel user) async {
    try {
      final userExist = userBox.get(user.email);
      if (userExist != null) {
        throw UserAlreadyExistsException();
      }
      final userMap = {
        'id': user.id,
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'balance': user.balance,
      };
      await userBox.put(user.email, userMap);

      final savedUser = userBox.get(user.email);

      return savedUser != null && savedUser['email'] == user.email;
    } catch (e) {
      print('Save failed: $e');
      throw e;
    }
  }
}
