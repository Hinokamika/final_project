import 'package:image_picker/image_picker.dart';

pickImage() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 50, // Adjust the quality as needed
  );
  if (image != null) {
    return image.path; // Return the path of the selected image
  } else {
    return null; // Return null if no image was selected
  }
  print("");
}