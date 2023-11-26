// Add the following to your `pubspec.yaml` file
// dependencies:
//   image_editor_plugin: ^1.0.0

// Then run `flutter pub get` in your terminal

// Create a new Dart file: image_editor_plugin.dart

import 'dart:async';

import 'package:flutter/services.dart';

class ImageEditorPlugin {
  static const MethodChannel _channel = MethodChannel('image_editor_plus');

  static Future<void> editImage(String inputPath, String outputPath) async {
    try {
      await _channel.invokeMethod('editImage', {
        'inputPath': inputPath,
        'outputPath': outputPath,
      });
    } on PlatformException catch (e) {
      print("Failed to edit image: ${e.message}");
    }
  }
}
