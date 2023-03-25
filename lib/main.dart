import 'package:exam_march/pages/add_Card_Page.dart';
import 'package:exam_march/pages/cards_page.dart';
import 'package:exam_march/storages.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'models/card_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  //user = await Hive.openBox('user');

  box = await Hive.openBox('box');
  Hive.registerAdapter(CardModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:CardsPage(),
      routes: {
        "/AddCardPage":(context)=>AddCardPage(),
      },
    );
  }
}


