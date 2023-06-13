import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sqflite_database/crud_operations/insert.dart';
import 'package:sqflite_database/student.dart';

class CustomDialog extends StatefulWidget {
  final TextEditingController rollNoController;
  final TextEditingController nameController;
  final TextEditingController feeController;
  const CustomDialog({
    required this.rollNoController,
    required this.nameController,
    required this.feeController,
    super.key,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  late TextEditingController rollNoController;
  late TextEditingController nameController;
  late TextEditingController feeController;

  @override
  void initState() {
    super.initState();
    rollNoController = widget.rollNoController;
    nameController = widget.nameController;
    feeController = widget.feeController;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var width = size.width;
    var height = size.height;
    var radius = min(width, height);

    return Dialog(
      insetPadding: const EdgeInsets.all(12),
      shadowColor: Colors.grey,
      surfaceTintColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      backgroundColor: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              radius: radius * 0.15,
              backgroundImage: const AssetImage(
                'assets/images/jagu.jpg',
              ),
            ),
            TextFormField(
              controller: widget.rollNoController,
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter student rollNo',
                labelText: 'RollNo',
                labelStyle: const TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            TextFormField(
              controller: widget.nameController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: 'Enter Student Name',
                labelText: 'Name',
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            TextFormField(
              controller: widget.feeController,
              cursorColor: Colors.black,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter student Fee',
                labelText: 'Fee',
                labelStyle: const TextStyle(
                  color: Colors.black,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    insertStudent(
                      Student(
                        rollNo: int.parse(
                          widget.rollNoController.text.toString(),
                        ),
                        fee: double.parse(
                          widget.feeController.text.toString(),
                        ),
                        name: widget.nameController.text.toString(),
                      ),
                    );
                   // Navigator.pop(context);
                  },
                  child: FittedBox(
                    child: Text(
                      'Insert',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
