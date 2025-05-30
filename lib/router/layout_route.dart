import 'package:final_project/pages/intro_page.dart';
import 'package:final_project/pages/register_login_pages/login.dart';
import 'package:final_project/pages/register_login_pages/register.dart';
import 'package:final_project/pages/update_user_detail/upload_avatar.dart';
import 'package:final_project/pages/user_info_page.dart';
import 'package:flutter/material.dart';

class LayoutRoute extends StatelessWidget {
  const LayoutRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Routes Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const IntroPage(),
        '/UserInfo': (context) => const UserInfoPage(),
        '/Login': (context) => const LoginPage(),
        '/Authentication': (context) => const RegisterPage(),
        '/UploadAvatar': (context) => const UploadAvatar(),
      },
    );
  }
}
