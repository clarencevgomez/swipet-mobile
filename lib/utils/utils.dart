import 'dart:convert';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  // ignore: no_leading_underscores_for_local_identifiers
  final ImagePicker _imagePicker = ImagePicker();
  // ignore: no_leading_underscores_for_local_identifiers
  XFile? _file = await _imagePicker.pickImage(
      source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  print("No Image Selected");
}

// Image to string function
String uint8ListToBase64(Uint8List uint8list) {
  return base64Encode(uint8list);
}
