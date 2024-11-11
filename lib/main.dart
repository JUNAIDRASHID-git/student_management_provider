import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentmanagement/assets/Controllers/controller.dart';
import 'package:studentmanagement/functions/db_functions.dart';
import 'package:studentmanagement/screens/student_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDataBase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Controller()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: StudentslistScreen(),
      ),
    );
  }
}
