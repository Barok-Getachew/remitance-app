// lib/domain/entities/user_entity.dart
import '../../data/model/user_model.dart';

class UserEntity {
  final String id;
  final String name;
  final String email;
  final double balance;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.balance,
  });

  // Conversion from Model to Entity
  factory UserEntity.fromModel(UserModel model) {
    return UserEntity(
      id: model.id,
      name: model.name,
      email: model.email,
      balance: model.balance,
    );
  }
}
