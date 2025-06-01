import 'package:flutter/material.dart';

class UploadAvatar extends StatefulWidget {
  const UploadAvatar({super.key});

  @override
  State<UploadAvatar> createState() => _UploadAvatarState();
}

class _UploadAvatarState extends State<UploadAvatar> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 130),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Upload Avatar',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),
            Stack(
              children: [
                CircleAvatar(
                  radius: 80,

                ),
                Positioned(
                  top: 65,
                  right: 65,
                  child: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: null
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}