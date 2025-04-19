
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
part 'database.g.dart';

class RecipeTypesTable extends Table {
  IntColumn get typeId => integer().autoIncrement()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {typeId};
}

@DataClassName('RecipeData')
class RecipeTable extends Table {
  IntColumn get recipeId => integer().autoIncrement()();
  IntColumn get typeId =>
      integer().references(
        RecipeTypesTable,
        #typeId,
        onDelete: KeyAction.cascade,
      )(); // Define as foreign key
  TextColumn get name => text()();
  TextColumn get image => text()();
  TextColumn get ingredients => text()();
  TextColumn get steps => text()();

  @override
  Set<Column> get primaryKey => {recipeId};
}

@DriftDatabase(tables: [RecipeTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Opens a connection to the database. This is a factory for a [QueryExecutor]
  /// that can be used to interact with the database.
  //
  /// This method returns a [driftDatabase] with the name "my_database" and
  /// stores the database files in the application's support directory.
  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
