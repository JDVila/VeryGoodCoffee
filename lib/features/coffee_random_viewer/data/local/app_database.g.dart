// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process
  /// is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FavoriteCoffeeDao? _favoriteCoffeeDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
          database,
          startVersion,
          endVersion,
          migrations,
        );

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
          '''CREATE TABLE IF NOT EXISTS `FavoriteCoffees` (`imageUrl` TEXT NOT NULL, `id` INTEGER, `fileName` TEXT, `imageBytes` TEXT, PRIMARY KEY (`imageUrl`))''',
        );

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FavoriteCoffeeDao get favoriteCoffeeDao {
    return _favoriteCoffeeDaoInstance ??=
        _$FavoriteCoffeeDao(database, changeListener);
  }
}

class _$FavoriteCoffeeDao extends FavoriteCoffeeDao {
  _$FavoriteCoffeeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _favoriteCoffeeModelInsertionAdapter = InsertionAdapter(
          database,
          'FavoriteCoffees',
          (FavoriteCoffeeModel item) => <String, Object?>{
            'imageUrl': item.imageUrl,
            'id': item.id,
            'fileName': item.fileName,
            'imageBytes': item.imageBytes,
          },
        ),
        _favoriteCoffeeModelDeletionAdapter = DeletionAdapter(
          database,
          'FavoriteCoffees',
          ['imageUrl'],
          (FavoriteCoffeeModel item) => <String, Object?>{
            'imageUrl': item.imageUrl,
            'id': item.id,
            'fileName': item.fileName,
            'imageBytes': item.imageBytes,
          },
        );

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FavoriteCoffeeModel>
      _favoriteCoffeeModelInsertionAdapter;

  final DeletionAdapter<FavoriteCoffeeModel>
      _favoriteCoffeeModelDeletionAdapter;

  @override
  Future<List<FavoriteCoffeeModel>> getAllFavoriteCoffees() async {
    return _queryAdapter.queryList(
      'SELECT * FROM FavoriteCoffees',
      mapper: (Map<String, Object?> row) => FavoriteCoffeeModel(
        imageUrl: row['imageUrl']! as String,
        id: row['id'] as int?,
        fileName: row['fileName'] as String?,
        imageBytes: row['imageBytes'] as String?,
      ),
    );
  }

  @override
  Future<List<FavoriteCoffeeModel>> checkFavoriteCoffee(String imageUrl) async {
    return _queryAdapter.queryList(
      'SELECT * FROM FavoriteCoffees WHERE imageUrl = ?1',
      mapper: (Map<String, Object?> row) => FavoriteCoffeeModel(
        imageUrl: row['imageUrl']! as String,
        id: row['id'] as int?,
        fileName: row['fileName'] as String?,
        imageBytes: row['imageBytes'] as String?,
      ),
      arguments: [imageUrl],
    );
  }

  @override
  Future<void> insertFavoriteCoffee(FavoriteCoffeeModel newFavorite) async {
    await _favoriteCoffeeModelInsertionAdapter.insert(
      newFavorite,
      OnConflictStrategy.abort,
    );
  }

  @override
  Future<void> deleteFavoriteCoffee(FavoriteCoffeeModel formerFavorite) async {
    await _favoriteCoffeeModelDeletionAdapter.delete(formerFavorite);
  }
}
