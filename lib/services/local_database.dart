import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flora/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  Future setOnBorarding(value) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setBool('isFirstLunch', value);
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "MovieDownloadedDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Movies ("
          "videoId TEXT PRIMARY KEY,"
          "name TEXT,"
          "imageUrl TEXT,"
          "titleImageUrl TEXT,"
          "videoUrl TEXT,"
          "description TEXT,"
          "price TEXT,"
          "noDownload TEXT,"
          "category TEXT,"
          "color TEXT"
          ")");
    });
  }

  newMovie(Content newMovie) async {
    final db = await database;
    var res = await db.insert("Movies", newMovie.toMap());
    return res;
  }

  getMovie(int videoId) async {
    final db = await database;
    var res =
        await db.query("Movies", where: "videoId = ?", whereArgs: [videoId]);
    return res.isNotEmpty ? Content.fromMap(res.first) : Null;
  }

  getAllMovie() async {
    final db = await database;
    var res = await db.query("Movies");
    return res.isNotEmpty ? Content.fromMap(res.first) : Null;
  }

  updateClient(Content newMovie) async {
    final db = await database;
    var res = await db.update("Movies", newMovie.toMap(),
        where: "videoId = ?", whereArgs: [newMovie.videoId]);
    return res;
  }

  deleteClient(String videoId) async {
    final db = await database;
    print(videoId);
    return db.delete("Movies", where: "videoId = ?", whereArgs: [videoId]);
  }

  // deleteAll() async {
  //   final db = await database;
  //   db.rawDelete("Delete * From movies");
  // }

  deleteAll() async {
    final db = await database;
    db.delete("Movies");
  }

  Future<List<Content>> getAllClients() async {
    final db = await database;
    var res = await db.query("Movies");
    List<Content> list =
        res.isNotEmpty ? res.map((c) => Content.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Content>> delAllClients() async {
    final db = await database;
    var res = await db.query("Movies");
    List<Content> list =
        res.isNotEmpty ? res.map((c) => Content.fromMap(c)).toList() : [];
    return list;
  }
}
