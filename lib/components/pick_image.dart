import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(
    source: source
  );
  if (image != null) {
    return await image.readAsBytes(); // Return the path of the selected image
  }
  print("No Images Selected");
}