import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class PickImageModel {
  Future pickImageFile() async {
    try {
      await ImagePicker.platform.pickImage(source: ImageSource.gallery).then(
        (PickedFile imgFIle) {
          return imgFIle;
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
