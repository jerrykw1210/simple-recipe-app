import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:simple_recipe_app/database/database.dart';
import 'package:simple_recipe_app/module/recipe/model/recipe.dart';
import 'package:simple_recipe_app/util/service_locator.dart';

class DatabaseHelper {
  final AppDatabase _db = sl<AppDatabase>();

  Stream<List<RecipeData>> getRecipes() {
    return (_db.select(_db.recipeTable)).watch();
  }

  /// Upsert a recipe into the database.
  ///
  /// If the recipe already exists in the database (i.e. the recipeId is already
  /// present), then the existing record is updated with the provided values.
  /// Otherwise, a new record is inserted.
  ///
  /// Returns the id of the upserted recipe.
  Future<int> upsertRecipe(Recipe recipe) async {
    return await _db
        .into(_db.recipeTable)
        .insertOnConflictUpdate(
          RecipeTableCompanion(
            recipeId: Value(recipe.id),
            typeId: Value(recipe.typeId),
            name: Value(recipe.name),
            image: Value(recipe.image.toString()),
            ingredients: Value(jsonEncode(recipe.ingredients)),
            steps: Value(jsonEncode(recipe.steps)),
          ),
        );
  }

  /// Upsert a recipe type into the database.
  ///
  /// If the recipe type already exists in the database (i.e. the typeId is already
  /// present), then the existing record is updated with the provided values.
  /// Otherwise, a new record is inserted.
  ///
  /// Returns the id of the upserted recipe type.
  Future<int> upsertRecipeType(RecipeType recipeType) async {
    return await _db
        .into(_db.recipeTypesTable)
        .insertOnConflictUpdate(
          RecipeTypesTableCompanion(
            typeId: Value(recipeType.id),
            name: Value(recipeType.name),
          ),
        );
  }

  // Update an existing recipe
  Future<bool> updateRecipe(RecipeData recipe) {
    return _db.update(_db.recipeTable).replace(recipe);
  }

  // Delete a recipe by ID
  Future<int> deleteRecipe(int id) {
    return (_db.delete(_db.recipeTable)
      ..where((tbl) => tbl.recipeId.equals(id))).go();
  }

  /// Return a list of all the recipe types
  Future<List<RecipeTypesTableData>> getRecipeTypes() async {
    return await _db.select(_db.recipeTypesTable).get();
  }
}
