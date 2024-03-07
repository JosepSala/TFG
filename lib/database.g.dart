// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorMyAppDB {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MyAppDBBuilder databaseBuilder(String name) =>
      _$MyAppDBBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MyAppDBBuilder inMemoryDatabaseBuilder() => _$MyAppDBBuilder(null);
}

class _$MyAppDBBuilder {
  _$MyAppDBBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$MyAppDBBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$MyAppDBBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<MyAppDB> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$MyAppDB();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$MyAppDB extends MyAppDB {
  _$MyAppDB([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UsuariDao? _usuariDaoInstance;

  VehicleDao? _vehicleDaoInstance;

  ComisoServeiDao? _comisoServeiDaoInstance;

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
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `usuaris` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `nom` TEXT NOT NULL, `cognom` TEXT NOT NULL, `treball` TEXT, `grup` TEXT, `user` TEXT NOT NULL, `password` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `vehicles` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `matricula` TEXT, `marca` TEXT, `model` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `comisoservei` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `descripcio` TEXT NOT  NULL,`h_ixida` TEXT NOT NULL, `h_tornada` TEXT NOT NULL, `dia` TEXT, `km_total` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UsuariDao get usuariDao {
    return _usuariDaoInstance ??= _$UsuariDao(database, changeListener);
  }

  @override
  VehicleDao get vehicleDao {
    return _vehicleDaoInstance ??= _$VehicleDao(database, changeListener);
  }

  @override
  ComisoServeiDao get comisoServeiDao {
    return _comisoServeiDaoInstance ??=
        _$ComisoServeiDao(database, changeListener);
  }
}

class _$UsuariDao extends UsuariDao {
  _$UsuariDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _usuariInsertionAdapter = InsertionAdapter(
            database,
            'usuaris',
            (Usuari item) => <String, Object?>{
                  'nom': item.nom,
                  'cognom': item.cognom,
                  'treball': item.treball,
                  'grup': item.grup,
                  'user': item.user,
                  'password': item.password
                }),
        _usuariUpdateAdapter = UpdateAdapter(
            database,
            'usuaris',
            ['id'],
            (Usuari item) => <String, Object?>{
                  'id': item.id,
                  'nom': item.nom,
                  'cognom': item.cognom,
                  'treball': item.treball,
                  'grup': item.grup,
                  'user': item.user,
                  'password': item.password
                }),
        _usuariDeletionAdapter = DeletionAdapter(
            database,
            'usuaris',
            ['id'],
            (Usuari item) => <String, Object?>{
                  'id': item.id,
                  'nom': item.nom,
                  'cognom': item.cognom,
                  'treball': item.treball,
                  'grup': item.grup,
                  'user': item.user,
                  'password': item.password
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Usuari> _usuariInsertionAdapter;

  final UpdateAdapter<Usuari> _usuariUpdateAdapter;

  final DeletionAdapter<Usuari> _usuariDeletionAdapter;

  @override
  Future<List<Usuari>> getAllUsuarios() async {
    return _queryAdapter.queryList('SELECT * FROM usuaris',
        mapper: (Map<String, Object?> row) => Usuari(row['id'] as int?,
            nom: row['nom'] as String,
            cognom: row['cognom'] as String,
            treball: row['treball'] as String?,
            grup: row['grup'] as String?,
            user: row['user'] as String,
            password: row['password'] as String));
  }

  @override
  Future<Usuari?> getUsuarioById(int id) async {
    return _queryAdapter.query('SELECT * FROM usuaris WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Usuari(row['id'] as int?,
            nom: row['nom'] as String,
            cognom: row['cognom'] as String,
            treball: row['treball'] as String?,
            grup: row['grup'] as String?,
            user: row['user'] as String,
            password: row['password'] as String),
        arguments: [id]);
  }

  @override
  Future<Usuari?> getUsuarioByCredenciales(
    String user,
    String password,
  ) async {
    return _queryAdapter.query(
        'SELECT * FROM usuaris WHERE user = :user AND password = :password',
        mapper: (Map<String, Object?> row) => Usuari(row['id'] as int?,
            nom: row['nom'] as String,
            cognom: row['cognom'] as String,
            treball: row['treball'] as String?,
            grup: row['grup'] as String?,
            user: row['user'] as String,
            password: row['password'] as String),
        arguments: [user, password]);
  }

  @override
  Future<void> insertUsuario(Usuari usuari) async {
    await _usuariInsertionAdapter.insert(usuari, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUsuario(Usuari usuari) async {
    await _usuariUpdateAdapter.update(usuari, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteUsuario(Usuari usuari) async {
    await _usuariDeletionAdapter.delete(usuari);
  }
}

class _$VehicleDao extends VehicleDao {
  _$VehicleDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _vehicleInsertionAdapter = InsertionAdapter(
            database,
            'vehicles',
            (Vehicle item) => <String, Object?>{
                  'matricula': item.matricula,
                  'marca': item.marca,
                  'model': item.model
                }),
        _vehicleUpdateAdapter = UpdateAdapter(
            database,
            'vehicles',
            ['id'],
            (Vehicle item) => <String, Object?>{
                  'id': item.id,
                  'matricula': item.matricula,
                  'marca': item.marca,
                  'model': item.model
                }),
        _vehicleDeletionAdapter = DeletionAdapter(
            database,
            'vehicles',
            ['id'],
            (Vehicle item) => <String, Object?>{
                  'id': item.id,
                  'matricula': item.matricula,
                  'marca': item.marca,
                  'model': item.model
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Vehicle> _vehicleInsertionAdapter;

  final UpdateAdapter<Vehicle> _vehicleUpdateAdapter;

  final DeletionAdapter<Vehicle> _vehicleDeletionAdapter;

  @override
  Future<List<Vehicle>> getAllVehicles() async {
    return _queryAdapter.queryList('SELECT * FROM vehicles',
        mapper: (Map<String, Object?> row) => Vehicle(row['id'] as int,
            matricula: row['matricula'] as String?,
            marca: row['marca'] as String?,
            model: row['model'] as String?));
  }

  @override
  Future<List<Vehicle>> findAllVehicles() async {
    return _queryAdapter.queryList('SELECT * FROM vehicles',
        mapper: (Map<String, Object?> row) => Vehicle(row['id'] as int,
            matricula: row['matricula'] as String?,
            marca: row['marca'] as String?,
            model: row['model'] as String?));
  }

  @override
  Future<Vehicle?> getVehicleById(int id) async {
    return _queryAdapter.query('SELECT * FROM vehicles WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Vehicle(row['id'] as int,
            matricula: row['matricula'] as String?,
            marca: row['marca'] as String?,
            model: row['model'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> insertVehicle(Vehicle vehicle) async {
    await _vehicleInsertionAdapter.insert(vehicle, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateVehicle(Vehicle vehicle) async {
    await _vehicleUpdateAdapter.update(vehicle, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteVehicle(Vehicle vehicle) async {
    await _vehicleDeletionAdapter.delete(vehicle);
  }
}

class _$ComisoServeiDao extends ComisoServeiDao {
  _$ComisoServeiDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _comisoServeiInsertionAdapter = InsertionAdapter(
            database,
            'comisoservei',
            (ComisoServei item) => <String, Object?>{
                  'descripcio': item.descripcio,
                  'h_ixida': item.h_ixida,
                  'h_tornada': item.h_tornada,
                  'dia': item.dia,
                  'km_total': item.km_total
                }),
        _comisioServeiUpdateAdapter = UpdateAdapter(
            database,
            'comisioservei',
            ['id'],
            (ComisoServei item) => <String, Object?>{
                  'id': item.id,
                  'descripcio': item.descripcio,
                  'h_ixida': item.h_ixida,
                  'h_tornada': item.h_tornada,
                  'dia': item.dia,
                  'km_total': item.km_total
                }),
        _comisoServeiDeletionAdapter = DeletionAdapter(
            database,
            'comisoservei',
            ['id'],
            (ComisoServei item) => <String, Object?>{
                  'id': item.id,
                  'descripcio': item.descripcio,
                  'h_ixida': item.h_ixida,
                  'h_tornada': item.h_tornada,
                  'dia': item.dia,
                  'km_total': item.km_total
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ComisoServei> _comisoServeiInsertionAdapter;

  final UpdateAdapter<ComisoServei> _comisioServeiUpdateAdapter;

  final DeletionAdapter<ComisoServei> _comisoServeiDeletionAdapter;

  @override
  Future<List<ComisoServei>> findAllComisiones() {
    return _queryAdapter.queryList('SELECT * FROM comisoservei',
        mapper: (Map<String, Object?> row) => ComisoServei(row['id'] as int,
            descripcio: row['descripcio'] as String,
            h_ixida: row['h_ixida'] as String,
            h_tornada: row['h_tornada'] as String,
            dia: row['dia'] as String,
            km_total: row['km_total'] as String));
  }

  @override
  Future<ComisoServei?> findComisionesById(int id) async {
    return _queryAdapter.query('SELECT * FROM comisoservei WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ComisoServei(row['id'] as int,
            descripcio: row['descripcio'] as String,
            h_ixida: row['h_ixida'] as String,
            h_tornada: row['h_tornada'] as String,
            dia: row['dia'] as String,
            km_total: row['km_total'] as String),
        arguments: [id]);
  }

  @override
  Future<List<ComisoServei>> findAllComisionesStream() {
    return _queryAdapter.queryList('SELECT * FROM comisoservei',
        mapper: (Map<String, Object?> row) => ComisoServei(row['id'] as int,
            descripcio: row['descripcio'] as String,
            h_ixida: row['h_ixida'] as String,
            h_tornada: row['h_tornada'] as String,
            dia: row['dia'] as String,
            km_total: row['km_total'] as String));
  }

  @override
  Future<void> insertComisiones(ComisoServei comisoServei) async {
    await _comisoServeiInsertionAdapter.insert(comisoServei, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteComisiones(ComisoServei comisoServei) async {
    await _comisoServeiDeletionAdapter.delete(comisoServei);
  }

  @override
  Future<void> updateComisiones(ComisoServei comisoServei) async {
    await _comisioServeiUpdateAdapter.update(
        comisoServei, OnConflictStrategy.abort);
  }
}
