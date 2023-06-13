import 'package:sqflite_database/db_helper.dart';
import 'package:sqflite_database/student.dart';

// A method that retrieves all the dogs from the dogs table.

Future<List<Student>> fetchStudents() async {
  // Get a reference to the database.
  final db = await DBHelper.database;

  // Query the table for all The Students.
  var maps = await db.query(DBHelper.tableName);

  // Convert the List<Map<String, dynamic> into a List<Students>.
  return maps.map((e) => Student.fromJson(e as String)).toList();
}
