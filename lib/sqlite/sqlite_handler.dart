import 'package:path/path.dart';
import 'package:project/constants/sqlite_const.dart';
import 'package:sqflite/sqflite.dart';

import 'quiz_question.dart';

class SqliteHandler {
  Database? _database;

  //get database
  static Future<Database> get database async {
    final SqliteHandler handler = SqliteHandler();
    if (handler._database != null) return handler._database!;

    handler._database = await handler.setupDatabase();
    return handler._database!;
  }

  //setup database
  Future<Database> setupDatabase() async {
    final database = await openDatabase(
      join(await getDatabasesPath(), SqliteConst.dbName),
      version: SqliteConst.dbVersion,
      onCreate: (db, version) {
        return db.execute(SqliteConst.createDatabase);
      },
    );
    return database;
  }

  //add question
  Future<void> addQuestion(QuizQuestion question) async {
    final db = await SqliteHandler.database;

    await db.insert(
      'questions',
      question.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //delete question
  Future<void> deleteQuestion(int id) async {
    final db = await SqliteHandler.database;

    await db.delete(
      'questions',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  //get stored questions
  Future<List<QuizQuestion>> getStoredQuestions() async {
    final db = await SqliteHandler.database;

    final List<Map<String, dynamic>> maps = await db.query('questions');

    return List.generate(maps.length, (i) {
      return QuizQuestion.fromMap(maps[i]);
    });
  }
}
