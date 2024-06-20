import 'dart:io';
import 'package:access_control/src/configuration/models/configuration_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' show join;

class DBConfigurationProvider {
  static Database? _database;

  static final DBConfigurationProvider db = DBConfigurationProvider();
  DBConfigurationProvider();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ConfigurationsDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Configurations(
            id INTEGER PRIMARY KEY,
            serverDirection TEXT
          )
        ''');
      },
    );
  }

  Future<int> newConfigurationRaw({
    required ConfigurationModel newConfiguration,
  }) async {
    final id = newConfiguration.id;
    final serverDirection = newConfiguration.serverDirection;

    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Configurations(id, serverDirection)
        VALUES ($id, '$serverDirection')
    ''');

    return res;
  }

  Future<int> newConfiguration(ConfigurationModel newConfiguration) async {
    final db = await database;
    final res = await db.insert('Configurations', newConfiguration.toJson());
    return res;
  }

  Future<ConfigurationModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query(
      'Configurations',
      where: 'id = ?',
      whereArgs: [id],
    );

    return res.isNotEmpty ? ConfigurationModel.fromJson(res.first) : null;
  }

  Future<List<ConfigurationModel>?> getAllConfigurations() async {
    final db = await database;
    final res = await db.query('Configurations');

    return res.isNotEmpty
        ? res.map((e) => ConfigurationModel.fromJson(e)).toList()
        : [];
  }

  Future<int> updateConfiguration(ConfigurationModel newConfiguration) async {
    final db = await database;
    final res = await db.update(
      'Configurations',
      newConfiguration.toJson(),
      where: 'id=?',
      whereArgs: [newConfiguration.id],
    );

    return res;
  }

  Future<int> deleteConfiguration(int id) async {
    final db = await database;
    final res = await db.delete(
      'Configurations',
      where: 'id=?',
      whereArgs: [id],
    );
    return res;
  }

  Future<int> deleteAllConfigurations() async {
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Configurations
    ''');
    return res;
  }
}
