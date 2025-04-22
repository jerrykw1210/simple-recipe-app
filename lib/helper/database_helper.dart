import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:simple_recipe_app/database/database.dart';
import 'package:simple_recipe_app/module/recipe/model/recipe.dart';
import 'package:simple_recipe_app/util/service_locator.dart';

class DatabaseHelper {
  final AppDatabase _db = sl<AppDatabase>();

  Stream<List<RecipeData>> getRecipes() {
    return (_db.select(_db.recipeTable)
      ..where((tbl) => tbl.status.equals('available'))).watch();
  }

  /// Insert a recipe into the database, ignoring any conflict if the recipe
  /// already exists.
  ///
  /// Returns the id of the inserted recipe.
  ///
  /// If the recipe already exists in the database, this method does nothing
  /// and returns the id of the existing recipe.
  Future<int> insertRecipeIgnoringConflict(Recipe recipe) async {
    return await _db
        .into(_db.recipeTable)
        .insert(
          RecipeTableCompanion(
            recipeId: Value(recipe.id ?? 0),
            typeId: Value(recipe.typeId),
            name: Value(recipe.name),
            image: Value(recipe.image.toString()),
            ingredients: Value(jsonEncode(recipe.ingredients)),
            steps: Value(jsonEncode(recipe.steps)),
            status: Value(recipe.status ?? "available"),
          ),
          onConflict: DoNothing(), //ignore if recipe already exists
        );
  }

  /// Insert a recipe into the database.
  ///
  /// If a recipe with the given id already exists, this throws a
  /// [DatabaseException].
  ///
  /// Returns the id of the inserted recipe.
  Future<int> insertRecipe(Recipe recipe) async {
    return await _db
        .into(_db.recipeTable)
        .insert(
          RecipeTableCompanion(
            typeId: Value(recipe.typeId),
            name: Value(recipe.name),
            image: Value(recipe.image.toString()),
            ingredients: Value(jsonEncode(recipe.ingredients)),
            steps: Value(jsonEncode(recipe.steps)),
          ),
          mode: InsertMode.insert,
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
  Future updateRecipe(RecipeData recipe) async {
    return (_db.update(_db.recipeTable)
      ..where((tbl) => tbl.recipeId.equals(recipe.recipeId))
      ..write(
        RecipeTableCompanion(
          recipeId: Value(recipe.recipeId),
          typeId: Value(recipe.typeId),
          name: Value(recipe.name),
          image: Value(recipe.image.toString()),
          ingredients: Value(recipe.ingredients),
          steps: Value(recipe.steps),
        ),
      ));

    // return (_db.update(_db.recipeTable)
    //   ..where((tbl) => tbl.recipeId.equals(recipe.recipeId))
    //   ..write(
    //     RecipeTableCompanion(
    //       recipeId: Value(recipe.recipeId),
    //       typeId: Value(recipe.typeId),
    //       name: Value(recipe.name),
    //       image: Value(recipe.image.toString()),
    //       ingredients: Value(jsonEncode(recipe.ingredients)),
    //       steps: Value(jsonEncode(recipe.steps)),
    //     ),
    //   ));
  }

  // Delete a recipe by ID
  Future deleteRecipe(int id) async {
    //  return (_db.delete(_db.recipeTable)
    //   ..where((tbl) => tbl.recipeId.equals(id))).go(); // removed change to soft delete instead

    return (_db.update(_db.recipeTable)
      ..where((tbl) => tbl.recipeId.equals(id))
      ..write(
        RecipeTableCompanion(
          // Assuming there is a 'status' field to indicate deletion
          status: Value('deleted'),
        ),
      ));
  }

  /// Return a list of all the recipe types
  Future<List<RecipeTypesTableData>> getRecipeTypes() async {
    return await _db.select(_db.recipeTypesTable).get();
  }
}
