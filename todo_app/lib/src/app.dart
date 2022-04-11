import 'package:flutter/material.dart';
import 'package:todo_app/src/screens/auth_screen.dart';


/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(),

    );
  }
}
