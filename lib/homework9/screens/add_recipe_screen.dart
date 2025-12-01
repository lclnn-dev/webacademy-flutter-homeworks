import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_project/homework9/providers/recipe_provider.dart';
import 'package:first_project/homework9/models/recipe.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final titleCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final ingredientsCtrl = TextEditingController();
  final stepsCtrl = TextEditingController();

  @override
  void dispose() {
    titleCtrl.dispose();
    descriptionCtrl.dispose();
    ingredientsCtrl.dispose();
    stepsCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final provider = context.read<RecipeProvider>();

    final title = titleCtrl.text.trim();
    final desc = descriptionCtrl.text.trim();

    final ingredients = ingredientsCtrl.text
        .split("\n")
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    final steps = stepsCtrl.text
        .split("\n")
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    if (title.isEmpty || desc.isEmpty || ingredients.isEmpty || steps.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Будь ласка, заповніть усі поля'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    provider.addRecipe(
      Recipe(
        title: title,
        description: desc,
        ingredients: ingredients,
        steps: steps,
      ),
    );

    Navigator.pop(context);
  }

  Widget _section({
    required String title,
    required Widget child,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    );
  }

  Widget _multilineField(TextEditingController controller, int maxLines) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _buildMainInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleCtrl,
              decoration: _fieldDecoration('Назва'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descriptionCtrl,
              maxLines: 2,
              decoration: _fieldDecoration('Короткий опис'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultilineSection({
    required String title,
    required TextEditingController controller,
  }) {
    return _section(
      title: title,
      child: _multilineField(controller, 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 4, title: const Text('Новий рецепт')),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          _buildMainInfoCard(),
          _buildMultilineSection(
            title: 'Інгредієнти (1 інгредієнт — 1 рядок)',
            controller: ingredientsCtrl,
          ),
          _buildMultilineSection(
            title: 'Кроки приготування (1 крок — 1 рядок)',
            controller: stepsCtrl,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const Text(
            'Зберегти рецепт',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
