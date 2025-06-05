import 'package:final_project/core/database/userAuthService.dart';
import 'package:final_project/pages/register_login_pages/authentication_service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/provider/user_authentication.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final UserAuthService _userAuthService = UserAuthService();
  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String errorString = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // You cannot use ref directly in initState
    // Move any initialization logic to build or use addPostFrameCallback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Access ref safely here after the widget is built
      // Your initialization code here if needed
    });
  }

  // Function to hash passwords using SHA-256
  String hashPassword(String password) {
    var bytes = utf8.encode(password); // Convert password to bytes
    var digest = sha256.convert(bytes); // Hash the password with SHA-256
    return digest.toString(); // Return the hashed password as a string
  }

  void register() async {
    setState(() {
      errorString = '';
    });

    final isValid = _registerFormKey.currentState?.validate() ?? false;
    if (!isValid) {
      setState(() {
        errorString =
            errorString.isNotEmpty
                ? errorString
                : 'Please complete all fields correctly';
      });
      return;
    }
    try {
      // Hash the password before sending it to your database service
      String hashedPassword = hashPassword(_passwordController.text);

      await _userAuthService.register(
        _emailController.text,
        hashedPassword, // Send the hashed password to your database service
      );

      // For Firebase Auth, use the original password (Firebase handles its own password hashing)
      await authServiceProvider.value.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushNamed(context, '/Login');
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorString = 'Registration failed: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Using the notifier only, not watching the state directly since we don't use it
    final authDataNotifier = ref.watch(userAuthenticationProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Register',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            Form(
              key: _registerFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      authDataNotifier.updateEmail(value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          errorString = 'Please enter your email';
                        });
                        return '';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        setState(() {
                          errorString = 'Please enter a valid email';
                        });
                        return '';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      authDataNotifier.updatePassword(value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          errorString = 'Please enter your password';
                        });
                        return '';
                      }
                      if (!RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                      ).hasMatch(value)) {
                        setState(() {
                          errorString =
                              'Password must be at least 8 characters long and include uppercase, lowercase, number, and special character';
                        });
                        return '';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        setState(() {
                          errorString = 'Please confirm your password';
                        });
                        return '';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    errorString,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:
                          errorString.isEmpty ? Colors.grey[600] : Colors.red,
                      fontSize: 14,
                      fontWeight:
                          errorString.isEmpty
                              ? FontWeight.normal
                              : FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300, // Updated width for buttons
                    child: ElevatedButton(
                      onPressed: () {
                        register();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF3333),
                        padding: const EdgeInsets.all(25),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
