class SqliteConst {
  static const String dbName = "quiz_db.db";
  static const int dbVersion = 1;
  static const String createDatabase = "CREATE TABLE IF NOT EXISTS questions (id INTEGER PRIMARY KEY, question TEXT, answer TEXT, option1 TEXT, option2 TEXT, option3 TEXT, option4 TEXT)";
}