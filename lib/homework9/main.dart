import 'package:first_project/homework9/screens/add_recipe_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/recipe_provider.dart';
import 'screens/recipe_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RecipeProvider(),
      child: const RecipeApp(),
    ),
  );
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Книга рецептів',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RecipeListScreen(),
        '/add': (context) => const AddRecipeScreen(),
      },
    );
  }
}
