import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configurePlatformChannels();
  runApp(const MyApp());
}

// Add the following to your Dart code (e.g., main.dart)

const MethodChannel _channel = MethodChannel('image_editor_plugin');

// Add this function in your Dart code
Future<void> configurePlatformChannels() async {
  // Set up a method channel to communicate with native code
  _channel.setMethodCallHandler((MethodCall call) async {
    switch (call.method) {
      case 'editImage':
        // Handle the method call to edit the image using OpenCV
        String inputPath = call.arguments['inputPath'];
        String outputPath = call.arguments['outputPath'];

        // Call the Python script
        await Process.run(
            'python', ['opencv_script.py', inputPath, outputPath]);
        break;
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Print Studio',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
