import 'package:final_project/components/aler_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../register_login_pages/authentication_service/auth_service.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {

    void logout() async {
      try {
        await authServiceProvider.value.signOut();
      }on FirebaseAuthException catch (e) {
        print(e.message);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: const Color(0xFFFF3333),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Create and show the dialog
                DialogCustom(
                  title: 'Log Out',
                  content: 'Are you sure you want to log out?',
                  confirmButtonText: 'Log Out',
                  cancelButtonText: 'Cancel',
                  onConfirm: logout,
                  onCancel: () {
                    // Optionally handle cancel action
                    Navigator.of(context).pop();
                  },
                ).show(context); // Call the show method to display the dialog
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF3333),
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Log Out',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
