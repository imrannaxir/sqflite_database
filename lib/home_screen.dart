import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sqflite_database/crud_operations/delete.dart';
import 'package:sqflite_database/crud_operations/insert.dart';
import 'package:sqflite_database/db_helper.dart';
import 'package:sqflite_database/student.dart';
import 'crud_operations/fetch.dart';

DBHelper dbHelper = DBHelper();

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({required this.title, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Random random = Random();

  late TextEditingController rollNoController;
  late TextEditingController nameController;
  late TextEditingController feeController;

  late Tween<double> tween;
  late Animation animation;
  late AnimationController animationController;
  bool isAnimation = true;

  @override
  void initState() {
    super.initState();
    tween = Tween<double>(begin: 0, end: 1);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    animation = tween.animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.bounceInOut,
      ),
    );
    rollNoController = TextEditingController();
    nameController = TextEditingController();
    feeController = TextEditingController();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    var data = await fetchStudents();
    print(data);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    rollNoController.dispose();
    nameController.dispose();
    feeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var width = size.width;
    var height = size.height;
    var radius = min(width, height);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
        centerTitle: true,
      ),
      body: myHomeScreen(width, height),
      floatingActionButton: myFloatingActionButton(radius),
    );
  }

  Widget myHomeScreen(width, height) {
    return FutureBuilder<List<Student>>(
      future: fetchStudents(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () {
                  showDialog(
                    barrierColor: Colors.grey,
                    context: context,
                    builder: (context) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/edit.jpg',
                            width: width * 0.3,
                            height: height * 0.3,
                          ),
                          Image.asset(
                            'assets/images/delete.png',
                            width: width * 0.3,
                            height: height * 0.3,
                          ),
                        ],
                      );
                    },
                  );
                },
                child: InkWell(
                  onLongPress: () {},
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        //backgroundColor: Colors.pink,
                        backgroundColor: Color.fromARGB(
                          256,
                          random.nextInt(256),
                          random.nextInt(256),
                          random.nextInt(256),
                        ),
                        child: Text(
                          snapshot.data![index].rollNo.toString(),
                        ),
                      ),
                      title: Text(
                        snapshot.data![index].name.toString(),
                      ),
                      subtitle: Text(
                        snapshot.data![index].fee.toString(),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          setState(() {
                            deleteSudent(
                              Student(
                                rollNo: snapshot.data![index].rollNo,
                                fee: snapshot.data![index].fee,
                                name: snapshot.data![index].name,
                              ),
                            );
                          });
                        },
                        child: const Icon(Icons.delete_forever),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(
                256,
                random.nextInt(256),
                random.nextInt(256),
                random.nextInt(256),
              ),
            ),
          );
        }
      },
    );
  }

  Widget myFloatingActionButton(radius) {
    return FloatingActionButton(
      onPressed: () async {
        setState(() {
          isAnimation = false;
          animationController.forward();
        });

        await Future.delayed(const Duration(seconds: 1));
        animationController.reset();
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (context) {
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
                        'assets/images/naxir.jpg',
                      ),
                    ),
                    TextFormField(
                      controller: rollNoController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter Student RollNo',
                        labelText: 'RollNo',
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
                      controller: nameController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
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
                      controller: feeController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter Student Fee',
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
                          onPressed: () async {
                            setState(
                              () async {
                                await insertStudent(
                                  Student(
                                    rollNo: int.parse(
                                      rollNoController.text.toString(),
                                    ),
                                    fee: double.parse(
                                      feeController.text.toString(),
                                    ),
                                    name: nameController.text.toString(),
                                  ),
                                ).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Data has been added',
                                      ),
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                }).onError(
                                  (error, stackTrace) {
                                    debugPrint(error.toString());

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Something went wrong',
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: FittedBox(
                            child: Text(
                              'Insert',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      tooltip: 'ADD',
      child: AnimatedIcon(
        icon: isAnimation == isAnimation
            ? AnimatedIcons.add_event
            : AnimatedIcons.close_menu,
        progress: animationController,
      ),
    );
  }
}

deleteUpdateFun(
    {required BuildContext context,
    required VoidCallback delete,
    required VoidCallback edit}) {
  showDialog(
    context: context,
    builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: edit,
            child: Image.asset('assets/images/edit.png'),
          ),
          GestureDetector(
            onTap: delete,
            child: Image.asset('assets/images/delete.png'),
          ),
        ],
      );
    },
  );
}
