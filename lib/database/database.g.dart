// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $RecipeTypesTableTable extends RecipeTypesTable
    with TableInfo<$RecipeTypesTableTable, RecipeTypesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeTypesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
    'type_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [typeId, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_types_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeTypesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {typeId};
  @override
  RecipeTypesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeTypesTableData(
      typeId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}type_id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
    );
  }

  @override
  $RecipeTypesTableTable createAlias(String alias) {
    return $RecipeTypesTableTable(attachedDatabase, alias);
  }
}

class RecipeTypesTableData extends DataClass
    implements Insertable<RecipeTypesTableData> {
  final int typeId;
  final String name;
  const RecipeTypesTableData({required this.typeId, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['type_id'] = Variable<int>(typeId);
    map['name'] = Variable<String>(name);
    return map;
  }

  RecipeTypesTableCompanion toCompanion(bool nullToAbsent) {
    return RecipeTypesTableCompanion(typeId: Value(typeId), name: Value(name));
  }

  factory RecipeTypesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeTypesTableData(
      typeId: serializer.fromJson<int>(json['typeId']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'typeId': serializer.toJson<int>(typeId),
      'name': serializer.toJson<String>(name),
    };
  }

  RecipeTypesTableData copyWith({int? typeId, String? name}) =>
      RecipeTypesTableData(
        typeId: typeId ?? this.typeId,
        name: name ?? this.name,
      );
  RecipeTypesTableData copyWithCompanion(RecipeTypesTableCompanion data) {
    return RecipeTypesTableData(
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeTypesTableData(')
          ..write('typeId: $typeId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(typeId, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeTypesTableData &&
          other.typeId == this.typeId &&
          other.name == this.name);
}

class RecipeTypesTableCompanion extends UpdateCompanion<RecipeTypesTableData> {
  final Value<int> typeId;
  final Value<String> name;
  const RecipeTypesTableCompanion({
    this.typeId = const Value.absent(),
    this.name = const Value.absent(),
  });
  RecipeTypesTableCompanion.insert({
    this.typeId = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<RecipeTypesTableData> custom({
    Expression<int>? typeId,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (typeId != null) 'type_id': typeId,
      if (name != null) 'name': name,
    });
  }

  RecipeTypesTableCompanion copyWith({
    Value<int>? typeId,
    Value<String>? name,
  }) {
    return RecipeTypesTableCompanion(
      typeId: typeId ?? this.typeId,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeTypesTableCompanion(')
          ..write('typeId: $typeId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $RecipeTableTable extends RecipeTable
    with TableInfo<$RecipeTableTable, RecipeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<int> typeId = GeneratedColumn<int>(
    'type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipe_types_table (type_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ingredientsMeta = const VerificationMeta(
    'ingredients',
  );
  @override
  late final GeneratedColumn<String> ingredients = GeneratedColumn<String>(
    'ingredients',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<String> steps = GeneratedColumn<String>(
    'steps',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    recipeId,
    typeId,
    name,
    image,
    ingredients,
    steps,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('ingredients')) {
      context.handle(
        _ingredientsMeta,
        ingredients.isAcceptableOrUnknown(
          data['ingredients']!,
          _ingredientsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientsMeta);
    }
    if (data.containsKey('steps')) {
      context.handle(
        _stepsMeta,
        steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta),
      );
    } else if (isInserting) {
      context.missing(_stepsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {recipeId};
  @override
  RecipeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeData(
      recipeId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}recipe_id'],
          )!,
      typeId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}type_id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      image:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}image'],
          )!,
      ingredients:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}ingredients'],
          )!,
      steps:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}steps'],
          )!,
    );
  }

  @override
  $RecipeTableTable createAlias(String alias) {
    return $RecipeTableTable(attachedDatabase, alias);
  }
}

class RecipeData extends DataClass implements Insertable<RecipeData> {
  final int recipeId;
  final int typeId;
  final String name;
  final String image;
  final String ingredients;
  final String steps;
  const RecipeData({
    required this.recipeId,
    required this.typeId,
    required this.name,
    required this.image,
    required this.ingredients,
    required this.steps,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['recipe_id'] = Variable<int>(recipeId);
    map['type_id'] = Variable<int>(typeId);
    map['name'] = Variable<String>(name);
    map['image'] = Variable<String>(image);
    map['ingredients'] = Variable<String>(ingredients);
    map['steps'] = Variable<String>(steps);
    return map;
  }

  RecipeTableCompanion toCompanion(bool nullToAbsent) {
    return RecipeTableCompanion(
      recipeId: Value(recipeId),
      typeId: Value(typeId),
      name: Value(name),
      image: Value(image),
      ingredients: Value(ingredients),
      steps: Value(steps),
    );
  }

  factory RecipeData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeData(
      recipeId: serializer.fromJson<int>(json['recipeId']),
      typeId: serializer.fromJson<int>(json['typeId']),
      name: serializer.fromJson<String>(json['name']),
      image: serializer.fromJson<String>(json['image']),
      ingredients: serializer.fromJson<String>(json['ingredients']),
      steps: serializer.fromJson<String>(json['steps']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'recipeId': serializer.toJson<int>(recipeId),
      'typeId': serializer.toJson<int>(typeId),
      'name': serializer.toJson<String>(name),
      'image': serializer.toJson<String>(image),
      'ingredients': serializer.toJson<String>(ingredients),
      'steps': serializer.toJson<String>(steps),
    };
  }

  RecipeData copyWith({
    int? recipeId,
    int? typeId,
    String? name,
    String? image,
    String? ingredients,
    String? steps,
  }) => RecipeData(
    recipeId: recipeId ?? this.recipeId,
    typeId: typeId ?? this.typeId,
    name: name ?? this.name,
    image: image ?? this.image,
    ingredients: ingredients ?? this.ingredients,
    steps: steps ?? this.steps,
  );
  RecipeData copyWithCompanion(RecipeTableCompanion data) {
    return RecipeData(
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      name: data.name.present ? data.name.value : this.name,
      image: data.image.present ? data.image.value : this.image,
      ingredients:
          data.ingredients.present ? data.ingredients.value : this.ingredients,
      steps: data.steps.present ? data.steps.value : this.steps,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeData(')
          ..write('recipeId: $recipeId, ')
          ..write('typeId: $typeId, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('ingredients: $ingredients, ')
          ..write('steps: $steps')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(recipeId, typeId, name, image, ingredients, steps);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeData &&
          other.recipeId == this.recipeId &&
          other.typeId == this.typeId &&
          other.name == this.name &&
          other.image == this.image &&
          other.ingredients == this.ingredients &&
          other.steps == this.steps);
}

class RecipeTableCompanion extends UpdateCompanion<RecipeData> {
  final Value<int> recipeId;
  final Value<int> typeId;
  final Value<String> name;
  final Value<String> image;
  final Value<String> ingredients;
  final Value<String> steps;
  const RecipeTableCompanion({
    this.recipeId = const Value.absent(),
    this.typeId = const Value.absent(),
    this.name = const Value.absent(),
    this.image = const Value.absent(),
    this.ingredients = const Value.absent(),
    this.steps = const Value.absent(),
  });
  RecipeTableCompanion.insert({
    this.recipeId = const Value.absent(),
    required int typeId,
    required String name,
    required String image,
    required String ingredients,
    required String steps,
  }) : typeId = Value(typeId),
       name = Value(name),
       image = Value(image),
       ingredients = Value(ingredients),
       steps = Value(steps);
  static Insertable<RecipeData> custom({
    Expression<int>? recipeId,
    Expression<int>? typeId,
    Expression<String>? name,
    Expression<String>? image,
    Expression<String>? ingredients,
    Expression<String>? steps,
  }) {
    return RawValuesInsertable({
      if (recipeId != null) 'recipe_id': recipeId,
      if (typeId != null) 'type_id': typeId,
      if (name != null) 'name': name,
      if (image != null) 'image': image,
      if (ingredients != null) 'ingredients': ingredients,
      if (steps != null) 'steps': steps,
    });
  }

  RecipeTableCompanion copyWith({
    Value<int>? recipeId,
    Value<int>? typeId,
    Value<String>? name,
    Value<String>? image,
    Value<String>? ingredients,
    Value<String>? steps,
  }) {
    return RecipeTableCompanion(
      recipeId: recipeId ?? this.recipeId,
      typeId: typeId ?? this.typeId,
      name: name ?? this.name,
      image: image ?? this.image,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<int>(typeId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (ingredients.present) {
      map['ingredients'] = Variable<String>(ingredients.value);
    }
    if (steps.present) {
      map['steps'] = Variable<String>(steps.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeTableCompanion(')
          ..write('recipeId: $recipeId, ')
          ..write('typeId: $typeId, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('ingredients: $ingredients, ')
          ..write('steps: $steps')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RecipeTypesTableTable recipeTypesTable = $RecipeTypesTableTable(
    this,
  );
  late final $RecipeTableTable recipeTable = $RecipeTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    recipeTypesTable,
    recipeTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipe_types_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_table', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$RecipeTypesTableTableCreateCompanionBuilder =
    RecipeTypesTableCompanion Function({
      Value<int> typeId,
      required String name,
    });
typedef $$RecipeTypesTableTableUpdateCompanionBuilder =
    RecipeTypesTableCompanion Function({Value<int> typeId, Value<String> name});

final class $$RecipeTypesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecipeTypesTableTable,
          RecipeTypesTableData
        > {
  $$RecipeTypesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$RecipeTableTable, List<RecipeData>>
  _recipeTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recipeTable,
    aliasName: $_aliasNameGenerator(
      db.recipeTypesTable.typeId,
      db.recipeTable.typeId,
    ),
  );

  $$RecipeTableTableProcessedTableManager get recipeTableRefs {
    final manager = $$RecipeTableTableTableManager(
      $_db,
      $_db.recipeTable,
    ).filter((f) => f.typeId.typeId.sqlEquals($_itemColumn<int>('type_id')!));

    final cache = $_typedResult.readTableOrNull(_recipeTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RecipeTypesTableTableFilterComposer
    extends Composer<_$AppDatabase, $RecipeTypesTableTable> {
  $$RecipeTypesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get typeId => $composableBuilder(
    column: $table.typeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> recipeTableRefs(
    Expression<bool> Function($$RecipeTableTableFilterComposer f) f,
  ) {
    final $$RecipeTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.recipeTable,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeTableTableFilterComposer(
            $db: $db,
            $table: $db.recipeTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecipeTypesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipeTypesTableTable> {
  $$RecipeTypesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get typeId => $composableBuilder(
    column: $table.typeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecipeTypesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipeTypesTableTable> {
  $$RecipeTypesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get typeId =>
      $composableBuilder(column: $table.typeId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> recipeTableRefs<T extends Object>(
    Expression<T> Function($$RecipeTableTableAnnotationComposer a) f,
  ) {
    final $$RecipeTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.recipeTable,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeTableTableAnnotationComposer(
            $db: $db,
            $table: $db.recipeTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecipeTypesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeTypesTableTable,
          RecipeTypesTableData,
          $$RecipeTypesTableTableFilterComposer,
          $$RecipeTypesTableTableOrderingComposer,
          $$RecipeTypesTableTableAnnotationComposer,
          $$RecipeTypesTableTableCreateCompanionBuilder,
          $$RecipeTypesTableTableUpdateCompanionBuilder,
          (RecipeTypesTableData, $$RecipeTypesTableTableReferences),
          RecipeTypesTableData,
          PrefetchHooks Function({bool recipeTableRefs})
        > {
  $$RecipeTypesTableTableTableManager(
    _$AppDatabase db,
    $RecipeTypesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$RecipeTypesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$RecipeTypesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$RecipeTypesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> typeId = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => RecipeTypesTableCompanion(typeId: typeId, name: name),
          createCompanionCallback:
              ({
                Value<int> typeId = const Value.absent(),
                required String name,
              }) =>
                  RecipeTypesTableCompanion.insert(typeId: typeId, name: name),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$RecipeTypesTableTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({recipeTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (recipeTableRefs) db.recipeTable],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (recipeTableRefs)
                    await $_getPrefetchedData<
                      RecipeTypesTableData,
                      $RecipeTypesTableTable,
                      RecipeData
                    >(
                      currentTable: table,
                      referencedTable: $$RecipeTypesTableTableReferences
                          ._recipeTableRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$RecipeTypesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).recipeTableRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.typeId == item.typeId,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RecipeTypesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeTypesTableTable,
      RecipeTypesTableData,
      $$RecipeTypesTableTableFilterComposer,
      $$RecipeTypesTableTableOrderingComposer,
      $$RecipeTypesTableTableAnnotationComposer,
      $$RecipeTypesTableTableCreateCompanionBuilder,
      $$RecipeTypesTableTableUpdateCompanionBuilder,
      (RecipeTypesTableData, $$RecipeTypesTableTableReferences),
      RecipeTypesTableData,
      PrefetchHooks Function({bool recipeTableRefs})
    >;
typedef $$RecipeTableTableCreateCompanionBuilder =
    RecipeTableCompanion Function({
      Value<int> recipeId,
      required int typeId,
      required String name,
      required String image,
      required String ingredients,
      required String steps,
    });
typedef $$RecipeTableTableUpdateCompanionBuilder =
    RecipeTableCompanion Function({
      Value<int> recipeId,
      Value<int> typeId,
      Value<String> name,
      Value<String> image,
      Value<String> ingredients,
      Value<String> steps,
    });

final class $$RecipeTableTableReferences
    extends BaseReferences<_$AppDatabase, $RecipeTableTable, RecipeData> {
  $$RecipeTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RecipeTypesTableTable _typeIdTable(_$AppDatabase db) =>
      db.recipeTypesTable.createAlias(
        $_aliasNameGenerator(db.recipeTable.typeId, db.recipeTypesTable.typeId),
      );

  $$RecipeTypesTableTableProcessedTableManager get typeId {
    final $_column = $_itemColumn<int>('type_id')!;

    final manager = $$RecipeTypesTableTableTableManager(
      $_db,
      $_db.recipeTypesTable,
    ).filter((f) => f.typeId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_typeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecipeTableTableFilterComposer
    extends Composer<_$AppDatabase, $RecipeTableTable> {
  $$RecipeTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get recipeId => $composableBuilder(
    column: $table.recipeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnFilters(column),
  );

  $$RecipeTypesTableTableFilterComposer get typeId {
    final $$RecipeTypesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.recipeTypesTable,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeTypesTableTableFilterComposer(
            $db: $db,
            $table: $db.recipeTypesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipeTableTable> {
  $$RecipeTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get recipeId => $composableBuilder(
    column: $table.recipeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecipeTypesTableTableOrderingComposer get typeId {
    final $$RecipeTypesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.recipeTypesTable,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeTypesTableTableOrderingComposer(
            $db: $db,
            $table: $db.recipeTypesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipeTableTable> {
  $$RecipeTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get recipeId =>
      $composableBuilder(column: $table.recipeId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<String> get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => column,
  );

  GeneratedColumn<String> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  $$RecipeTypesTableTableAnnotationComposer get typeId {
    final $$RecipeTypesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.recipeTypesTable,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeTypesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.recipeTypesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeTableTable,
          RecipeData,
          $$RecipeTableTableFilterComposer,
          $$RecipeTableTableOrderingComposer,
          $$RecipeTableTableAnnotationComposer,
          $$RecipeTableTableCreateCompanionBuilder,
          $$RecipeTableTableUpdateCompanionBuilder,
          (RecipeData, $$RecipeTableTableReferences),
          RecipeData,
          PrefetchHooks Function({bool typeId})
        > {
  $$RecipeTableTableTableManager(_$AppDatabase db, $RecipeTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$RecipeTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$RecipeTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$RecipeTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> recipeId = const Value.absent(),
                Value<int> typeId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> image = const Value.absent(),
                Value<String> ingredients = const Value.absent(),
                Value<String> steps = const Value.absent(),
              }) => RecipeTableCompanion(
                recipeId: recipeId,
                typeId: typeId,
                name: name,
                image: image,
                ingredients: ingredients,
                steps: steps,
              ),
          createCompanionCallback:
              ({
                Value<int> recipeId = const Value.absent(),
                required int typeId,
                required String name,
                required String image,
                required String ingredients,
                required String steps,
              }) => RecipeTableCompanion.insert(
                recipeId: recipeId,
                typeId: typeId,
                name: name,
                image: image,
                ingredients: ingredients,
                steps: steps,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$RecipeTableTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({typeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (typeId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.typeId,
                            referencedTable: $$RecipeTableTableReferences
                                ._typeIdTable(db),
                            referencedColumn:
                                $$RecipeTableTableReferences
                                    ._typeIdTable(db)
                                    .typeId,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecipeTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeTableTable,
      RecipeData,
      $$RecipeTableTableFilterComposer,
      $$RecipeTableTableOrderingComposer,
      $$RecipeTableTableAnnotationComposer,
      $$RecipeTableTableCreateCompanionBuilder,
      $$RecipeTableTableUpdateCompanionBuilder,
      (RecipeData, $$RecipeTableTableReferences),
      RecipeData,
      PrefetchHooks Function({bool typeId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RecipeTypesTableTableTableManager get recipeTypesTable =>
      $$RecipeTypesTableTableTableManager(_db, _db.recipeTypesTable);
  $$RecipeTableTableTableManager get recipeTable =>
      $$RecipeTableTableTableManager(_db, _db.recipeTable);
}
