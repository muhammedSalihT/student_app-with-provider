import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends ChangeNotifier {
  String imagess = '';
  File? pick;

  pickImageFromCamera() async {
    final pickImage = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickImage == null) {
      return;
    } else {
      pick = File(pickImage.path);
      final bytes = File(pickImage.path).readAsBytesSync();
      imagess = base64Encode(bytes);
      notifyListeners();
    }
  }
}
