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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                radius: 50,
                backgroundImage: AssetImage('assets/images/default_avatar.png'),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {}
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}