part of 'recipe_cubit.dart';

enum FetchRecipeTypeStatus { initial, loading, success, fail }
enum FetchRecipeStatus { initial, loading, success, fail }

class RecipeState extends Equatable {
  final FetchRecipeTypeStatus fetchRecipeTypeStatus;
  final FetchRecipeStatus fetchRecipeStatus;
  final List<RecipeTypesTableData> recipeTypes;

  const RecipeState({
    this.fetchRecipeTypeStatus = FetchRecipeTypeStatus.initial,
    this.fetchRecipeStatus = FetchRecipeStatus.initial,
    this.recipeTypes = const [],
  });

  RecipeState copyWith({
    FetchRecipeTypeStatus? fetchRecipeTypeStatus,
    FetchRecipeStatus? fetchRecipeStatus,
    List<RecipeTypesTableData>? recipeTypes,
  }) {
    return RecipeState(
      fetchRecipeTypeStatus:
          fetchRecipeTypeStatus ?? this.fetchRecipeTypeStatus,
      fetchRecipeStatus: fetchRecipeStatus ?? this.fetchRecipeStatus,
      recipeTypes: recipeTypes ?? this.recipeTypes,
    );
  }

  @override
  List<Object?> get props => [fetchRecipeTypeStatus, fetchRecipeStatus, recipeTypes];
}

