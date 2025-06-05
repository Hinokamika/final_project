import 'package:hive/hive.dart';

part 'user_auth_models.g.dart';

@HiveType(typeId: 0)
class UserAuthModels {
  @HiveField(0)
  final bool? isAuthenticated;

  @HiveField(1)
  final String id;

  @HiveField(2)
  final String? email;

  @HiveField(3)
  final String? passwordHash;

  @HiveField(4)
  final DateTime? createdAt;

  UserAuthModels({
    this.isAuthenticated = false,
    this.id = '',
    required this.email,
    required this.passwordHash,
    this.createdAt,
  });
}