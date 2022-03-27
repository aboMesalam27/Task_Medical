import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'all_screens/login_screen.dart';
import 'all_screens/main_screen.dart';
import 'all_screens/register_screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const TaskLaCaseCode());
}

DatabaseReference userRef =
    FirebaseDatabase.instance.reference().child('users');
 class TaskLaCaseCode extends StatefulWidget {
  const TaskLaCaseCode({Key? key}) : super(key: key);

  @override
  _TaskLaCaseCodeState createState() => _TaskLaCaseCodeState();
}

class _TaskLaCaseCodeState extends State<TaskLaCaseCode> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskLaCaseCode',
       home: FirebaseAuth.instance.currentUser == null
          ? LoginScreen()
          :MainScreen(),

      routes: {
        RegisterScreen.idScreen: (context) => RegisterScreen(),
        LoginScreen.idScreen: (context) => LoginScreen(),
       },
    );
  }
}
