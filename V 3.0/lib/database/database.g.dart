// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
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

  UserDao? _userDaoInstance;

  SleepDao? _sleepDaoInstance;

  StepsDao? _stepsDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
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
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UserData` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `surname` TEXT NOT NULL, `age` INTEGER NOT NULL, `height` INTEGER NOT NULL, `weight` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SleepData` (`sleepId` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` INTEGER, `dateOfSleep` INTEGER NOT NULL, `entryDateTime` INTEGER NOT NULL, `level` TEXT, FOREIGN KEY (`userId`) REFERENCES `UserData` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `StepsData` (`stepsId` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` INTEGER, `dateOfSteps` INTEGER NOT NULL, `steps` REAL, FOREIGN KEY (`userId`) REFERENCES `UserData` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  SleepDao get sleepDao {
    return _sleepDaoInstance ??= _$SleepDao(database, changeListener);
  }

  @override
  StepsDao get stepsDao {
    return _stepsDaoInstance ??= _$StepsDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userDataInsertionAdapter = InsertionAdapter(
            database,
            'UserData',
            (UserData item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'surname': item.surname,
                  'age': item.age,
                  'height': item.height,
                  'weight': item.weight
                }),
        _userDataUpdateAdapter = UpdateAdapter(
            database,
            'UserData',
            ['id'],
            (UserData item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'surname': item.surname,
                  'age': item.age,
                  'height': item.height,
                  'weight': item.weight
                }),
        _userDataDeletionAdapter = DeletionAdapter(
            database,
            'UserData',
            ['id'],
            (UserData item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'surname': item.surname,
                  'age': item.age,
                  'height': item.height,
                  'weight': item.weight
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserData> _userDataInsertionAdapter;

  final UpdateAdapter<UserData> _userDataUpdateAdapter;

  final DeletionAdapter<UserData> _userDataDeletionAdapter;

  @override
  Future<List<UserData>> findUserData() async {
    return _queryAdapter.queryList('SELECT * FROM UserData',
        mapper: (Map<String, Object?> row) => UserData(
            row['id'] as int?,
            row['name'] as String,
            row['surname'] as String,
            row['age'] as int,
            row['height'] as int,
            row['weight'] as int));
  }

  @override
  Future<void> insertUser(UserData user) async {
    await _userDataInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUser(UserData user) async {
    await _userDataUpdateAdapter.update(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteUser(UserData user) async {
    await _userDataDeletionAdapter.delete(user);
  }
}

class _$SleepDao extends SleepDao {
  _$SleepDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _sleepDataInsertionAdapter = InsertionAdapter(
            database,
            'SleepData',
            (SleepData item) => <String, Object?>{
                  'sleepId': item.sleepId,
                  'userId': item.userId,
                  'dateOfSleep': _dateTimeConverter.encode(item.dateOfSleep),
                  'entryDateTime':
                      _dateTimeConverter.encode(item.entryDateTime),
                  'level': item.level
                }),
        _sleepDataDeletionAdapter = DeletionAdapter(
            database,
            'SleepData',
            ['sleepId'],
            (SleepData item) => <String, Object?>{
                  'sleepId': item.sleepId,
                  'userId': item.userId,
                  'dateOfSleep': _dateTimeConverter.encode(item.dateOfSleep),
                  'entryDateTime':
                      _dateTimeConverter.encode(item.entryDateTime),
                  'level': item.level
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SleepData> _sleepDataInsertionAdapter;

  final DeletionAdapter<SleepData> _sleepDataDeletionAdapter;

  @override
  Future<List<SleepData>> findSleepData() async {
    return _queryAdapter.queryList('SELECT * FROM SleepData',
        mapper: (Map<String, Object?> row) => SleepData(
            row['sleepId'] as int?,
            row['userId'] as int?,
            _dateTimeConverter.decode(row['dateOfSleep'] as int),
            _dateTimeConverter.decode(row['entryDateTime'] as int),
            row['level'] as String?));
  }

  @override
  Future<List<SleepData>> findUserSleep(int id) async {
    return _queryAdapter.queryList('SELECT * FROM SleepData WHERE userId = ?1',
        mapper: (Map<String, Object?> row) => SleepData(
            row['sleepId'] as int?,
            row['userId'] as int?,
            _dateTimeConverter.decode(row['dateOfSleep'] as int),
            _dateTimeConverter.decode(row['entryDateTime'] as int),
            row['level'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> insertSleep(List<SleepData> sleepDatas) async {
    await _sleepDataInsertionAdapter.insertList(
        sleepDatas, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSleep(List<SleepData> userSleep) async {
    await _sleepDataDeletionAdapter.deleteList(userSleep);
  }
}

class _$StepsDao extends StepsDao {
  _$StepsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _stepsDataInsertionAdapter = InsertionAdapter(
            database,
            'StepsData',
            (StepsData item) => <String, Object?>{
                  'stepsId': item.stepsId,
                  'userId': item.userId,
                  'dateOfSteps': _dateTimeConverter.encode(item.dateOfSteps),
                  'steps': item.steps
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<StepsData> _stepsDataInsertionAdapter;

  @override
  Future<List<StepsData>> findStepsData() async {
    return _queryAdapter.queryList('SELECT * FROM SleepData',
        mapper: (Map<String, Object?> row) => StepsData(
            row['stepsId'] as int?,
            row['userId'] as int?,
            _dateTimeConverter.decode(row['dateOfSteps'] as int),
            row['steps'] as double?));
  }

  @override
  Future<void> insertSteps(StepsData stepsData) async {
    await _stepsDataInsertionAdapter.insert(
        stepsData, OnConflictStrategy.abort);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
