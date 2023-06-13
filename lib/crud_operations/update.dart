import 'package:sqflite_database/db_helper.dart';
import 'package:sqflite_database/student.dart';

// When you want to update somethig in StudentTable

Future<bool> updateStudent(Student student) async {
  final db = await DBHelper.database;
  var rowId = await db.update(
    DBHelper.tableName,
    student.toMap(),
  );
  return rowId > 0;
}