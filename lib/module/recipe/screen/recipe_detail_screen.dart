import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_recipe_app/database/database.dart';
import 'package:simple_recipe_app/helper/database_helper.dart';
import 'package:simple_recipe_app/helper/helper.dart';
import 'package:simple_recipe_app/module/recipe/cubit/recipe_cubit.dart';
import 'package:simple_recipe_app/module/recipe/screen/recipe_list_screen.dart';
import 'package:simple_recipe_app/util/service_locator.dart';

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key, required this.recipe});
  final RecipeData recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditRecipeDetailScreen(recipe: recipe),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await sl<DatabaseHelper>().deleteRecipe(recipe.recipeId);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => RecipeListScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.file(
              File('${Helper.directory?.path}/${recipe.image}'),
              height: 300,
              fit: BoxFit.cover,
            ),
            ListTile(title: Text(recipe.name)),
            ListTile(
              title: Text('Ingredients'),
              subtitle: Text(
                (jsonDecode(recipe.ingredients) as List).join(', '),
              ),
            ),
            ListTile(
              title: Text('Steps'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  jsonDecode(recipe.steps).length,
                  (index) => Wrap(
                    children: [
                      Text(
                        '${index + 1}. ${jsonDecode(recipe.steps)[index]}',
                        maxLines: 3,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditRecipeDetailScreen extends StatefulWidget {
  final RecipeData recipe;

  const EditRecipeDetailScreen({super.key, required this.recipe});

  @override
  RecipeDetailScreenState createState() => RecipeDetailScreenState();
}

class RecipeDetailScreenState extends State<EditRecipeDetailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();
  int _selectedTypeId = 1;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.recipe.name;
    _imageController.text = widget.recipe.image;
    _ingredientsController
        .text = (jsonDecode(widget.recipe.ingredients) as List).join(', ');
    _stepsController.text = (jsonDecode(widget.recipe.steps) as List).join(
      ', ',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipe Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: _nameController,

                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Center(
                child: GestureDetector(
                  onTap: () async {
                    final image = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 50,
                    );
                    setState(() {
                      if (image != null) {
                        _imageController.text = image.path;
                      }
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        _imageController.text.isEmpty
                            ? const Icon(Icons.camera_alt)
                            : Image.file(
                              File(
                                '${Helper.directory?.path}/${_imageController.text}',
                              ),
                            ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: BlocBuilder<RecipeCubit, RecipeState>(
                    builder: (context, state) {
                      if (state.fetchRecipeTypeStatus ==
                          FetchRecipeTypeStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state.fetchRecipeTypeStatus ==
                          FetchRecipeTypeStatus.fail) {
                        return const Center(
                          child: Text('Failed to load recipe types'),
                        );
                      }
                      if (state.fetchRecipeTypeStatus ==
                          FetchRecipeTypeStatus.success) {
                        _selectedTypeId = widget.recipe.typeId;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              labelText: 'Recipe Type',
                              border: InputBorder.none,
                            ),
                            value: _selectedTypeId,
                            items:
                                state.recipeTypes.map((
                                  RecipeTypesTableData type,
                                ) {
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
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Ingredients',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: _ingredientsController,
                maxLines: 5,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some ingredients';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Steps',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: _stepsController,
                maxLines: 5,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some steps';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final recipe = RecipeData(
                      recipeId: widget.recipe.recipeId,
                      typeId: widget.recipe.typeId,
                      name: _nameController.text,
                      image: _imageController.text,
                      ingredients: jsonEncode(
                        _ingredientsController.text
                            .split(', ')
                            .map((ingredient) => ingredient.trim())
                            .toList(),
                      ),
                      steps: jsonEncode(
                        _stepsController.text
                            .split(', ')
                            .map((step) => step.trim())
                            .toList(),
                      ),
                      status: widget.recipe.status,
                    );
                    log("recipe to edit $recipe");
                    await sl<DatabaseHelper>().updateRecipe(recipe);
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => RecipeListScreen(),
                      ),
                      (route) => false,
                    );
                  }
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
