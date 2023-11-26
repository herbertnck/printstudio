import 'package:flutter/material.dart';

import 'clotheditingscreen.dart';

class ClothingTemplate {
  final String name;
  late final String image;

  ClothingTemplate({
    required this.name,
    required this.image,
  });
}

class ClothingTemplateCard extends StatelessWidget {
  final ClothingTemplate clothingTemplate;

  const ClothingTemplateCard({super.key, required this.clothingTemplate});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.asset(
          clothingTemplate.image,
          width: 80,
          height: 80,
        ),
        title: Text(clothingTemplate.name),
        onTap: () {
          // Handle template selection and navigate to the editing screen.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClothingEditingScreen(
                clothingTemplate: clothingTemplate,
              ),
            ),
          );
        },
      ),
    );
  }
}
