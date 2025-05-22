import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entity/user_entity.dart';

class UserModel {
  final String id;
  final String name;
  final String email;

  final String password;

  double balance;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.balance = 0.0,
  });

  // Convert to Domain Entity
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      balance: balance,
    );
  }

  // Alternative named constructor
  factory UserModel.fromEntity(UserEntity entity, {required String password}) {
    return UserModel(
      id: const Uuid().v4(),
      email: entity.email,
      name: entity.name,
      password: password,
      balance: entity.balance,
    );
  }

  factory UserModel.create({
    required String email,
    required String name,
    required String password,
    double balance = 0.0,
  }) {
    return UserModel(
      id: const Uuid().v4(),
      email: email,
      name: name,
      password: password,
      balance: balance,
    );
  }

  UserModel copyWith({
    String? email,
    String? name,
    String? password,
    double? balance,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      balance: balance ?? this.balance,
    );
  }
}
