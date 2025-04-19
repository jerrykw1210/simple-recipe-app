import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_recipe_app/helper/helper.dart';
import 'package:simple_recipe_app/module/recipe/cubit/recipe_cubit.dart';
import 'package:simple_recipe_app/module/recipe/screen/recipe_list_screen.dart';
import 'package:simple_recipe_app/util/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Helper.initializeDirectory();
  await registerDBSingleton();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => RecipeCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: RecipeListScreen())),
      ),
    );
  }
}
