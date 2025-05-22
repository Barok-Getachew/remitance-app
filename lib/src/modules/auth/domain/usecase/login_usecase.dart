import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class LoginUseCase {
  final UserRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity?> execute(String email, String password) async {
    return await repository.getUser(email, password);
  }
}
