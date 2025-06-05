import "package:hive/hive.dart";

part 'user_authentication_hive.g.dart';

@HiveType(typeId: 1)
class UserAuthentication extends HiveObject {
  @HiveField(0)
  String password;

  @HiveField(1)
  String email;

  @HiveField(2)
  String status = 'false';

  UserAuthentication({
    required this.password,
    required this.email,
    required this.status,
  });

  @override
  String toString() => 'UserAuthentication(email: $email, password_hash: $password ,status: $status)';
}