import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:wordgame/huddleprovider.dart';
import 'package:wordgame/wordhuddlepage.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => huddleProvider(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark
          ),
        useMaterial3: true,
      ),
      builder: EasyLoading.init(),
      home: const WordHuddlePage(),
    );
  }
}
