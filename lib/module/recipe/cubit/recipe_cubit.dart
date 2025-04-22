import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_recipe_app/database/database.dart';
import 'package:simple_recipe_app/helper/database_helper.dart';
import 'package:simple_recipe_app/module/recipe/model/recipe.dart';
import 'package:simple_recipe_app/module/recipe/repository/recipe_repository.dart';
import 'package:simple_recipe_app/util/service_locator.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit() : super(RecipeState());
  final RecipeRepository _recipeRepository = sl<RecipeRepository>();

  /// Fetches recipes from the repository and updates the local database.
  ///
  /// This method performs the following actions:
  /// - Fetches recipes from the repository and processes the result if it is a list.
  /// - Downloads recipe images if they do not already exist locally.
  /// - Updates the local database with the fetched recipes and their types.
  /// - Waits for all image downloads to complete before proceeding.
  /// - Emits a success state if all operations succeed, otherwise emits a fail state.
  void getRecipes() async {
    emit(state.copyWith(fetchRecipeStatus: FetchRecipeStatus.loading));
    try {
      final getRecipeRes = await _recipeRepository.fetchRecipes();
      if (getRecipeRes is List) {
        final downloadFutures = <Future>[];
        for (var recipe in getRecipeRes) {
          final recipeData = Recipe.fromJson(recipe);
          if (recipeData.image != null) {
            final dir = await getDownloadsDirectory();
            final dio = Dio();
            final file = File('${dir?.path}/${recipeData.image}');
            if (!await file.exists()) {
              // file.delete();
              downloadFutures.add(
                dio.download(
                  recipeData.image.toString(),
                  file.path,
                  onReceiveProgress: (rcv, total) {
                    log(
                      'received: ${rcv.toStringAsFixed(0)} out of total: ${total.toStringAsFixed(0)}',
                    );
                  },
                  deleteOnError: true,
                ),
              );
            }
          }

          await sl<DatabaseHelper>().insertRecipeIgnoringConflict(recipeData);
        }
        await Future.wait(
          downloadFutures,
        ); // wait for all downloads to complete
      }
      final List recipeTypeResponse = jsonDecode(
        await rootBundle.loadString('assets/json/recipetypes.json'),
      );

      for (var recipeType in recipeTypeResponse) {
        final recipeData = RecipeType.fromJson(recipeType);
        await sl<DatabaseHelper>().upsertRecipeType(recipeData);
      }
      getRecipeTypes();
      emit(state.copyWith(fetchRecipeStatus: FetchRecipeStatus.success));
    } catch (e) {
      emit(state.copyWith(fetchRecipeStatus: FetchRecipeStatus.fail));
    }
  }

  Future<void> getRecipeTypes() async {
    try {
      emit(
        state.copyWith(fetchRecipeTypeStatus: FetchRecipeTypeStatus.loading),
      );
      final response = await sl<DatabaseHelper>().getRecipeTypes();
      log("message $response");
      emit(
        state.copyWith(
          fetchRecipeTypeStatus: FetchRecipeTypeStatus.success,
          recipeTypes: response,
        ),
      );
    } catch (e) {
      emit(state.copyWith(fetchRecipeTypeStatus: FetchRecipeTypeStatus.fail));
    }
  }
}
