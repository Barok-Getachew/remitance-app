import '../entity/user_entity.dart';
import '../repository/auth_repository.dart';

class RegisterUseCase {
  final UserRepository repository;

  RegisterUseCase(this.repository);

  Future<bool> execute(UserEntity user, String password) async {
    final result = await repository.registerUser(user, password);
    return result;
  }
}
