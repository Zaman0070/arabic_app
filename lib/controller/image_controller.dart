import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagePickerController extends GetxController {
  PickedFile? pickedFile;
  List<File> selectedImages = <File>[].obs;
  List<String> images = <String>[].obs;

  Future<List<String>> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickImage(source: source);

    if (pickedFiles != null) {
      pickedFile = PickedFile(pickedFiles.path);
      selectedImages = [File(pickedFiles.path)];
    }
    return uploadImagesToFirebase(selectedImages);
  }

  Future<List<String>> uploadImagesToFirebase(List selectedImages) async {
    final storage = FirebaseStorage.instance;
    List<String> listImages = <String>[].obs;
    for (var image in selectedImages) {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final reference = storage.ref().child('images/$fileName');
      final uploadTask = reference.putFile(image);

      final snapshot =
          await uploadTask.whenComplete(() => print('Image uploaded'));
      final imageUrl = await snapshot.ref.getDownloadURL();
      listImages.add(imageUrl);
    }
    return listImages;
  }
}
