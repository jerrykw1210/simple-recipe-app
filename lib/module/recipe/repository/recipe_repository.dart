import 'package:simple_recipe_app/module/recipe/service/recipe_service.dart';
import 'package:simple_recipe_app/util/service_locator.dart';

class RecipeRepository {
  final RecipeService _recipeService = sl<RecipeService>();

  RecipeRepository();

  /// Fetches the recipes from the api or database
  ///
  /// Returns a [Future] that resolves to a [List] of [Recipe] objects.
  Future fetchRecipes() async {
    return await _recipeService.fetchRecipes();
  }
}

