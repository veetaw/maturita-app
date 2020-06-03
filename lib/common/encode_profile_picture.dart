import 'dart:convert';

import 'package:cross_picker/cross_picker.dart';

CrossPicker imagePicker = CrossPicker();
Future<String> encodeProfilePicture() async {
  var data = await imagePicker.getImage();
  if (data == null) return null;
  return base64Encode(data.toList());
}
