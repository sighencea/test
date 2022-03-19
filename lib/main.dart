import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_ui_example/page/home_page.dart';
import 'package:todo_app_ui_example/provider/todos.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseApp app = await Firebase.initializeApp();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Sighencea\'s Shopping App';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => TodosProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            scaffoldBackgroundColor: Colors.white12,
          ),
          home: HomePage(),
        ),
      );
}

// PART 1
// continue at DONE
// video link https://www.youtube.com/watch?v=kN9Yfd4fu04

// PART 2
// continue at 17:00
// video link https://www.youtube.com/watch?v=cltCpXY60Sk

// test git change
