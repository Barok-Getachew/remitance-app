// lib/data/repositories/user_repository_impl.dart
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/local/user_local_data_source.dart';
import '../model/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({required this.localDataSource});

  @override
  Future<UserEntity?> getUser(String email, String password) async {
    final user = await localDataSource.getUser(email, password);

    return user?.toEntity();
  }

  @override
  Future<bool> registerUser(UserEntity user, String password) async {
    return await localDataSource.saveUser(
      UserModel.create(
        email: user.email,
        name: user.name,
        password: password,
        balance: user.balance,
      ),
    );
  }
}
