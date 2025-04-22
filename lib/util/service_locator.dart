import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:simple_recipe_app/database/database.dart';
import 'package:simple_recipe_app/helper/database_helper.dart';
import 'package:simple_recipe_app/module/recipe/model/recipe.dart';
import 'package:simple_recipe_app/module/recipe/repository/recipe_repository.dart';
import 'package:simple_recipe_app/module/recipe/service/recipe_service.dart';

final sl = GetIt.instance;

/// Registers all the singletons that are needed by the app.
///
/// These are the services that are used by the app and are registered in
/// the [GetIt] instance. The [registerLazySingleton] function is used to
/// register the singletons.
///
/// This function is called by the [main] function.
///
/// It checks if the service is already registered and if not, it
/// registers it. If an error occurs during the registration process,
/// it logs the error message.
Future<void> registerDBSingleton() async {
  try {
    // Register the AppDatabase singleton
    registerLazySingleton<AppDatabase>(() => AppDatabase());
    registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

    // repository
    registerLazySingleton<RecipeRepository>(() => RecipeRepository());

    // service
    registerLazySingleton<RecipeService>(() => RecipeService());
  } catch (e) {
    log("error when starting service locator $e");
  }
}

void registerLazySingleton<T extends Object>(T Function() factoryFunc) {
  if (!sl.isRegistered<T>()) {
    sl.registerLazySingleton<T>(factoryFunc);
  }
}
