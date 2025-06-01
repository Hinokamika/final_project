import 'package:final_project/pages/intro_page.dart';
import 'package:final_project/pages/register_login_pages/login.dart';
import 'package:final_project/pages/register_login_pages/register.dart';
import 'package:final_project/pages/update_user_detail/upload_avatar.dart';
import 'package:final_project/pages/user_info_page.dart';
import 'package:final_project/pages/main_pages/menu_page.dart';
import 'package:final_project/pages/register_login_pages/authentication_service/auth_service.dart';
import 'package:flutter/material.dart';

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      routes: {
        '/UserInfo': (context) => const UserInfoPage(),
        '/Login': (context) => const LoginPage(),
        '/Authentication': (context) => const RegisterPage(),
        '/UploadAvatar': (context) => const UploadAvatar(),
        '/MenuPage': (context) => const MenuPage(),
        '/IntroPage': (context) => const IntroPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => const AuthGate());
        }
        return null;
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authServiceProvider,
      builder: (context, authService, child) {
        return StreamBuilder(
          stream: authService.authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasData) {
              return const MenuPage();
            } else {
              return const IntroPage();
            }
          }
        );
      }
    );
  }
}
