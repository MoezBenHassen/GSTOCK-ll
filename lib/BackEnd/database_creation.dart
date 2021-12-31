import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:gstock/BackEnd/Models/admin_model.dart';
import 'package:gstock/BackEnd/Models/category_model.dart';
import 'package:gstock/BackEnd/Models/composant_model.dart';
import 'package:gstock/BackEnd/Models/emprunt_model.dart';
import 'package:gstock/BackEnd/Models/membre_model.dart';
import 'package:gstock/BackEnd/Models/retour_model.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Dbcreate {
  Future<Database> main() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "gstock.db");
    return await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS membre(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nom STRING,
              prenom STRING,
              tel1 INTEGER,
              tel2 INTEGER
              )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS category(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name STRING UNIQUE
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS composant(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name STRING,
          obtenue STRING,
          stock INTEGER,
          FK_category INTEGER,
          FOREIGN KEY (FK_category) REFERENCES category (id)
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS admin(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name STRING,
          password STRING
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS emprunt(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          FK_composant INTEGER,
          date STRING,
          FOREIGN KEY (FK_composant) REFERENCES composant (id)
          )
        ''');

        await db.execute('''
          CREATE TABLE IF NOT EXISTS retour(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          FK_composant INTEGER,
          date STRING,
          etat STRING,
          FOREIGN KEY (FK_composant) REFERENCES composant (id)
          )
        ''');
      },
      version: 1,
    );
  }

  //------------------[ADMIN FUNCTIONS]------------------
  Future<int> insertAdmin(Admin admin) async {
    final db = await main();
    return db.insert(
      'admin',
      admin.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Admin>> fetchAdmin() async {
    final db = await main();
    final List<Map<String, dynamic>> maps = await db.query('admin');
    return List.generate(maps.length, (i) {
      return Admin(
        id: maps[i]['id'],
        name: maps[i]['name'],
        password: maps[i]['password'],
      );
    });
  }

  //------------------[CATEGORY  FUNCTIONS]------------------
  Future<int> insertCateg(Category category) async {
    final db = await main();
    return db.insert(
      'category',
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Category>> fetchCateg() async {
    final db = await main();
    final List<Map<String, dynamic>> maps = await db.query('category');
    return List.generate(maps.length, (i) {
      return Category(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

  Future<int> deleteCateg(int id) async {
    //returns number of items deleted
    final db = await main();

    int result = await db.delete("category", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
        );
    return result;
  }

  Future<int> updateCateg(int id, Category item) async {
    // returns the number of rows updated

    final db = await main();

    int result = await db
        .update("category", item.toMap(), where: "id = ?", whereArgs: [id]);
    return result;
  }
//------------------[COMPOSANT  FUNCTIONS]------------------
  Future<int> insertComp(Composant composant) async {
    final db = await main();
    return db.insert(
      'composant',
      composant.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Composant>> fetchComp() async {
    final db = await main();
    final List<Map<String, dynamic>> maps = await db.query('composant');
    return List.generate(maps.length, (i) {
      return Composant(
        id: maps[i]['id'],
        name: maps[i]['name'],
        obtenue: DateTime.parse(maps[i]['obtenue']),
        stock: maps[i]['stock'],
        category: maps[i]['FK_category'],
      );
    });
  }

  Future<int> deleteComp(int id) async {
    //returns number of items deleted
    final db = await main();

    int result = await db.delete("composant", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
    );
    return result;
  }

  Future<int> updateComp(int id, Composant item) async {
    // returns the number of rows updated

    final db = await main();

    int result = await db
        .update("composant", item.toMap(), where: "id = ?", whereArgs: [id]);
    return result;
  }

//------------------[MEMBRE  FUNCTIONS]------------------
  Future<int> insertMem(Membre membre) async {
    final db = await main();
    return db.insert(
      'membre',
      membre.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Membre>> fetchMem() async {
    final db = await main();
    final List<Map<String, dynamic>> maps = await db.query('membre');
    return List.generate(maps.length, (i) {
      return Membre(
          id: maps[i]['id'],
          nom: maps[i]['nom'],
          prenom: maps[i]['prenom'],
          tel1: maps[i]['tel1'],
          tel2: maps[i]['tel2'],
      );
    });
  }

  Future<int> deleteMem(int id) async {
    //returns number of items deleted
    final db = await main();

    int result = await db.delete("membre", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
    );
    return result;
  }

  Future<int> updateMem(int id, Membre item) async {
    // returns the number of rows updated

    final db = await main();

    int result = await db
        .update("membre", item.toMap(), where: "id = ?", whereArgs: [id]);
    return result;
  }

//------------------[EMPRUNT  FUNCTIONS]------------------
  Future<int> insertEmp(Emprunt emprunt) async {
    final db = await main();
    return db.insert(
      'emprunt',
      emprunt.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Emprunt>> fetchEmp() async {
    final db = await main();
    final List<Map<String, dynamic>> maps = await db.query('emprunt');
    return List.generate(maps.length, (i) {
      return Emprunt(
        id: maps[i]['id'],
        composant: maps[i]['FK_composant'],
        date: maps[i]['date'],
      );
    });
  }

  Future<int> deleteEmp(int id) async {
    //returns number of items deleted
    final db = await main();

    int result = await db.delete("emprunt", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
    );
    return result;
  }

  Future<int> updateEmp(int id, Emprunt item) async {
    // returns the number of rows updated

    final db = await main();

    int result = await db
        .update("emprunt", item.toMap(), where: "id = ?", whereArgs: [id]);
    return result;
  }

//------------------[RETOUR  FUNCTIONS]------------------
  Future<int> insertRet(Retour retour) async {
    final db = await main();
    return db.insert(
      'retour',
      retour.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Retour>> fetchRet() async {
    final db = await main();
    final List<Map<String, dynamic>> maps = await db.query('retour');
    return List.generate(maps.length, (i) {
      return Retour(
        id: maps[i]['id'],
        composant: maps[i]['FK_composant'],
        date: maps[i]['date'],
        etat: maps[i]['etat'],
      );
    });
  }

  Future<int> deleteRet(int id) async {
    //returns number of items deleted
    final db = await main();

    int result = await db.delete("retour", //table name
        where: "id = ?",
        whereArgs: [id] // use whereArgs to avoid SQL injection
    );
    return result;
  }

  Future<int> updateRet(int id, Retour item) async {
    // returns the number of rows updated

    final db = await main();

    int result = await db
        .update("retour", item.toMap(), where: "id = ?", whereArgs: [id]);
    return result;
  }

}
