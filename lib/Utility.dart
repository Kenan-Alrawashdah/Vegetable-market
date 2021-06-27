import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

class Utility {

  static Image imageFromBase64String(String base64String, double width, double height) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.cover,
      width: width,
      height: height,

    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}