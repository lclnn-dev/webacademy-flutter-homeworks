import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:first_project/homework9/providers/recipe_provider.dart';
import 'recipe_detail_screen.dart';
import 'add_recipe_screen.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipes = context.watch<RecipeProvider>().recipes;

    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(width: 10),
            Text('Книга рецептів')
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, i) {
          final recipe = recipes[i];
          return ListTile(
            title: Text(recipe.title),
            leading: const Icon(Icons.grain),
            subtitle: Text(recipe.description),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => RecipeDetailScreen(recipe: recipe)),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add');
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const Text(
            'Додати рецепт',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
