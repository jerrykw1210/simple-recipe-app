import 'package:simple_recipe_app/helper/api_base_helper.dart';

class RecipeService extends ApiBaseHelper {
  Future fetchRecipes() async {
    return get("https://68077103e81df7060eba47f1.mockapi.io/api/v1/recipe");
  }
}
