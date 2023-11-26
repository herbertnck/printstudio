import 'package:flutter/material.dart';

import 'clothtemplate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ClothingTemplate> clothingTemplates = [
    ClothingTemplate(
      name: "T-Shirt",
      image: "assets/tshirt_template.jpg",
    ),
    ClothingTemplate(
      name: "Shorts",
      image: "assets/short_template.jpg",
    ),
    // Add more clothing templates here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose a Clothing Template"),
      ),
      body: ListView.builder(
        itemCount: clothingTemplates.length,
        itemBuilder: (context, index) {
          return ClothingTemplateCard(
            clothingTemplate: clothingTemplates[index],
          );
        },
      ),
    );
  }
}
