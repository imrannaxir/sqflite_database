import 'package:sqflite_database/db_helper.dart';
import 'package:sqflite_database/student.dart';

Future<bool> deleteSudent(Student student) async {
  final db = await DBHelper.database;

  var rowId = await db.delete(
    DBHelper.tableName,
    where: '${DBHelper.keyRollNo} = ?',
    whereArgs: [student.rollNo],
  );
  return rowId > 0;
}
