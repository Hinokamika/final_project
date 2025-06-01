import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/pick_image.dart';

class UploadAvatar extends StatefulWidget {
  const UploadAvatar({super.key});

  @override
  State<UploadAvatar> createState() => _UploadAvatarState();
}

class _UploadAvatarState extends State<UploadAvatar> {
  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Upload Avatar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 80,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage('assets/images/default_avatar.png'),
                      ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo),
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

