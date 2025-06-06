import 'package:final_project/pages/intro_page.dart';
import 'package:final_project/pages/register_login_pages/login.dart';
import 'package:final_project/pages/register_login_pages/register.dart';
import 'package:final_project/pages/update_user_detail/upload_avatar.dart';
import 'package:final_project/pages/user_info_page.dart';
import 'package:final_project/pages/main_pages/menu_page.dart';
import 'package:final_project/pages/register_login_pages/authentication_service/auth_service.dart';
import 'package:final_project/models/user_auth_models.dart';
import 'package:final_project/constants/internet_checked.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _isCheckingOfflineAuth = true;
  bool _isOfflineAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkOfflineAuthentication();
  }

  // Check if there's an offline authenticated user in Hive
  Future<void> _checkOfflineAuthentication() async {
    try {
      final box = await Hive.openBox<UserAuthModels>('userAuthModels');

      // Find any user that has isAuthenticated = true
      final authenticatedUser = box.values.firstWhere(
        (user) => user.isAuthenticated == true,
        orElse:
            () => UserAuthModels(
              email: null,
              passwordHash: null,
              isAuthenticated: false,
            ),
      );

      setState(() {
        _isOfflineAuthenticated = authenticatedUser.isAuthenticated ?? false;
        _isCheckingOfflineAuth = false;
      });

      if (_isOfflineAuthenticated) {
        debugPrint(
          'Found authenticated user in offline storage: ${authenticatedUser.email}',
        );
      }
    } catch (e) {
      debugPrint('Error checking offline authentication: $e');
      setState(() {
        _isCheckingOfflineAuth = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // If we're still checking offline auth, show loading
    if (_isCheckingOfflineAuth) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // If user is authenticated offline, go directly to menu page
    if (_isOfflineAuthenticated) {
      return const MenuPage();
    }

    // Otherwise, check online authentication with Firebase
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
          },
        );
      },
    );
  }
}
