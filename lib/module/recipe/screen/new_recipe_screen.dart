import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_recipe_app/database/database.dart';
import 'package:simple_recipe_app/helper/database_helper.dart';
import 'package:simple_recipe_app/helper/helper.dart';
import 'package:simple_recipe_app/module/recipe/cubit/recipe_cubit.dart';
import 'package:simple_recipe_app/module/recipe/model/recipe.dart';
import 'package:simple_recipe_app/util/service_locator.dart';

class NewRecipeScreen extends StatefulWidget {
  const NewRecipeScreen({super.key});

  @override
  _NewRecipeScreenState createState() => _NewRecipeScreenState();
}

class _NewRecipeScreenState extends State<NewRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _imageController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();
  int _selectedTypeId = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Recipe')),
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
                            : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(File(_imageController.text)),
                            ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
                        List<RecipeTypesTableData> recipeTypes =
                            state.recipeTypes
                                .where((recipeType) => recipeType.typeId != 0)
                                .toList(); // remove 'all' type
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: DropdownButtonFormField(
                            decoration: const InputDecoration(
                              labelText: 'Recipe Type',
                              border: InputBorder.none,
                            ),
                            value: _selectedTypeId,
                            items:
                                recipeTypes.map((RecipeTypesTableData type) {
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
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (_imageController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select an image')),
                      );
                    } else {
                      final file = File(
                        '${Helper.directory?.path}/${_imageController.text.split('/').last}',
                      );
                      file.writeAsBytesSync(
                        File(_imageController.text).readAsBytesSync(),
                      );
                      final recipe = Recipe(
                        typeId: _selectedTypeId,
                        name: _nameController.text,
                        image: _imageController.text.split('/').last,
                        ingredients:
                            _ingredientsController.text
                                .split('\n')
                                .where((element) => element.isNotEmpty)
                                .toList(),
                        steps:
                            _stepsController.text
                                .split('\n')
                                .where((element) => element.isNotEmpty)
                                .toList(),
                      );
                      sl<DatabaseHelper>().insertRecipe(recipe);
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
