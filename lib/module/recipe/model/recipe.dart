class RecipeType {
  final int id;
  final String name;

  RecipeType({required this.id, required this.name});

  factory RecipeType.fromJson(Map<String, dynamic> json) {
    return RecipeType(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Recipe {
  int id;
  int typeId;
  String name;
  String? image;
  List<String> ingredients;
  List<String> steps;

  Recipe({
    required this.id,
    required this.typeId,
    required this.name,
    this.image,
    required this.ingredients,
    required this.steps,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      typeId: json['typeId'],
      name: json['name'],
      image: json['image'],
      ingredients: List<String>.from(json['ingredients']),
      steps: List<String>.from(json['steps']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'typeId': typeId,
      'name': name,
      'image': image,
      'ingredients': ingredients,
      'steps': steps,
    };
  }
}