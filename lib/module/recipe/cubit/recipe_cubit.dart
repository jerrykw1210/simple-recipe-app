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
import 'package:simple_recipe_app/util/service_locator.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit() : super(RecipeState());

  /// Load recipes and recipe types from json files and upsert them into the database
  void getRecipes() async {
    emit(state.copyWith(fetchRecipeStatus: FetchRecipeStatus.loading));
    try {
      final List response = jsonDecode(
        await rootBundle.loadString('assets/json/recipe.json'),
      );
      final List recipeTypeResponse = jsonDecode(
        await rootBundle.loadString('assets/json/recipetypes.json'),
      );

      for (var recipe in response) {
        final recipeData = Recipe.fromJson(recipe);
        if (recipeData.image != null) {
          final dir = await getDownloadsDirectory();
          final dio = Dio();
          final file = File('${dir?.path}/${recipeData.image}');
          if (!await file.exists()) {
            // file.delete();
            dio
                .download(
                  recipeData.image.toString(),
                  file.path,
                  onReceiveProgress: (rcv, total) {
                    log(
                      'received: ${rcv.toStringAsFixed(0)} out of total: ${total.toStringAsFixed(0)}',
                    );
                  },
                  deleteOnError: true,
                )
                .then((res) async {});
          }
        }

        await sl<DatabaseHelper>().upsertRecipe(recipeData);
      }
      for (var recipeType in recipeTypeResponse) {
        final recipeData = RecipeType.fromJson(recipeType);
        await sl<DatabaseHelper>().upsertRecipeType(recipeData);
      }
      getRecipeTypes();
      Future.delayed(const Duration(seconds: 2));
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
