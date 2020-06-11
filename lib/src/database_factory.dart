import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_web/sqflite_web.dart';
import 'package:sqflite_web/src/sqflite_web_impl.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';

DatabaseFactory _databaseFactoryWebImpl;

/// The web database factory.
DatabaseFactory get databaseFactoryWebImpl {
  return _databaseFactoryWebImpl ??= DatabaseFactoryWeb();
}

/// The web database factory.
class DatabaseFactoryWeb extends DatabaseFactory {
  SqfliteWebDatabase _db;

  @override
  Future<bool> databaseExists(String path) async {
    //TODO
    return _db != null;
  }

  @override
  Future<void> deleteDatabase(String path) async {
    //TODO
    return _db = null;
  }

  @override
  Future<String> getDatabasesPath() async {
    //TODO
    return null;
  }

  @override
  Future<Database> openDatabase(String path, {OpenDatabaseOptions options}) async {
    await SqflitePluginWeb.isReady;
    //return _db ??= SqfliteWebDatabase(path: path, readOnly: false, logLevel: sqfliteLogLevelVerbose);
    //support load database
    final ByteData bytes = await rootBundle.load(path);
    if((path==inMemoryDatabasePath) || (bytes.lengthInBytes==0))
    {
      return _db ??= SqfliteWebDatabase(path: path, readOnly: false, logLevel: sqfliteLogLevelVerbose);
    }
    else
    {
      final Uint8List dbBytes = bytes.buffer.asUint8List();
      return _db ??= SqfliteWebDatabase.fromData(path: path, readOnly: false, logLevel: sqfliteLogLevelVerbose, data: dbBytes);
    }
  }
}
