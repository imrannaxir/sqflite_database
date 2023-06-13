import 'package:sqflite_database/db_helper.dart';
import 'package:sqflite_database/student.dart';

Future<bool> insertStudent(Student student) async {
  final db = await DBHelper.database;

  /*
     The student.toMap() method is called to convert the 'Student' object into a map representation that can be stored in the database. 
   */
  var rowId = await db.insert(DBHelper.tableName, student.toMap());

  /*
       return rowId > 0;: It returns a boolean value indicating the success of the insertion operation. If the rowId is greater than 0, it means the insertion was successful, and true is returned. Otherwise, it implies that no rows were inserted, and false is returned.
   */
  return rowId > 0;
}
