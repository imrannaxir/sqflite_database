import 'package:sqflite/sqflite.dart';

class DBHelper extends Sqflite {
  static Database? _database;

  static const tableName = 'student';
   
   /*
       These declare constant variables keyRollNo, keyName, and keyFee representing the column names in the student table.
    */
  static const keyRollNo = 'rollNo';
  static const keyName = 'name';
  static const keyFee = 'fee';

  static const createTable =
      'CREATE TABLE IF NOT EXISTS $tableName($keyRollNo INTEGER AUTO INCREMENT ,$keyName TEXT ,$keyFee REAL )';

  static const dropTable = 'DROP TABLE $tableName IF EXISTS';

  static Future<Database> get database async {
    var databasePath = await getDatabasesPath();

    return _database ??= await openDatabase(
      'path: ${databasePath.toString()}',
      onCreate: (db, version) {
        db.execute(createTable);
      },
      version: 1,
    );
  }
}
