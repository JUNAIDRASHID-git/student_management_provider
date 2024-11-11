import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentmanagement/assets/Controllers/controller.dart';
import 'package:studentmanagement/functions/db_functions.dart';
import 'package:studentmanagement/screens/student_add.dart';
import 'package:studentmanagement/screens/student_edit.dart';
import 'package:studentmanagement/screens/student_profile.dart';
import 'package:studentmanagement/screens/student_search.dart';

class StudentslistScreen extends StatelessWidget {
  StudentslistScreen({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Access the Controller through Provider
    final controller = Provider.of<Controller>(context, listen: false);
    controller.getAllStudent(); // Fetch students when the screen is built

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student List',
          style: TextStyle(color: Colors.white, fontSize: 27),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StudentSearch()),
              );
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            highlightColor: Colors.deepPurple[100],
            iconSize: 35,
          )
        ],
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: const Color.fromARGB(255, 158, 135, 198),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const StudentAddScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Consumer<Controller>(
          builder: (context, controller, child) {
            return ListView.builder(
              itemCount: controller.studentList.length,
              itemBuilder: (context, index) {
                final data = controller.studentList[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    color: const Color.fromARGB(247, 255, 255, 255),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => StudentProfileScreen(
                              studentDetails: data,
                            ),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundImage: data.img.isEmpty
                            ? const AssetImage('lib/assets/profile_icon3.png')
                                as ImageProvider
                            : FileImage(File(data.img)),
                        radius: 29,
                      ),
                      title: Text(
                        data.name.toUpperCase(),
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text("Age : ${data.age}"),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => StudentEdit(
                                      studentrecord: data,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit_document),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Do you want to Delete"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          deleteStudent(data.id!);
                                          controller.getAllStudent();
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Yes'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('No'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.delete_forever,
                                color: Color.fromARGB(255, 194, 52, 42),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
