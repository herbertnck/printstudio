import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printstudio/python/image_editor_plugin.dart';
// import 'package:chaquopy/chaquopy.dart';
import 'clothtemplate.dart';

class ClothingEditingScreen extends StatefulWidget {
  final ClothingTemplate clothingTemplate;

  const ClothingEditingScreen({super.key, required this.clothingTemplate});

  @override
  _ClothingEditingScreenState createState() => _ClothingEditingScreenState();
}

class _ClothingEditingScreenState extends State<ClothingEditingScreen> {
  Uint8List? imageData;

  @override
  void initState() {
    super.initState();
    // Initialize imageData with the image asset from the clothing template.
    loadAsset(widget.clothingTemplate.image);
    print('asset ${widget.clothingTemplate.image}');
  }

  void loadAsset(String assetPath) async {
    // Load the image asset and update the imageData.
    final data = await rootBundle.load(assetPath);
    setState(() => imageData = data.buffer.asUint8List());
  }

  Future<void> launchImageEditor() async {
    if (imageData != null) {
      // final editedImage = await Navigator.push<Uint8List>(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => ImageEditor(
      //               image: imageData,
      //             )));
      // // Replace the original image data with the edited image data if editedImage is not null.
      // if (editedImage != null) {
      //   setState(() {
      //     imageData = editedImage;
      //     saveEditedImage(editedImage);
      //   });
      // }

      // Call the flutter plugin to edit the image
      final appDir = await getApplicationDocumentsDirectory();
      await ImageEditorPlugin.editImage(
          widget.clothingTemplate.image, // Input image path
          '$appDir.path');

      // Reload the edited image
      loadAsset('$appDir.path');
    } else {
      print('Image data is null');
    }
  }

  Future<void> saveEditedImage(Uint8List editedImage) async {
    final appDir = await getApplicationDocumentsDirectory();
    final file = File('${appDir.path}/edited_image.png');
    await file.writeAsBytes(editedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit ${widget.clothingTemplate.name}"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Display the edited image
            Image.asset(
              widget.clothingTemplate.image,
              width: 200,
              height: 200,
            ),

            ElevatedButton(
              onPressed: () {
                // Launch the image editor when the user taps the button
                launchImageEditor();
              },
              child: const Text("Edit Image"),
            ),
            // Add your editing controls and customization options here.
          ],
        ),
      ),
    );
  }
}
