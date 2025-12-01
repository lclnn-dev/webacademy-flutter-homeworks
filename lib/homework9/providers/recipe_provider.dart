import 'package:flutter/material.dart';
import 'package:first_project/homework9/models/recipe.dart';
import 'package:first_project/homework9/data/data_recipes.dart';

class RecipeProvider extends ChangeNotifier {
  final List<Recipe> _recipes = [];

  RecipeProvider() {
    _recipes.addAll(seedRecipes);
  }

  List<Recipe> get recipes => _recipes;

  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
    notifyListeners();
  }
}