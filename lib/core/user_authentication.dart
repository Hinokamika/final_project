import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAuthentication {
  final String email;
  final String password;

  UserAuthentication({required this.email, required this.password});

  UserAuthentication copyWith({
    String? email,
    String? password,
  }) {
    return UserAuthentication(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class UserAuthenticationNotifier extends StateNotifier<UserAuthentication> {
  UserAuthenticationNotifier()
      : super(UserAuthentication(email: '', password: ''));

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void clear() {
    state = UserAuthentication(email: '', password: '');
  }
}

final userAuthenticationProvider =
    StateNotifierProvider<UserAuthenticationNotifier, UserAuthentication>(
  (ref) => UserAuthenticationNotifier(),
);