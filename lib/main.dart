import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:settyl_assignment/welcome.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    // ignore: prefer_const_constructors
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: "Apis integration",
      home: welcome(),
      
    );
  }
}
