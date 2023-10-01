import 'package:flutter/material.dart';

class FavoriteFruitDiseasesScreen extends StatelessWidget {
  const FavoriteFruitDiseasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enfermedades Favoritas'),
        centerTitle: true,
      ),
      body: Center(child: Text('favorite')),
    );
  }
}
