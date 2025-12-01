import 'package:flutter/material.dart';
import 'package:first_project/homework9/models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 4, title: Text(recipe.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              recipe.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              recipe.description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              'Інгредієнти:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...recipe.ingredients.map(
              (i) => Text("• $i", style: const TextStyle(fontSize: 14)),
            ),
            const SizedBox(height: 20),
            const Text(
              'Інструкції:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...recipe.steps.map(
              (i) => Text("• $i", style: const TextStyle(fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }
}
