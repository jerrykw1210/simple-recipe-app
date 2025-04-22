import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_recipe_app/database/database.dart';
import 'package:simple_recipe_app/helper/database_helper.dart';
import 'package:simple_recipe_app/helper/helper.dart';
import 'package:simple_recipe_app/module/recipe/cubit/recipe_cubit.dart';
import 'package:simple_recipe_app/module/recipe/screen/new_recipe_screen.dart';
import 'package:simple_recipe_app/module/recipe/screen/recipe_detail_screen.dart';
import 'package:simple_recipe_app/util/service_locator.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RecipeCubit>().getRecipes();
  }

  int _selectedTypeId = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipe List')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            BlocBuilder<RecipeCubit, RecipeState>(
              builder: (context, state) {
                if (state.fetchRecipeTypeStatus ==
                    FetchRecipeTypeStatus.loading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state.fetchRecipeTypeStatus == FetchRecipeTypeStatus.fail) {
                  return Center(child: Text('Failed to load recipe types'));
                }
                if (state.fetchRecipeTypeStatus ==
                    FetchRecipeTypeStatus.success) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: 'Recipe Type',
                        border: InputBorder.none,
                      ),
                      value: _selectedTypeId,
                      items:
                          state.recipeTypes.map((RecipeTypesTableData type) {
                            return DropdownMenuItem(
                              value: type.typeId,
                              child: Text(type.name),
                            );
                          }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedTypeId = newValue!;
                        });
                      },
                    ),
                  );
                }
                return SizedBox();
              },
            ),
            Flexible(
              child: StreamBuilder(
                stream: sl<DatabaseHelper>().getRecipes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final recipes = snapshot.data;
                    return BlocBuilder<RecipeCubit, RecipeState>(
                      builder: (context, state) {
                        if (state.fetchRecipeStatus ==
                            FetchRecipeStatus.success) {
                          if (_selectedTypeId != 0) {
                            recipes!.removeWhere(
                              (recipe) => recipe.typeId != _selectedTypeId,
                            );
                          }
                          return ListView.separated(
                            itemCount: recipes!.length,
                            separatorBuilder: (context, index) => Divider(),
                            padding: const EdgeInsets.all(8.0),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final recipe = recipes[index];
                              return ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child:
                                      // File('${Helper.directory?.path}/${recipe.image}')
                                      //         .existsSync()
                                      //     ? Image.file(
                                      //       File(
                                      //         '${Helper.directory?.path}/${recipe.image}',
                                      //       ),
                                      //       width: 70,
                                      //       height: 70,
                                      //       cacheHeight: 70,
                                      //       cacheWidth: 70,
                                      //       fit: BoxFit.cover,
                                      //     )
                                      //     : Image.network(
                                      //       recipe.image,
                                      //       width: 70,
                                      //       height: 70,
                                      //       cacheHeight: 70,
                                      //       cacheWidth: 70,
                                      //       fit: BoxFit.cover,
                                      //     ),
                                      recipe.image.startsWith('http')
                                          ? CachedNetworkImage(
                                            imageUrl: recipe.image,
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.cover,
                                            placeholder:
                                                (context, url) =>
                                                    const CircularProgressIndicator(), // Show while loading
                                            errorWidget:
                                                (
                                                  context,
                                                  url,
                                                  error,
                                                ) => const Icon(
                                                  Icons.error,
                                                ), // Show if there's an error
                                          )
                                          : Image.file(
                                            File(
                                              '${Helper.directory?.path}/${recipe.image}',
                                            ),
                                            width: 70,
                                            height: 70,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Icon(Icons.error),
                                          ),
                                ),
                                title: Text(recipe.name),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => RecipeDetailScreen(
                                            recipe: recipe,
                                          ),
                                    ),
                                  );
                                },
                                trailing: Icon(Icons.arrow_forward_ios),
                              );
                            },
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewRecipeScreen()),
          );
        },
      ),
    );
  }
}
